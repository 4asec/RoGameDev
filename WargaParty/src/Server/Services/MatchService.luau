--!strict
--[[
    MatchService.luau
    Central match lifecycle coordinator, remote request handler, and FINISH evaluator.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.WargaPartyShared.Config.GameConfig)
local EconomyConfig = require(ReplicatedStorage.WargaPartyShared.Config.EconomyConfig)
local MatchTypes = require(ReplicatedStorage.WargaPartyShared.Types.MatchTypes)

local BoardService = require(script.Parent.BoardService)
local MovementService = require(script.Parent.MovementService)
local DiceService = require(script.Parent.DiceService)
local EconomyService = require(script.Parent.EconomyService)
local PropertyService = require(script.Parent.PropertyService)
local BankService = require(script.Parent.BankService)
local InvestmentService = require(script.Parent.InvestmentService)
local EventService = require(script.Parent.EventService)
local TurnService = require(script.Parent.TurnService)
local DisconnectService = require(script.Parent.DisconnectService)
local AIPlayerService = require(script.Parent.AIPlayerService)
local PlayerDataService = require(script.Parent.PlayerDataService)

type MatchPlayerState = MatchTypes.MatchPlayerState
type MatchStatus = MatchTypes.MatchStatus

local MatchService = {}
MatchService.__index = MatchService

local matchStatus: MatchStatus = "WaitingInLobby"
local playersList: { MatchPlayerState } = {}
local finishCounter: number = 0
local pendingBranchState: { [number]: { remainingSteps: number, nextNodes: { string } } } = {}

-- Broadcast helper
local remotesFolder: Folder? = nil

local function getRemotes(): Folder
    if not remotesFolder then
        remotesFolder = ReplicatedStorage:WaitForChild("WargaPartyRemotes") :: Folder
    end
    return remotesFolder :: Folder
end

function MatchService.Initialize()
    PropertyService.Initialize()
    BoardService.LoadJakartaMap()
end

function MatchService.AddPlayer(player: Player): MatchPlayerState
    local state: MatchPlayerState = {
        UserId = player.UserId,
        DisplayName = player.DisplayName,
        SlotIndex = #playersList + 1,
        Cash = EconomyConfig.StartingCash,
        CurrentNodeId = "N_START",
        IsConnected = true,
        IsOut = false,
        HasFinished = false,
        FinishOrder = nil,
        DisconnectTime = nil,
        Loans = BankService.GetPlayerLoans(player.UserId),
        Investments = InvestmentService.GetInvestments(player.UserId),
        OwnedProperties = {},
    }
    
    EconomyService.InitializePlayer(player.UserId, state.Cash)
    table.insert(playersList, state)
    return state
end

function MatchService.GetPlayerState(userId: number): MatchPlayerState?
    for _, p in ipairs(playersList) do
        if p.UserId == userId then
            return p
        end
    end
    return nil
end

function MatchService.GetActivePlayer(): MatchPlayerState?
    local idx = TurnService.GetActiveIndex()
    return playersList[idx]
end

function MatchService.StartMatch()
    if #playersList == 0 then return end
    
    matchStatus = "InGameTurns"
    TurnService.Reset()
    
    local remotes = getRemotes()
    local stateChanged = remotes:FindFirstChild("MatchStateChanged") :: RemoteEvent
    if stateChanged then
        stateChanged:FireAllClients("InGameTurns", { City = "Jakarta" })
    end
    
    MatchService.BeginNextTurn()
end

function MatchService.BeginNextTurn()
    local activePlayer = MatchService.GetActivePlayer()
    if not activePlayer then return end
    
    -- Accrue loan interest if interest is not frozen
    local isFrozen = EventService.IsInterestFrozen()
    BankService.AccrueTurnInterest(activePlayer.UserId, isFrozen)
    
    local remotes = getRemotes()
    local turnStarted = remotes:FindFirstChild("TurnStarted") :: RemoteEvent
    if turnStarted then
        turnStarted:FireAllClients(activePlayer.UserId, GameConfig.TurnDurationSeconds)
    end
    
    TurnService.StartTurn(activePlayer)
    
    -- If player is disconnected, trigger AI turn
    if not activePlayer.IsConnected then
        task.delay(1.5, function()
            MatchService.ExecuteTurnRoll(activePlayer.UserId)
        end)
    end
end

-- Primary turn dice roll execution
function MatchService.ExecuteTurnRoll(userId: number)
    local active = MatchService.GetActivePlayer()
    if not active or active.UserId ~= userId then
        return
    end
    
    local diceVal = DiceService.Roll()
    
    local remotes = getRemotes()
    local diceRolled = remotes:FindFirstChild("DiceRolled") :: RemoteEvent
    if diceRolled then
        diceRolled:FireAllClients(active.UserId, diceVal)
    end
    
    -- Evaluate dice investments
    InvestmentService.OnDiceRolled(diceVal)
    
    -- Calculate movement path
    local traversal = MovementService.CalculatePath(active.CurrentNodeId, diceVal)
    active.CurrentNodeId = traversal.FinalNodeId
    
    local playerMoved = remotes:FindFirstChild("PlayerMoved") :: RemoteEvent
    if playerMoved then
        playerMoved:FireAllClients(active.UserId, traversal.Path, traversal.FinalNodeId)
    end
    
    task.wait(#traversal.Path * GameConfig.TileStepDuration + 0.5)
    
    -- If stopped at branch, request route choice from player
    if traversal.StoppedAtBranch then
        local branchNode = BoardService.GetNode(traversal.FinalNodeId)
        if branchNode and #branchNode.NextNodes > 1 then
            pendingBranchState[active.UserId] = {
                remainingSteps = traversal.RemainingSteps,
                nextNodes = branchNode.NextNodes,
            }
            
            if active.IsConnected then
                local branchPrompt = remotes:FindFirstChild("BranchPromptRequested") :: RemoteEvent
                if branchPrompt then
                    local options = {}
                    for i, nextId in ipairs(branchNode.NextNodes) do
                        local label = (branchNode.BranchLabels and branchNode.BranchLabels[i]) or ("Jalur " .. i)
                        table.insert(options, { branchIndex = i, nextNodeId = nextId, label = label })
                    end
                    local player = Players:GetPlayerByUserId(active.UserId)
                    if player then
                        branchPrompt:FireClient(player, options)
                    end
                end
            else
                -- AI chooses branch
                local choice = AIPlayerService.ChooseBranch(branchNode.NextNodes)
                MatchService.SelectBranch(active.UserId, choice)
            end
            return
        end
    end
    
    -- Resolve landing tile
    MatchService.ResolveLandingTile(active)
    
    -- Conclude turn
    MatchService.EndTurn(active.UserId)
end

function MatchService.SelectBranch(userId: number, branchIndex: number)
    local pending = pendingBranchState[userId]
    local active = MatchService.GetActivePlayer()
    if not pending or not active or active.UserId ~= userId then return end
    
    local chosenNextNodeId = pending.nextNodes[branchIndex] or pending.nextNodes[1]
    pendingBranchState[userId] = nil
    
    active.CurrentNodeId = chosenNextNodeId
    local remaining = math.max(0, pending.remainingSteps - 1)
    
    local remotes = getRemotes()
    local playerMoved = remotes:FindFirstChild("PlayerMoved") :: RemoteEvent
    if playerMoved then
        playerMoved:FireAllClients(active.UserId, { chosenNextNodeId }, chosenNextNodeId)
    end
    
    if remaining > 0 then
        local furtherTraversal = MovementService.CalculatePath(chosenNextNodeId, remaining)
        active.CurrentNodeId = furtherTraversal.FinalNodeId
        if playerMoved then
            playerMoved:FireAllClients(active.UserId, furtherTraversal.Path, furtherTraversal.FinalNodeId)
        end
        task.wait(#furtherTraversal.Path * GameConfig.TileStepDuration + 0.3)
    end
    
    MatchService.ResolveLandingTile(active)
    MatchService.EndTurn(active.UserId)
end

function MatchService.ResolveLandingTile(player: MatchPlayerState)
    local node = BoardService.GetNode(player.CurrentNodeId)
    if not node then return end
    
    if node.NodeType == "Finish" then
        if not player.HasFinished then
            player.HasFinished = true
            finishCounter += 1
            player.FinishOrder = finishCounter
        end
    elseif node.NodeType == "Property" and node.PropertyId then
        -- Collect rent if owned by someone else
        local collected = PropertyService.CollectRent(player.UserId, node.PropertyId)
        player.Cash = EconomyService.GetBalance(player.UserId)
    elseif node.NodeType == "Salary" then
        EconomyService.Deposit(player.UserId, EconomyConfig.CheckpointPassSalary)
        player.Cash = EconomyService.GetBalance(player.UserId)
    elseif node.NodeType == "Toll" and node.TollCost then
        local fineMultiplier = EventService.GetFineMultiplier()
        local cost = math.floor(node.TollCost * fineMultiplier)
        local success, deficit = EconomyService.Withdraw(player.UserId, cost)
        if not success then
            BankService.AddEmergencyDebt(player.UserId, deficit, TurnService.GetCurrentRound())
        end
        player.Cash = EconomyService.GetBalance(player.UserId)
    elseif node.NodeType == "Event" then
        local eventDef = EventService.PickRandomEvent()
        local allIds = {}
        for _, p in ipairs(playersList) do
            table.insert(allIds, p.UserId)
        end
        local result = EventService.TriggerEvent(eventDef, player.UserId, allIds)
        player.Cash = EconomyService.GetBalance(player.UserId)
        
        local remotes = getRemotes()
        local eventTriggered = remotes:FindFirstChild("EventTriggered") :: RemoteEvent
        if eventTriggered then
            eventTriggered:FireAllClients(result.EventId, result.TargetUserIds)
        end
    end
end

function MatchService.EndTurn(userId: number)
    local active = MatchService.GetActivePlayer()
    if not active or active.UserId ~= userId then return end
    
    -- Advance player investments
    InvestmentService.OnPlayerTurnEnded(active.UserId)
    
    -- Advance turn service
    local nextIndex, allCompleted = TurnService.AdvanceTurn(playersList)
    
    if allCompleted then
        MatchService.FinalizeMatch()
    else
        MatchService.BeginNextTurn()
    end
end

-- Evaluates final podium standings when all players finish
function MatchService.FinalizeMatch()
    matchStatus = "PodiumCelebration"
    
    local results = {}
    for _, player in ipairs(playersList) do
        local equity = PropertyService.GetTotalEquity(player.UserId)
        local score = EconomyService.CalculateFinalScore(player, equity)
        table.insert(results, {
            UserId = player.UserId,
            DisplayName = player.DisplayName,
            FinalScore = score,
            Cash = player.Cash,
            FinishOrder = player.FinishOrder or 99,
        })
    end
    
    -- Sort descending by FinalScore
    table.sort(results, function(a, b)
        return a.FinalScore > b.FinalScore
    end)
    
    -- Distribute persistent Coins to players
    for rank, res in ipairs(results) do
        local coins = EconomyConfig.MetaRewards.ParticipationCoins
        if rank == 1 then
            coins = EconomyConfig.MetaRewards.FirstPlaceCoins
        elseif rank == 2 then
            coins = EconomyConfig.MetaRewards.SecondPlaceCoins
        elseif rank == 3 then
            coins = EconomyConfig.MetaRewards.ThirdPlaceCoins
        end
        PlayerDataService.AddCoins(res.UserId, coins)
    end
    
    local remotes = getRemotes()
    local stateChanged = remotes:FindFirstChild("MatchStateChanged") :: RemoteEvent
    if stateChanged then
        stateChanged:FireAllClients("PodiumCelebration", {
            Standings = results,
            MonkeySmileWinner = results[#results], -- Humorous award for lowest score!
        })
    end
end

return MatchService
