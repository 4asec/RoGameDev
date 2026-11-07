--!strict
--[[
    MatchTypes.luau
    Types for match states, player data, loans, investments, and standings.
]]

export type LoanRecord = {
    Id: string,
    Principal: number,
    AccumulatedInterest: number,
    InterestRate: number,
    CreatedAtRound: number,
}

export type InvestmentRecord = {
    DiceNumber: number,
    TicketCost: number,
    Multiplier: number,
    RoundsRemaining: number,
    TotalEarnings: number,
}

export type MatchPlayerState = {
    UserId: number,
    DisplayName: string,
    SlotIndex: number,
    Cash: number,
    CurrentNodeId: string,
    IsConnected: boolean,
    IsOut: boolean,
    HasFinished: boolean,
    FinishOrder: number?,
    DisconnectTime: number?,
    Loans: { LoanRecord },
    Investments: { InvestmentRecord },
    OwnedProperties: { string }, -- List of Property IDs
}

export type MatchStatus = "WaitingInLobby" | "TrainCinematic" | "InGameTurns" | "PodiumCelebration" | "MatchEnded"

return nil
