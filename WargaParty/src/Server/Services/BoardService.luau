--!strict
--[[
    BoardService.luau
    Manages the 3D Open City Board graph, node relationships, branching intersections, and map geometries.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoardTypes = require(ReplicatedStorage.WargaPartyShared.Types.BoardTypes)

type BoardNode = BoardTypes.BoardNode
type BoardMap = BoardTypes.BoardMap

local BoardService = {}
BoardService.__index = BoardService

local currentMap: BoardMap? = nil

-- Constructs the canonical Jakarta map with branching paths converging at FINISH (Monas Plaza)
function BoardService.LoadJakartaMap(): BoardMap
    local nodes: { [string]: BoardNode } = {
        -- Node 1: Start (Stasiun Gambir Platform 1)
        N_START = {
            Id = "N_START",
            Name = "Stasiun Gambir (Peron 1)",
            NodeType = "Start",
            Position = Vector3.new(-26, 2.56, 0),
            NextNodes = { "N_01" },
        },
        
        -- Node 2: Concourse Gambir
        N_01 = {
            Id = "N_01",
            Name = "Concourse Tiket Gambir",
            NodeType = "Opportunity",
            Position = Vector3.new(-18, 2.56, 12),
            NextNodes = { "N_02" },
        },
        
        -- Node 3: Pangkalan Bajaj Gambir
        N_02 = {
            Id = "N_02",
            Name = "Pangkalan Bajaj Gambir",
            NodeType = "Property",
            PropertyId = "JKT_01",
            Position = Vector3.new(-10, 0.86, 22),
            NextNodes = { "N_03" },
        },
        
        -- Node 4: Zebra Cross Sidewalk
        N_03 = {
            Id = "N_03",
            Name = "Penyeberangan Zebra Cross",
            NodeType = "Event",
            Position = Vector3.new(-8, 0.86, 29),
            NextNodes = { "N_BRANCH_01" },
        },
        
        -- Node 5: Branch Intersection (Zebra Cross Center)
        N_BRANCH_01 = {
            Id = "N_BRANCH_01",
            Name = "Simpang Senayan & Gang Senggol",
            NodeType = "Branch",
            Position = Vector3.new(5, 0.46, 29),
            NextNodes = { "N_GANG_01" },
            BranchLabels = { "Gang Senggol & Kuliner" }
        },
        
        -- Route: Gang Senggol (Kuliner & Absurdity)
        N_GANG_01 = {
            Id = "N_GANG_01",
            Name = "Kios Sayur Gang Senggol",
            NodeType = "Property",
            PropertyId = "JKT_03",
            Position = Vector3.new(18, 0.86, 29),
            NextNodes = { "N_GANG_02" },
        },
        N_GANG_02 = {
            Id = "N_GANG_02",
            Name = "Warung Pecel Lele Cak Slamet",
            NodeType = "Property",
            PropertyId = "JKT_04",
            Position = Vector3.new(22, 0.86, 36),
            NextNodes = { "N_FINISH" },
        },
        
        -- Terminal: Monas Plaza Showcase Finish
        N_FINISH = {
            Id = "N_FINISH",
            Name = "Tugu Monas Plaza",
            NodeType = "Finish",
            Position = Vector3.new(22, 0.86, 50),
            NextNodes = {},
        }
    }
    
    currentMap = {
        CityName = "Jakarta",
        StartNodeId = "N_START",
        FinishNodeId = "N_FINISH",
        Nodes = nodes,
    }
    
    return currentMap :: BoardMap
end

function BoardService.GetMap(): BoardMap
    if not currentMap then
        return BoardService.LoadJakartaMap()
    end
    return currentMap
end

function BoardService.GetNode(nodeId: string): BoardNode?
    local map = BoardService.GetMap()
    return map.Nodes[nodeId]
end

return BoardService
