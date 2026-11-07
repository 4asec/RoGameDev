--!strict
--[[
    AIPlayerService.luau
    Autonomous bot controller that takes conservative, fair turns for disconnected or filler players.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoardTypes = require(ReplicatedStorage.WargaPartyShared.Types.BoardTypes)

type BoardNode = BoardTypes.BoardNode

local AIPlayerService = {}
AIPlayerService.__index = AIPlayerService

function AIPlayerService.ChooseBranch(options: { string }): number
    -- Heuristic: pick the first route (typically the safer main road)
    if #options == 0 then return 1 end
    return 1
end

function AIPlayerService.ShouldBuyProperty(cash: number, propertyPrice: number): boolean
    -- Only buy if player maintains at least Rp 2,000,000 cash buffer
    return (cash - propertyPrice) >= 2000000
end

function AIPlayerService.ShouldTakeLoan(cash: number, emergencyNeeded: number): boolean
    -- Only take loan if strictly necessary for emergency payment
    return cash < emergencyNeeded
end

return AIPlayerService
