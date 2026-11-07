--!strict
--[[
    RemoteDefinitions.luau
    Central registry for network remotes across client and server.
]]

local RemoteDefinitions = {
    Events = {
        -- Match lifecycle
        "MatchStateChanged",      -- (newState: string, payload: table)
        "TurnStarted",            -- (activePlayerId: number, turnTimeLimit: number)
        "TurnEnded",              -- (previousPlayerId: number)
        "DiceRolled",             -- (playerId: number, diceValue: number)
        "PlayerMoved",            -- (playerId: number, pathNodes: {string}, finalNodeId: string)
        "BranchPromptRequested",  -- (options: {{ branchIndex: number, nextNodeId: string, label: string }})
        "EventTriggered",         -- (eventId: string, targetPlayerIds: {number})
        "PlayerConnectionChanged",-- (playerId: number, isConnected: boolean, isOut: boolean)
        
        -- Client requests
        "RequestRollDice",        -- ()
        "RequestSelectBranch",    -- (branchIndex: number)
    },
    
    Functions = {
        "RequestBuyProperty",     -- (nodeId: string) -> (success: boolean, reason: string?)
        "RequestUpgradeProperty", -- (nodeId: string) -> (success: boolean, reason: string?)
        "RequestBankLoan",        -- (amount: number) -> (success: boolean, reason: string?)
        "RequestRepayLoan",       -- (loanId: string, amount: number) -> (success: boolean, reason: string?)
        "RequestDiceInvestment",  -- (diceNumber: number, tierIndex: number) -> (success: boolean, reason: string?)
        "GetMatchSnapshot",       -- () -> (snapshot: table)
    }
}

return table.freeze(RemoteDefinitions)
