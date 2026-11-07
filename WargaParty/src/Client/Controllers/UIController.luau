--!strict
--[[
    UIController.luau
    Builds and manages responsive in-game HUDs, turn buttons, branch prompts, event popups, and podium screens.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MathUtil = require(ReplicatedStorage.WargaPartyShared.Utils.MathUtil)

local UIController = {}
UIController.__index = UIController

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui") :: PlayerGui

local screenGui: ScreenGui? = nil
local turnBanner: TextLabel? = nil
local rollButton: TextButton? = nil
local eventCardFrame: Frame? = nil
local branchFrame: Frame? = nil

function UIController.Initialize()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WargaPartyHUD"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    -- 1. Turn Banner (Top Center)
    local banner = Instance.new("TextLabel")
    banner.Name = "TurnBanner"
    banner.Size = UDim2.new(0, 380, 0, 50)
    banner.Position = UDim2.new(0.5, -190, 0, 20)
    banner.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    banner.TextColor3 = Color3.fromRGB(251, 191, 36)
    banner.Font = Enum.Font.FredokaOne
    banner.TextSize = 20
    banner.Text = "Menunggu Pertandingan Dimulai..."
    
    local bannerCorner = Instance.new("UICorner")
    bannerCorner.CornerRadius = UDim.new(0, 12)
    bannerCorner.Parent = banner
    
    local bannerStroke = Instance.new("UIStroke")
    bannerStroke.Color = Color3.fromRGB(251, 191, 36)
    bannerStroke.Thickness = 2
    bannerStroke.Parent = banner
    
    banner.Parent = screenGui
    turnBanner = banner
    
    -- 2. Roll Dice Button (Bottom Center)
    local btn = Instance.new("TextButton")
    btn.Name = "RollDiceButton"
    btn.Size = UDim2.new(0, 220, 0, 60)
    btn.Position = UDim2.new(0.5, -110, 1, -90)
    btn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 22
    btn.Text = "🎲 LEMPAR DADU"
    btn.Visible = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 14)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Thickness = 2
    btnStroke.Parent = btn
    
    btn.Parent = screenGui
    rollButton = btn
    
    -- 3. Event Card Frame (Center Pop-up)
    local evtFrame = Instance.new("Frame")
    evtFrame.Name = "EventCard"
    evtFrame.Size = UDim2.new(0, 420, 0, 220)
    evtFrame.Position = UDim2.new(0.5, -210, 0.5, -110)
    evtFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    evtFrame.Visible = false
    
    local evtCorner = Instance.new("UICorner")
    evtCorner.CornerRadius = UDim.new(0, 16)
    evtCorner.Parent = evtFrame
    
    local evtStroke = Instance.new("UIStroke")
    evtStroke.Color = Color3.fromRGB(249, 115, 22)
    evtStroke.Thickness = 3
    evtStroke.Parent = evtFrame
    
    local evtTitle = Instance.new("TextLabel")
    evtTitle.Name = "Title"
    evtTitle.Size = UDim2.new(1, -20, 0, 40)
    evtTitle.Position = UDim2.new(0, 10, 0, 10)
    evtTitle.BackgroundTransparency = 1
    evtTitle.TextColor3 = Color3.fromRGB(249, 115, 22)
    evtTitle.Font = Enum.Font.FredokaOne
    evtTitle.TextSize = 22
    evtTitle.Text = "KEJADIAN ABSURD"
    evtTitle.Parent = evtFrame
    
    local evtDesc = Instance.new("TextLabel")
    evtDesc.Name = "Description"
    evtDesc.Size = UDim2.new(1, -30, 0, 120)
    evtDesc.Position = UDim2.new(0, 15, 0, 55)
    evtDesc.BackgroundTransparency = 1
    evtDesc.TextColor3 = Color3.fromRGB(241, 245, 249)
    evtDesc.Font = Enum.Font.GothamMedium
    evtDesc.TextSize = 16
    evtDesc.TextWrapped = true
    evtDesc.Text = "Tukang Parkir Gaib tiba-tiba muncul dari balik pohon!"
    evtDesc.Parent = evtFrame
    
    evtFrame.Parent = screenGui
    eventCardFrame = evtFrame
    
    -- 4. Branch Selection Frame (Pop-up above bottom bar)
    local bFrame = Instance.new("Frame")
    bFrame.Name = "BranchSelection"
    bFrame.Size = UDim2.new(0, 460, 0, 100)
    bFrame.Position = UDim2.new(0.5, -230, 0.7, 0)
    bFrame.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    bFrame.Visible = false
    
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 14)
    bCorner.Parent = bFrame
    
    bFrame.Parent = screenGui
    branchFrame = bFrame
end

function UIController.SetTurnState(isMyTurn: boolean, activePlayerName: string, timeLimit: number)
    if not turnBanner or not rollButton then return end
    
    if isMyTurn then
        turnBanner.Text = "🎯 GILIRAN ANDA! (" .. timeLimit .. "s)"
        turnBanner.TextColor3 = Color3.fromRGB(34, 197, 94)
        rollButton.Visible = true
    else
        turnBanner.Text = "⏳ Giliran: " .. activePlayerName .. "..."
        turnBanner.TextColor3 = Color3.fromRGB(251, 191, 36)
        rollButton.Visible = false
    end
end

function UIController.ShowEventPopup(title: string, desc: string)
    if not eventCardFrame then return end
    
    local titleLabel = eventCardFrame:FindFirstChild("Title") :: TextLabel
    local descLabel = eventCardFrame:FindFirstChild("Description") :: TextLabel
    if titleLabel then titleLabel.Text = title end
    if descLabel then descLabel.Text = desc end
    
    eventCardFrame.Visible = true
    task.delay(4, function()
        eventCardFrame.Visible = false
    end)
end

function UIController.ShowBranchPrompt(options: { { branchIndex: number, label: string } }, onSelect: (number) -> ())
    if not branchFrame then return end
    
    -- Clear previous buttons
    for _, child in ipairs(branchFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local btnWidth = math.floor((460 - (#options + 1) * 10) / #options)
    for i, opt in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, btnWidth, 0, 50)
        btn.Position = UDim2.new(0, 10 + (i - 1) * (btnWidth + 10), 0.5, -25)
        btn.BackgroundColor3 = Color3.fromRGB(59, 130, 246)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.FredokaOne
        btn.TextSize = 14
        btn.Text = opt.label
        btn.TextWrapped = true
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            branchFrame.Visible = false
            onSelect(opt.branchIndex)
        end)
        
        btn.Parent = branchFrame
    end
    
    branchFrame.Visible = true
end

function UIController.GetRollButton(): TextButton?
    return rollButton
end

return UIController
