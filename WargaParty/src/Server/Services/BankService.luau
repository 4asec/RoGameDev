--!strict
--[[
    BankService.luau
    Bank loans, interest accrual, debt tag tracking, and partial/full repayments.
]]

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EconomyConfig = require(ReplicatedStorage.WargaPartyShared.Config.EconomyConfig)
local MatchTypes = require(ReplicatedStorage.WargaPartyShared.Types.MatchTypes)
local EconomyService = require(script.Parent.EconomyService)

type LoanRecord = MatchTypes.LoanRecord

local BankService = {}
BankService.__index = BankService

local playerLoans: { [number]: { LoanRecord } } = {}

function BankService.GetPlayerLoans(userId: number): { LoanRecord }
    if not playerLoans[userId] then
        playerLoans[userId] = {}
    end
    return playerLoans[userId]
end

function BankService.GetTotalDebt(userId: number): number
    local loans = BankService.GetPlayerLoans(userId)
    local total = 0
    for _, loan in ipairs(loans) do
        total += (loan.Principal + loan.AccumulatedInterest)
    end
    return total
end

function BankService.RequestLoan(userId: number, amount: number, currentRound: number): (boolean, string?)
    local loans = BankService.GetPlayerLoans(userId)
    
    if #loans >= EconomyConfig.Bank.MaxSimultaneousLoans then
        return false, "MAX_LOANS_EXCEEDED"
    end
    
    local currentDebt = BankService.GetTotalDebt(userId)
    if (currentDebt + amount) > EconomyConfig.Bank.MaxTotalDebtCap then
        return false, "DEBT_CAP_EXCEEDED"
    end
    
    local newLoan: LoanRecord = {
        Id = "LOAN_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Principal = amount,
        AccumulatedInterest = 0,
        InterestRate = EconomyConfig.Bank.DefaultInterestRatePerTurn,
        CreatedAtRound = currentRound,
    }
    
    table.insert(loans, newLoan)
    EconomyService.Deposit(userId, amount)
    return true, nil
end

-- Adds an emergency overdraft loan when player can't pay fines or rent
function BankService.AddEmergencyDebt(userId: number, deficitAmount: number, currentRound: number)
    local loans = BankService.GetPlayerLoans(userId)
    local newLoan: LoanRecord = {
        Id = "EMERGENCY_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Principal = deficitAmount,
        AccumulatedInterest = 0,
        InterestRate = EconomyConfig.Bank.EmergencyLoanInterestRate,
        CreatedAtRound = currentRound,
    }
    table.insert(loans, newLoan)
end

-- Accrues interest for all active loans of the player at the start of their turn
function BankService.AccrueTurnInterest(userId: number, isFrozen: boolean)
    if isFrozen then return end
    
    local loans = BankService.GetPlayerLoans(userId)
    for _, loan in ipairs(loans) do
        local interest = math.floor(loan.Principal * loan.InterestRate)
        loan.AccumulatedInterest += interest
    end
end

function BankService.RepayLoan(userId: number, loanId: string, amount: number): (boolean, string?)
    local loans = BankService.GetPlayerLoans(userId)
    local targetLoan: LoanRecord? = nil
    local targetIndex = -1
    
    for i, loan in ipairs(loans) do
        if loan.Id == loanId then
            targetLoan = loan
            targetIndex = i
            break
        end
    end
    
    if not targetLoan or targetIndex == -1 then
        return false, "LOAN_NOT_FOUND"
    end
    
    local totalDue = targetLoan.Principal + targetLoan.AccumulatedInterest
    local payment = math.min(amount, totalDue)
    
    local balance = EconomyService.GetBalance(userId)
    if balance < payment then
        return false, "INSUFFICIENT_FUNDS"
    end
    
    local success, _ = EconomyService.Withdraw(userId, payment)
    if not success then
        return false, "PAYMENT_FAILED"
    end
    
    -- Pay off interest first, then principal
    if payment <= targetLoan.AccumulatedInterest then
        targetLoan.AccumulatedInterest -= payment
    else
        local remainder = payment - targetLoan.AccumulatedInterest
        targetLoan.AccumulatedInterest = 0
        targetLoan.Principal -= remainder
    end
    
    -- If fully paid, remove loan record
    if targetLoan.Principal <= 0 and targetLoan.AccumulatedInterest <= 0 then
        table.remove(loans, targetIndex)
    end
    
    return true, nil
end

function BankService.Reset()
    table.clear(playerLoans)
end

return BankService
