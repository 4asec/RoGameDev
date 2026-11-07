--!strict
--[[
    InvestmentService.luau
    Dice speculation market: players bet on dice outcomes over 3 rounds and receive dividends.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EconomyConfig = require(ReplicatedStorage.WargaPartyShared.Config.EconomyConfig)
local MatchTypes = require(ReplicatedStorage.WargaPartyShared.Types.MatchTypes)
local EconomyService = require(script.Parent.EconomyService)

type InvestmentRecord = MatchTypes.InvestmentRecord

local InvestmentService = {}
InvestmentService.__index = InvestmentService

local playerInvestments: { [number]: { InvestmentRecord } } = {}

function InvestmentService.GetInvestments(userId: number): { InvestmentRecord }
    if not playerInvestments[userId] then
        playerInvestments[userId] = {}
    end
    return playerInvestments[userId]
end

function InvestmentService.CreateInvestment(userId: number, diceNumber: number, tierIndex: number): (boolean, string?)
    if diceNumber < 1 or diceNumber > 6 then
        return false, "INVALID_DICE_NUMBER"
    end
    
    local tier = EconomyConfig.DiceInvestment.Tiers[tierIndex]
    if not tier then
        return false, "INVALID_TIER"
    end
    
    local active = InvestmentService.GetInvestments(userId)
    if #active >= EconomyConfig.DiceInvestment.MaxActiveInvestmentsPerPlayer then
        return false, "MAX_INVESTMENTS_EXCEEDED"
    end
    
    local balance = EconomyService.GetBalance(userId)
    if balance < tier.Cost then
        return false, "INSUFFICIENT_FUNDS"
    end
    
    local success, _ = EconomyService.Withdraw(userId, tier.Cost)
    if not success then
        return false, "WITHDRAW_FAILED"
    end
    
    local newRecord: InvestmentRecord = {
        DiceNumber = diceNumber,
        TicketCost = tier.Cost,
        Multiplier = tier.Multiplier,
        RoundsRemaining = EconomyConfig.DiceInvestment.DurationRounds,
        TotalEarnings = 0,
    }
    
    table.insert(active, newRecord)
    return true, nil
end

-- Evaluates dividends whenever ANY player rolls a dice value
function InvestmentService.OnDiceRolled(rolledNumber: number)
    for userId, investments in pairs(playerInvestments) do
        for _, inv in ipairs(investments) do
            if inv.DiceNumber == rolledNumber and inv.RoundsRemaining > 0 then
                local payout = math.floor(inv.TicketCost * inv.Multiplier)
                inv.TotalEarnings += payout
                EconomyService.Deposit(userId, payout)
            end
        end
    end
end

-- Advances round countdown for a specific player at end of their turn
function InvestmentService.OnPlayerTurnEnded(userId: number)
    local investments = playerInvestments[userId]
    if not investments then return end
    
    for i = #investments, 1, -1 do
        local inv = investments[i]
        inv.RoundsRemaining -= 1
        if inv.RoundsRemaining <= 0 then
            table.remove(investments, i)
        end
    end
end

function InvestmentService.Reset()
    table.clear(playerInvestments)
end

return InvestmentService
