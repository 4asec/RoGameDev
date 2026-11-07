--!strict
--[[
    DiceService.luau
    Server-authoritative dice rolling engine with secure randomness.
]]

local DiceService = {}
DiceService.__index = DiceService

local rng = Random.new()

function DiceService.Roll(): number
    return rng:NextInteger(1, 6)
end

function DiceService.RollMultiple(count: number): { number }
    local results = {}
    for i = 1, count do
        table.insert(results, rng:NextInteger(1, 6))
    end
    return results
end

return DiceService
