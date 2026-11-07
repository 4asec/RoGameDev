--!strict
--[[
    CameraController.luau
    Contextual isometric camera controller with smooth tweens for board overview and turn focus.
]]

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local CameraController = {}
CameraController.__index = CameraController

local camera = Workspace.CurrentCamera
local currentTarget: BasePart? = nil
local isFollowing = false

function CameraController.Initialize()
    camera.CameraType = Enum.CameraType.Scriptable
end

function CameraController.FocusOnPosition(targetPos: Vector3, duration: number?)
    local timeToTween = duration or 1.0
    local cameraOffset = Vector3.new(0, 35, -28)
    local targetCFrame = CFrame.new(targetPos + cameraOffset, targetPos)
    
    local tweenInfo = TweenInfo.new(timeToTween, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    local tween = TweenService:Create(camera, tweenInfo, { CFrame = targetCFrame })
    tween:Play()
end

function CameraController.FollowCharacter(character: Model)
    local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
    if not rootPart then return end
    
    currentTarget = rootPart
    isFollowing = true
    
    task.spawn(function()
        while isFollowing and currentTarget do
            local targetPos = currentTarget.Position
            local cameraOffset = Vector3.new(0, 32, -26)
            camera.CFrame = CFrame.new(targetPos + cameraOffset, targetPos)
            task.wait()
        end
    end)
end

function CameraController.StopFollowing()
    isFollowing = false
    currentTarget = nil
end

return CameraController
