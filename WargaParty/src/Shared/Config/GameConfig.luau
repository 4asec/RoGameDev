--!strict
--[[
    GameConfig.luau
    Central match and game balance parameters for Warga Party
]]

local GameConfig = {
    -- Match parameters
    MinPlayers = 2,
    MaxStandardPlayers = 6,
    MaxCustomRoomPlayers = 12,
    
    -- Turn parameters
    TurnDurationSeconds = 25,
    GracePeriodMinutes = 7,
    GracePeriodSeconds = 7 * 60,
    
    -- Target map
    DefaultCity = "Jakarta",
    AvailableCities = { "Jakarta", "Yogyakarta", "Surabaya", "Bali" },
    
    -- Timing
    DiceAnimationTime = 1.8,
    TileStepDuration = 0.35,
    IntersectionSelectionTime = 15,
    
    -- Finish rules
    FinishOrderBonuses = {
        [1] = 5000000, -- 1st place: Rp 5M bonus
        [2] = 3000000, -- 2nd place: Rp 3M bonus
        [3] = 1000000, -- 3rd place: Rp 1M bonus
    },
    
    -- Scoring formula weights
    Scoring = {
        CashWeight = 1.0,
        PropertyWeight = 1.2,
        InvestmentNetWeight = 1.0,
        UnpaidDebtPenaltyMultiplier = 1.5,
    }
}

return table.freeze(GameConfig)
