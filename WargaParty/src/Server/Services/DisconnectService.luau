--!strict
--[[
    DisconnectService.luau
    Monitors player connections, maintains 7-minute grace timers, and coordinates AI fallback.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage.WargaPartyShared.Config.GameConfig)
local MatchTypes = require(ReplicatedStorage.WargaPartyShared.Types.MatchTypes)

type MatchPlayerState = MatchTypes.MatchPlayerState

local DisconnectService = {}
DisconnectService.__index = DisconnectService

local disconnectTimers: { [number]: number } = {} -- userId -> timestamp of disconnect

function DisconnectService.OnPlayerDisconnected(userId: number, playerState: MatchPlayerState)
    playerState.IsConnected = false
    playerState.DisconnectTime = os.time()
    disconnectTimers[userId] = os.time()
end

function DisconnectService.OnPlayerReconnected(userId: number, playerState: MatchPlayerState): boolean
    if disconnectTimers[userId] then
        local elapsed = os.time() - disconnectTimers[userId]
        if elapsed <= GameConfig.GracePeriodSeconds then
            playerState.IsConnected = true
            playerState.DisconnectTime = nil
            disconnectTimers[userId] = nil
            return true -- Successfully restored
        else
            playerState.IsOut = true
            disconnectTimers[userId] = nil
            return false -- Exceeded grace period
        end
    end
    return false
end

function DisconnectService.CheckGracePeriods(players: { MatchPlayerState })
    local now = os.time()
    for userId, discTime in pairs(disconnectTimers) do
        if (now - discTime) > GameConfig.GracePeriodSeconds then
            for _, player in ipairs(players) do
                if player.UserId == userId then
                    player.IsOut = true
                    disconnectTimers[userId] = nil
                    break
                end
            end
        end
    end
end

function DisconnectService.Reset()
    table.clear(disconnectTimers)
end

return DisconnectService
