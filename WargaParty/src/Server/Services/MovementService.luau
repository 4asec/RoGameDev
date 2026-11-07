--!strict
--[[
    MovementService.luau
    Handles path traversal calculations, intersection detection, and movement validation.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoardService = require(script.Parent.BoardService)
local BoardTypes = require(ReplicatedStorage.WargaPartyShared.Types.BoardTypes)

type BoardNode = BoardTypes.BoardNode

local MovementService = {}
MovementService.__index = MovementService

export type TraversalResult = {
    Path: { string },           -- Sequence of Node IDs traversed
    FinalNodeId: string,        -- Where movement ended
    StoppedAtBranch: boolean,   -- True if stopped early at an intersection
    RemainingSteps: number,     -- Steps left to consume after branch selection
    ReachedFinish: boolean,     -- True if character stepped into FINISH
}

function MovementService.CalculatePath(startNodeId: string, steps: number): TraversalResult
    local path = {}
    local currentNodeId = startNodeId
    local remaining = steps
    local stoppedAtBranch = false
    local reachedFinish = false
    
    while remaining > 0 do
        local node = BoardService.GetNode(currentNodeId)
        if not node then
            break
        end
        
        -- Check if current node is a branch with multiple choices
        if #node.NextNodes > 1 then
            stoppedAtBranch = true
            break
        end
        
        -- If no next node, we have arrived at the terminal FINISH node
        if #node.NextNodes == 0 then
            reachedFinish = true
            break
        end
        
        -- Advance to the single next node
        currentNodeId = node.NextNodes[1]
        table.insert(path, currentNodeId)
        remaining -= 1
        
        local nextNode = BoardService.GetNode(currentNodeId)
        if nextNode and nextNode.NodeType == "Finish" then
            reachedFinish = true
            remaining = 0
            break
        end
    end
    
    return {
        Path = path,
        FinalNodeId = currentNodeId,
        StoppedAtBranch = stoppedAtBranch,
        RemainingSteps = remaining,
        ReachedFinish = reachedFinish,
    }
end

return MovementService
