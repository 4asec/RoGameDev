--!strict
--[[
    TurnService.luau
    Manages sequential player turns, 25-second turn timers, and turn transitions.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage.WargaPartyShared.Config.GameConfig)
local MatchTypes = require(ReplicatedStorage.WargaPartyShared.Types.MatchTypes)

type MatchPlayerState = MatchTypes.MatchPlayerState

local TurnService = {}
TurnService.__index = TurnService

local activePlayerIndex: number = 1
local currentRound: number = 1
local turnStartTime: number = 0

function TurnService.StartTurn(player: MatchPlayerState): number
    turnStartTime = os.time()
    return GameConfig.TurnDurationSeconds
end

function TurnService.GetTimeRemaining(): number
    local elapsed = os.time() - turnStartTime
    return math.max(0, GameConfig.TurnDurationSeconds - elapsed)
end

function TurnService.HasTurnTimedOut(): boolean
    return TurnService.GetTimeRemaining() <= 0
end

-- Advances to next eligible player who is neither Out nor Finished
function TurnService.AdvanceTurn(players: { MatchPlayerState }): (number, boolean)
    if #players == 0 then return 1, false end
    
    local startingIndex = activePlayerIndex
    local allCompleted = true
    
    for i = 1, #players do
        local nextIndex = (startingIndex - 1 + i) % #players + 1
        local candidate = players[nextIndex]
        
        if not candidate.IsOut and not candidate.HasFinished then
            activePlayerIndex = nextIndex
            allCompleted = false
            
            -- If we wrapped around to player 1 or lower index, increment round
            if nextIndex <= startingIndex then
                currentRound += 1
            end
            break
        end
    end
    
    return activePlayerIndex, allCompleted
end

function TurnService.GetCurrentRound(): number
    return currentRound
end

function TurnService.GetActiveIndex(): number
    return activePlayerIndex
end

function TurnService.Reset()
    activePlayerIndex = 1
    currentRound = 1
    turnStartTime = 0
end

return TurnService
