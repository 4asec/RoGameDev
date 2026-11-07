--!strict
--[[
    PropertyService.luau
    Property acquisition, tier 1-3 upgrades, rent calculation and collection.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PropertyConfig = require(ReplicatedStorage.WargaPartyShared.Config.PropertyConfig)
local EconomyService = require(script.Parent.EconomyService)

type PropertyDef = PropertyConfig.PropertyDef

export type PropertyState = {
    PropertyId: string,
    OwnerUserId: number?,
    UpgradeLevel: number, -- 1, 2, or 3
}

local PropertyService = {}
PropertyService.__index = PropertyService

local propertyStates: { [string]: PropertyState } = {}

function PropertyService.Initialize()
    table.clear(propertyStates)
    for id, _ in pairs(PropertyConfig.Catalog) do
        propertyStates[id] = {
            PropertyId = id,
            OwnerUserId = nil,
            UpgradeLevel = 1,
        }
    end
end

function PropertyService.GetPropertyState(propertyId: string): PropertyState?
    return propertyStates[propertyId]
end

function PropertyService.BuyProperty(userId: number, propertyId: string): (boolean, string?)
    local state = propertyStates[propertyId]
    local def = PropertyConfig.Catalog[propertyId]
    if not state or not def then
        return false, "PROPERTY_NOT_FOUND"
    end
    
    if state.OwnerUserId ~= nil then
        return false, "ALREADY_OWNED"
    end
    
    local balance = EconomyService.GetBalance(userId)
    if balance < def.Price then
        return false, "INSUFFICIENT_FUNDS"
    end
    
    local success, _ = EconomyService.Withdraw(userId, def.Price)
    if success then
        state.OwnerUserId = userId
        state.UpgradeLevel = 1
        return true, nil
    end
    
    return false, "TRANSACTION_FAILED"
end

function PropertyService.UpgradeProperty(userId: number, propertyId: string): (boolean, string?)
    local state = propertyStates[propertyId]
    local def = PropertyConfig.Catalog[propertyId]
    if not state or not def then
        return false, "PROPERTY_NOT_FOUND"
    end
    
    if state.OwnerUserId ~= userId then
        return false, "NOT_OWNER"
    end
    
    if state.UpgradeLevel >= 3 then
        return false, "MAX_LEVEL_REACHED"
    end
    
    local nextLevel = state.UpgradeLevel + 1
    local cost = def.UpgradeTiers[nextLevel] or 1000000
    
    local balance = EconomyService.GetBalance(userId)
    if balance < cost then
        return false, "INSUFFICIENT_FUNDS"
    end
    
    local success, _ = EconomyService.Withdraw(userId, cost)
    if success then
        state.UpgradeLevel = nextLevel
        return true, nil
    end
    
    return false, "TRANSACTION_FAILED"
end

function PropertyService.CalculateRent(propertyId: string, policyMultiplier: number?): number
    local state = propertyStates[propertyId]
    local def = PropertyConfig.Catalog[propertyId]
    if not state or not def then return 0 end
    
    local multiplier = policyMultiplier or 1.0
    local upgradeBoost = 1 + (state.UpgradeLevel - 1) * PropertyConfig.UpgradeMultiplier
    local rent = def.BaseRent * upgradeBoost * multiplier
    return math.floor(rent)
end

function PropertyService.CollectRent(visitorUserId: number, propertyId: string, policyMultiplier: number?): number
    local state = propertyStates[propertyId]
    if not state or not state.OwnerUserId or state.OwnerUserId == visitorUserId then
        return 0
    end
    
    local rent = PropertyService.CalculateRent(propertyId, policyMultiplier)
    local success, deficit = EconomyService.Withdraw(visitorUserId, rent)
    
    local actualCollected = rent
    if not success then
        actualCollected = rent - deficit
    end
    
    EconomyService.Deposit(state.OwnerUserId, actualCollected)
    return actualCollected
end

function PropertyService.GetTotalEquity(userId: number): number
    local total = 0
    for propId, state in pairs(propertyStates) do
        if state.OwnerUserId == userId then
            local def = PropertyConfig.Catalog[propId]
            if def then
                total += def.Price
                for lvl = 2, state.UpgradeLevel do
                    total += (def.UpgradeTiers[lvl] or 0)
                end
            end
        end
    end
    return total
end

return PropertyService
