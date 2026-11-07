--!strict
--[[
    EconomyService.luau
    Transactional player balance management, overdraft guarantees, and final score calculations.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EconomyConfig = require(ReplicatedStorage.WargaPartyShared.Config.EconomyConfig)
local GameConfig = require(ReplicatedStorage.WargaPartyShared.Config.GameConfig)
local MatchTypes = require(ReplicatedStorage.WargaPartyShared.Types.MatchTypes)

type MatchPlayerState = MatchTypes.MatchPlayerState

local EconomyService = {}
EconomyService.__index = EconomyService

local balances: { [number]: number } = {}

function EconomyService.InitializePlayer(userId: number, initialCash: number?)
    balances[userId] = initialCash or EconomyConfig.StartingCash
end

function EconomyService.GetBalance(userId: number): number
    return balances[userId] or 0
end

function EconomyService.Deposit(userId: number, amount: number)
    if amount <= 0 then return end
    balances[userId] = (balances[userId] or 0) + amount
end

-- Withdraws amount. If balance is insufficient, deducts to 0 and records unpaid deficit.
function EconomyService.Withdraw(userId: number, amount: number): (boolean, number)
    if amount <= 0 then return true, 0 end
    
    local current = balances[userId] or 0
    if current >= amount then
        balances[userId] = current - amount
        return true, 0
    else
        local deficit = amount - current
        balances[userId] = 0
        return false, deficit
    end
end

-- Final cumulative score calculation
function EconomyService.CalculateFinalScore(player: MatchPlayerState, propertyEquity: number): number
    local cash = player.Cash
    local propertyScore = propertyEquity * GameConfig.Scoring.PropertyWeight
    
    -- Net investment score
    local investmentProfit = 0
    for _, inv in ipairs(player.Investments) do
        investmentProfit += inv.TotalEarnings
    end
    
    -- Outstanding debt
    local totalDebt = 0
    for _, loan in ipairs(player.Loans) do
        totalDebt += (loan.Principal + loan.AccumulatedInterest)
    end
    local debtPenalty = totalDebt * GameConfig.Scoring.UnpaidDebtPenaltyMultiplier
    
    -- Finish order bonus
    local finishBonus = 0
    if player.FinishOrder and GameConfig.FinishOrderBonuses[player.FinishOrder] then
        finishBonus = GameConfig.FinishOrderBonuses[player.FinishOrder]
    end
    
    local finalScore = cash + propertyScore + investmentProfit - debtPenalty + finishBonus
    return math.max(0, math.floor(finalScore))
end

function EconomyService.Reset()
    table.clear(balances)
end

return EconomyService
