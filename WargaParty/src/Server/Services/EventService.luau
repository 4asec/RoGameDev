--!strict
--[[
    EventService.luau
    Absurd Indonesian random events and government policy execution.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventConfig = require(ReplicatedStorage.WargaPartyShared.Config.EventConfig)
local EconomyService = require(script.Parent.EconomyService)

type EventDef = EventConfig.EventDef

local EventService = {}
EventService.__index = EventService

local activePolicies: { [string]: { EventDef: EventDef, RemainingRounds: number } } = {}
local rng = Random.new()

function EventService.PickRandomEvent(): EventDef
    local totalWeight = 0
    for _, weight in pairs(EventConfig.RarityWeights) do
        totalWeight += weight
    end
    
    local roll = rng:NextNumber(0, totalWeight)
    local cumulative = 0
    local targetRarity = "Common"
    
    for rarity, weight in pairs(EventConfig.RarityWeights) do
        cumulative += weight
        if roll <= cumulative then
            targetRarity = rarity
            break
        end
    end
    
    -- Filter events with matching rarity
    local pool: { EventDef } = {}
    for _, def in pairs(EventConfig.Catalog) do
        if def.Rarity == targetRarity then
            table.insert(pool, def)
        end
    end
    
    if #pool == 0 then
        return EventConfig.Catalog.EVT_PARKIR_GAIB
    end
    
    return pool[rng:NextInteger(1, #pool)]
end

function EventService.TriggerEvent(eventDef: EventDef, activeUserId: number, allUserIds: { number }): { [string]: any }
    local result = {
        EventId = eventDef.Id,
        Title = eventDef.Title,
        Description = eventDef.Description,
        Rarity = eventDef.Rarity,
        EffectType = eventDef.EffectType,
        TargetUserIds = {} :: { number },
    }
    
    if eventDef.EffectType == "CashDelta" and eventDef.Amount then
        if eventDef.Scope == "ActivePlayer" then
            table.insert(result.TargetUserIds, activeUserId)
            if eventDef.Amount > 0 then
                EconomyService.Deposit(activeUserId, eventDef.Amount)
            else
                EconomyService.Withdraw(activeUserId, math.abs(eventDef.Amount))
            end
        elseif eventDef.Scope == "LowestBalancePlayer" then
            local lowestUser = activeUserId
            local lowestBalance = math.huge
            for _, uId in ipairs(allUserIds) do
                local bal = EconomyService.GetBalance(uId)
                if bal < lowestBalance then
                    lowestBalance = bal
                    lowestUser = uId
                end
            end
            table.insert(result.TargetUserIds, lowestUser)
            if eventDef.Amount > 0 then
                EconomyService.Deposit(lowestUser, eventDef.Amount)
            end
        end
    elseif eventDef.EffectType == "FreezeInterest" or eventDef.EffectType == "DoubleFines" then
        -- Add to active policies
        activePolicies[eventDef.Id] = {
            EventDef = eventDef,
            RemainingRounds = eventDef.DurationRounds or 2
        }
        result.TargetUserIds = allUserIds
    end
    
    return result
end

function EventService.IsInterestFrozen(): boolean
    return activePolicies["EVT_PEMUTIHAN_PAJAK"] ~= nil
end

function EventService.GetFineMultiplier(): number
    if activePolicies["EVT_INFLASI_SEMBILAN_BAHAN"] then
        return 2.0
    end
    return 1.0
end

function EventService.AdvanceRound()
    for id, policy in pairs(activePolicies) do
        policy.RemainingRounds -= 1
        if policy.RemainingRounds <= 0 then
            activePolicies[id] = nil
        end
    end
end

function EventService.Reset()
    table.clear(activePolicies)
end

return EventService
