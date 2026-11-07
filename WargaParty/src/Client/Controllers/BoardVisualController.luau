--!strict
--[[
    BoardVisualController.luau
    Client-side visualization: spawns 3D tile markers, path indicators, and animates character footsteps.
]]

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BoardTypes = require(ReplicatedStorage.WargaPartyShared.Types.BoardTypes)

type BoardNode = BoardTypes.BoardNode

local BoardVisualController = {}
BoardVisualController.__index = BoardVisualController

local boardContainer: Folder? = nil

function BoardVisualController.Initialize()
    local vslice = Workspace:FindFirstChild("WargaParty_VerticalSlice")
    if vslice and vslice:FindFirstChild("Embedded_Board_Tiles") then
        boardContainer = vslice.Embedded_Board_Tiles
    else
        boardContainer = Workspace:FindFirstChild("WargaPartyBoard") :: Folder
        if not boardContainer then
            local folder = Instance.new("Folder")
            folder.Name = "WargaPartyBoard"
            folder.Parent = Workspace
            boardContainer = folder
        end
    end
end

-- Connects visual 3D tiles in Workspace with board node metadata
function BoardVisualController.RenderBoardNodes(nodes: { [string]: BoardNode })
    if not boardContainer then return end
    
    -- If using embedded slice tiles, they are already rendered and styled
    local vslice = Workspace:FindFirstChild("WargaParty_VerticalSlice")
    if vslice and boardContainer == vslice:FindFirstChild("Embedded_Board_Tiles") then
        return
    end
    
    for _, node in pairs(nodes) do
        local existing = boardContainer:FindFirstChild(node.Id)
        if not existing then
            local part = Instance.new("Part")
            part.Name = node.Id
            part.Size = Vector3.new(12, 1, 12)
            part.Position = node.Position - Vector3.new(0, 0.5, 0)
            part.Anchored = true
            part.CanCollide = true
            part.Material = Enum.Material.SmoothPlastic
            
            -- Color code by node type
            if node.NodeType == "Start" then
                part.Color = Color3.fromRGB(34, 197, 94) -- Emerald green
            elseif node.NodeType == "Finish" then
                part.Color = Color3.fromRGB(234, 179, 8) -- Gold
            elseif node.NodeType == "Property" then
                part.Color = Color3.fromRGB(59, 130, 246) -- Blue
            elseif node.NodeType == "Bank" then
                part.Color = Color3.fromRGB(168, 85, 247) -- Purple
            elseif node.NodeType == "Event" then
                part.Color = Color3.fromRGB(249, 115, 22) -- Orange
            elseif node.NodeType == "Branch" then
                part.Color = Color3.fromRGB(236, 72, 153) -- Pink
            else
                part.Color = Color3.fromRGB(203, 213, 225) -- Slate
            end
            
            -- Surface UI Label
            local surfaceGui = Instance.new("SurfaceGui")
            surfaceGui.Face = Enum.NormalId.Top
            surfaceGui.Parent = part
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = node.Name
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextScaled = true
            label.Font = Enum.Font.FredokaOne
            label.Parent = surfaceGui
            
            part.Parent = boardContainer
        end
    end
end

-- Smoothly animates player character walking along the path nodes
function BoardVisualController.AnimatePlayerMovement(player: Player, nodePositions: { Vector3 })
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
    if not rootPart then return end
    
    for _, targetPos in ipairs(nodePositions) do
        local targetCFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
        local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = targetCFrame })
        tween:Play()
        tween.Completed:Wait()
    end
end

return BoardVisualController
