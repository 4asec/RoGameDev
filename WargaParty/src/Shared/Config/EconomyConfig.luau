--!strict
--[[
    EconomyConfig.luau
    Financial models, starting balances, bank loans, and dice speculation formulas.
]]

local EconomyConfig = {
    -- Starting Match Cash
    StartingCash = 10000000, -- Rp 10,000,000
    CheckpointPassSalary = 2000000, -- Rp 2,000,000 (Gajian)
    
    -- Bank Loan Rules
    Bank = {
        MaxSimultaneousLoans = 3,
        MaxTotalDebtCap = 10000000, -- Rp 10,000,000
        DefaultInterestRatePerTurn = 0.05, -- 5% interest per turn
        LoanDenominations = { 1000000, 2500000, 5000000 },
        EmergencyLoanInterestRate = 0.08, -- 8% for automatic overdraft
    },
    
    -- Dice Investment System
    DiceInvestment = {
        MaxActiveInvestmentsPerPlayer = 2,
        DurationRounds = 3,
        Tiers = {
            { Cost = 500000, Multiplier = 3.0 }, -- Rp 500k -> Rp 1.5M per hit
            { Cost = 1000000, Multiplier = 3.0 }, -- Rp 1.0M -> Rp 3.0M per hit
        }
    },
    
    -- Meta Currency Rewards
    MetaRewards = {
        FirstPlaceCoins = 500,
        SecondPlaceCoins = 300,
        ThirdPlaceCoins = 150,
        ParticipationCoins = 75,
        GoldRewardFirstPlace = 5,
    }
}

return table.freeze(EconomyConfig)
