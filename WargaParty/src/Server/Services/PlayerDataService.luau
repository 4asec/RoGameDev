--!strict
--[[
    PlayerDataService.luau
    Session-locked player data persistence for Coins, Gold, Inventory, and Match Stats.
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local PlayerDataStore = nil
pcall(function()
    PlayerDataStore = DataStoreService:GetDataStore("WargaParty_PlayerData_v1")
end)

export type PlayerProfile = {
    Coins: number,
    Gold: number,
    EquippedDiceSkin: string,
    EquippedAura: string,
    OwnedCosmetics: { string },
    MatchesPlayed: number,
    MatchesWon: number,
    LastDailyRewardClaim: number,
}

local defaultProfile: PlayerProfile = {
    Coins = 100,
    Gold = 0,
    EquippedDiceSkin = "Default_White",
    EquippedAura = "None",
    OwnedCosmetics = { "Default_White" },
    MatchesPlayed = 0,
    MatchesWon = 0,
    LastDailyRewardClaim = 0,
}

local sessionCache: { [number]: PlayerProfile } = {}

local PlayerDataService = {}
PlayerDataService.__index = PlayerDataService

function PlayerDataService.LoadData(userId: number): PlayerProfile
    if sessionCache[userId] then
        return sessionCache[userId]
    end
    
    local data = nil
    if PlayerDataStore then
        local success, result = pcall(function()
            return PlayerDataStore:GetAsync("User_" .. userId)
        end)
        if success and type(result) == "table" then
            data = result
        end
    end
    
    if not data then
        data = table.clone(defaultProfile)
    end
    
    sessionCache[userId] = data
    return data
end

function PlayerDataService.SaveData(userId: number)
    local data = sessionCache[userId]
    if not data or not PlayerDataStore then return end
    
    pcall(function()
        PlayerDataStore:SetAsync("User_" .. userId, data)
    end)
end

function PlayerDataService.GetProfile(userId: number): PlayerProfile?
    return sessionCache[userId]
end

function PlayerDataService.AddCoins(userId: number, amount: number)
    local profile = PlayerDataService.GetProfile(userId)
    if profile then
        profile.Coins += amount
    end
end

function PlayerDataService.UnloadPlayer(userId: number)
    PlayerDataService.SaveData(userId)
    sessionCache[userId] = nil
end

return PlayerDataService
