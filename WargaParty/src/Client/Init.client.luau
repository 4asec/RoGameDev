--!strict
--[[
    Init.client.luau
    Client bootstrap: initializes CameraController, UIController, BoardVisualController, and network listeners.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CameraController = require(script.Controllers.CameraController)
local UIController = require(script.Controllers.UIController)
local BoardVisualController = require(script.Controllers.BoardVisualController)
local BoardTypes = require(ReplicatedStorage.WargaPartyShared.Types.BoardTypes)
local EventConfig = require(ReplicatedStorage.WargaPartyShared.Config.EventConfig)

local localPlayer = Players.LocalPlayer

print("[WargaParty Client] Initializing Client Controllers...")

-- 1. Initialize Visuals & UI
BoardVisualController.Initialize()
UIController.Initialize()
CameraController.Initialize()

-- 2. Wait for Network Remotes
local remotesFolder = ReplicatedStorage:WaitForChild("WargaPartyRemotes") :: Folder
local matchStateChanged = remotesFolder:WaitForChild("MatchStateChanged") :: RemoteEvent
local turnStarted = remotesFolder:WaitForChild("TurnStarted") :: RemoteEvent
local turnEnded = remotesFolder:WaitForChild("TurnEnded") :: RemoteEvent
local diceRolled = remotesFolder:WaitForChild("DiceRolled") :: RemoteEvent
local playerMoved = remotesFolder:WaitForChild("PlayerMoved") :: RemoteEvent
local branchPrompt = remotesFolder:WaitForChild("BranchPromptRequested") :: RemoteEvent
local eventTriggered = remotesFolder:WaitForChild("EventTriggered") :: RemoteEvent

local reqRoll = remotesFolder:WaitForChild("RequestRollDice") :: RemoteEvent
local reqBranch = remotesFolder:WaitForChild("RequestSelectBranch") :: RemoteEvent

-- 3. Wire Roll Dice Button
local rollBtn = UIController.GetRollButton()
if rollBtn then
    rollBtn.MouseButton1Click:Connect(function()
        rollBtn.Visible = false
        reqRoll:FireServer()
    end)
end

-- 4. Listen to Turn Signals
turnStarted.OnClientEvent:Connect(function(activeUserId: number, timeLimit: number)
    local isMyTurn = (activeUserId == localPlayer.UserId)
    local activePlayer = Players:GetPlayerByUserId(activeUserId)
    local displayName = activePlayer and activePlayer.DisplayName or "Pemain " .. activeUserId
    
    UIController.SetTurnState(isMyTurn, displayName, timeLimit)
    
    if activePlayer and activePlayer.Character then
        CameraController.FollowCharacter(activePlayer.Character)
    end
end)

-- 5. Listen to Dice Rolls
diceRolled.OnClientEvent:Connect(function(userId: number, diceVal: number)
    print(string.format("[WargaParty Client] Player %d melempar dadu: %d!", userId, diceVal))
end)

-- 6. Listen to Movement
playerMoved.OnClientEvent:Connect(function(userId: number, pathNodeIds: { string }, finalNodeId: string)
    local movingPlayer = Players:GetPlayerByUserId(userId)
    if not movingPlayer then return end
    
    -- Gather positions from Workspace visual tiles
    local boardFolder = game.Workspace:FindFirstChild("WargaPartyBoard")
    if boardFolder then
        local positions = {}
        for _, id in ipairs(pathNodeIds) do
            local tile = boardFolder:FindFirstChild(id) :: BasePart
            if tile then
                table.insert(positions, tile.Position)
            end
        end
        BoardVisualController.AnimatePlayerMovement(movingPlayer, positions)
    end
end)

-- 7. Listen to Branch Prompts at Intersections
branchPrompt.OnClientEvent:Connect(function(options: { { branchIndex: number, label: string } })
    UIController.ShowBranchPrompt(options, function(selectedBranchIndex: number)
        reqBranch:FireServer(selectedBranchIndex)
    end)
end)

-- 8. Listen to Absurd Events
eventTriggered.OnClientEvent:Connect(function(eventId: string, targetUserIds: { number })
    local def = EventConfig.Catalog[eventId]
    if def then
        UIController.ShowEventPopup(def.Title, def.Description)
    end
end)

-- 9. Listen to Match State
matchStateChanged.OnClientEvent:Connect(function(state: string, data: any)
    print("[WargaParty Client] Match state updated: " .. state)
end)

print("[WargaParty Client] Client Systems Successfully Ready!")
