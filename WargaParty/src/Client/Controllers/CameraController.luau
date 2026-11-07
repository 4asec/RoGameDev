--!strict
--[[
    CameraController.luau
    Contextual isometric camera controller with adaptive cinematic sequences:
    - Gambir Train Arrival cinematic intro
    - True isometric gameplay camera (Pitch -42 deg, Yaw 45 deg, FOV 48)
    - Foreground obstruction detection and transparency fading
]]

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local CameraController = {}
CameraController.__index = CameraController

local camera = Workspace.CurrentCamera
local currentTarget: BasePart? = nil
local isFollowing = false

-- Canonical Gameplay Camera Offset (Isometric standard: Pitch -42 deg, Yaw 45 deg)
local ISOMETRIC_OFFSET = Vector3.new(28, 32, 28)
local ISOMETRIC_FOV = 48

function CameraController.Initialize()
    camera.CameraType = Enum.CameraType.Scriptable
    camera.FieldOfView = ISOMETRIC_FOV
end

-- Smoothly tweens camera to focus on an arbitrary world position from isometric angle
function CameraController.FocusOnPosition(targetPos: Vector3, duration: number?)
    local timeToTween = duration or 1.2
    local eyePos = targetPos + ISOMETRIC_OFFSET
    local targetCFrame = CFrame.lookAt(eyePos, targetPos)
    
    local tweenInfo = TweenInfo.new(timeToTween, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    local tween = TweenService:Create(camera, tweenInfo, {
        CFrame = targetCFrame,
        FieldOfView = ISOMETRIC_FOV
    })
    tween:Play()
end

-- Plays the immersive Gambir Station arrival sequence
function CameraController.PlayTrainIntro(character: Model, onComplete: (() -> ())?)
    camera.CameraType = Enum.CameraType.Scriptable
    local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
    
    -- Shot 1: Inside Train Carriage (Interior View)
    local trainInteriorEye = Vector3.new(-42, 6.5, -4)
    local trainInteriorTarget = Vector3.new(-44, 4.5, -6)
    camera.CFrame = CFrame.lookAt(trainInteriorEye, trainInteriorTarget)
    camera.FieldOfView = 60
    
    task.wait(1.5)
    
    -- Shot 2: Pan smoothly towards train door and platform
    local doorEye = Vector3.new(-38, 5.5, 0)
    local doorTarget = Vector3.new(-26, 3.0, 0)
    local doorTween = TweenService:Create(camera, TweenInfo.new(2.0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = CFrame.lookAt(doorEye, doorTarget),
        FieldOfView = 55
    })
    doorTween:Play()
    doorTween.Completed:Wait()
    
    -- Shot 3: Character steps onto Platform 1 (N_START)
    if rootPart then
        rootPart.CFrame = CFrame.new(-26, 3.5, 0)
    end
    task.wait(0.8)
    
    -- Shot 4: Dramatic elevator pull up into standard isometric gameplay view
    local startNodePos = Vector3.new(-26, 2.56, 0)
    local finalEye = startNodePos + ISOMETRIC_OFFSET
    local finalCFrame = CFrame.lookAt(finalEye, startNodePos)
    
    local gameplayTween = TweenService:Create(camera, TweenInfo.new(2.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
        CFrame = finalCFrame,
        FieldOfView = ISOMETRIC_FOV
    })
    gameplayTween:Play()
    gameplayTween.Completed:Wait()
    
    -- Start following the character
    CameraController.FollowCharacter(character)
    
    if onComplete then
        onComplete()
    end
end

-- Follows character across the 3D board with smooth dampening & obstruction fading
function CameraController.FollowCharacter(character: Model)
    local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
    if not rootPart then return end
    
    currentTarget = rootPart
    isFollowing = true
    
    task.spawn(function()
        local occludedParts: { [BasePart]: number } = {}
        
        while isFollowing and currentTarget do
            local targetPos = currentTarget.Position
            local eyePos = targetPos + ISOMETRIC_OFFSET
            local desiredCFrame = CFrame.lookAt(eyePos, targetPos)
            
            -- Smooth camera lerp
            camera.CFrame = camera.CFrame:Lerp(desiredCFrame, 0.15)
            
            -- Raycast check for foreground obstructions
            local rayOrigin = eyePos
            local rayDirection = targetPos - eyePos
            local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = { character, Workspace:FindFirstChild("Terrain") }
            
            local result = Workspace:Raycast(rayOrigin, rayDirection, rayParams)
            if result and result.Instance:IsA("BasePart") then
                local hitPart = result.Instance
                if hitPart.Transparency < 0.6 and not hitPart:IsDescendantOf(character) then
                    if not occludedParts[hitPart] then
                        occludedParts[hitPart] = hitPart.Transparency
                        hitPart.Transparency = 0.65
                    end
                end
            else
                -- Restore any previously faded parts
                for part, origTrans in pairs(occludedParts) do
                    part.Transparency = origTrans
                    occludedParts[part] = nil
                end
            end
            
            task.wait()
        end
    end)
end

function CameraController.StopFollowing()
    isFollowing = false
    currentTarget = nil
end

return CameraController
