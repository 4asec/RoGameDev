--!strict
--[[
    Init.server.luau
    Server entry point: instantiates network remotes, wires services, and binds player connections.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteDefinitions = require(ReplicatedStorage.WargaPartyShared.Network.RemoteDefinitions)
local MatchService = require(script.Services.MatchService)
local PropertyService = require(script.Services.PropertyService)
local BankService = require(script.Services.BankService)
local InvestmentService = require(script.Services.InvestmentService)
local TurnService = require(script.Services.TurnService)
local DisconnectService = require(script.Services.DisconnectService)
local PlayerDataService = require(script.Services.PlayerDataService)

print("[WargaParty Server] Initializing Server Systems...")

-- 1. Create Remotes Folder in ReplicatedStorage
local remotesFolder = ReplicatedStorage:FindFirstChild("WargaPartyRemotes")
if not remotesFolder then
    remotesFolder = Instance.new("Folder")
    remotesFolder.Name = "WargaPartyRemotes"
    remotesFolder.Parent = ReplicatedStorage
end

for _, eventName in ipairs(RemoteDefinitions.Events) do
    if not remotesFolder:FindFirstChild(eventName) then
        local remote = Instance.new("RemoteEvent")
        remote.Name = eventName
        remote.Parent = remotesFolder
    end
end

for _, funcName in ipairs(RemoteDefinitions.Functions) do
    if not remotesFolder:FindFirstChild(funcName) then
        local remote = Instance.new("RemoteFunction")
        remote.Name = funcName
        remote.Parent = remotesFolder
    end
end

-- 2. Initialize Match Services
MatchService.Initialize()

-- 3. Bind Remote Functions
local reqBuy = remotesFolder:FindFirstChild("RequestBuyProperty") :: RemoteFunction
if reqBuy then
    reqBuy.OnServerInvoke = function(player: Player, propertyId: string)
        return PropertyService.BuyProperty(player.UserId, propertyId)
    end
end

local reqUpgrade = remotesFolder:FindFirstChild("RequestUpgradeProperty") :: RemoteFunction
if reqUpgrade then
    reqUpgrade.OnServerInvoke = function(player: Player, propertyId: string)
        return PropertyService.UpgradeProperty(player.UserId, propertyId)
    end
end

local reqLoan = remotesFolder:FindFirstChild("RequestBankLoan") :: RemoteFunction
if reqLoan then
    reqLoan.OnServerInvoke = function(player: Player, amount: number)
        return BankService.RequestLoan(player.UserId, amount, TurnService.GetCurrentRound())
    end
end

local reqRepay = remotesFolder:FindFirstChild("RequestRepayLoan") :: RemoteFunction
if reqRepay then
    reqRepay.OnServerInvoke = function(player: Player, loanId: string, amount: number)
        return BankService.RepayLoan(player.UserId, loanId, amount)
    end
end

local reqInvest = remotesFolder:FindFirstChild("RequestDiceInvestment") :: RemoteFunction
if reqInvest then
    reqInvest.OnServerInvoke = function(player: Player, diceNumber: number, tierIndex: number)
        return InvestmentService.CreateInvestment(player.UserId, diceNumber, tierIndex)
    end
end

-- 4. Bind Remote Events
local reqRoll = remotesFolder:FindFirstChild("RequestRollDice") :: RemoteEvent
if reqRoll then
    reqRoll.OnServerEvent:Connect(function(player: Player)
        MatchService.ExecuteTurnRoll(player.UserId)
    end)
end

local reqBranch = remotesFolder:FindFirstChild("RequestSelectBranch") :: RemoteEvent
if reqBranch then
    reqBranch.OnServerEvent:Connect(function(player: Player, branchIndex: number)
        MatchService.SelectBranch(player.UserId, branchIndex)
    end)
end

-- 5. Player Lifecycle Listeners
Players.PlayerAdded:Connect(function(player: Player)
    PlayerDataService.LoadData(player.UserId)
    MatchService.AddPlayer(player)
    
    -- Auto-start match if 2+ players or 5s after first player in testing
    task.delay(4, function()
        MatchService.StartMatch()
    end)
end)

Players.PlayerRemoving:Connect(function(player: Player)
    local state = MatchService.GetPlayerState(player.UserId)
    if state then
        DisconnectService.OnPlayerDisconnected(player.UserId, state)
    end
    PlayerDataService.UnloadPlayer(player.UserId)
end)

print("[WargaParty Server] Server Systems Successfully Loaded and Ready!")
