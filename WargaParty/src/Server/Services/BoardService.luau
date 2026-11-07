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
        -- Node 1: Start (Stasiun Gambir)
        N_START = {
            Id = "N_START",
            Name = "Stasiun Gambir (Start)",
            NodeType = "Start",
            Position = Vector3.new(0, 3, 0),
            NextNodes = { "N_02" },
        },
        
        -- Node 2: Property (Warkop Cuan)
        N_02 = {
            Id = "N_02",
            Name = "Warkop Cuan 24 Jam",
            NodeType = "Property",
            PropertyId = "JKT_01",
            Position = Vector3.new(0, 3, 20),
            NextNodes = { "N_03" },
        },
        
        -- Node 3: Event
        N_03 = {
            Id = "N_03",
            Name = "Simpang Lima",
            NodeType = "Event",
            Position = Vector3.new(0, 3, 40),
            NextNodes = { "N_BRANCH_01" },
        },
        
        -- Node 4: Branch Intersection! (Jalan Sudirman vs Gang Senggol)
        N_BRANCH_01 = {
            Id = "N_BRANCH_01",
            Name = "Persimpangan Bundaran",
            NodeType = "Branch",
            Position = Vector3.new(0, 3, 60),
            NextNodes = { "N_SUD_01", "N_GANG_01" },
            BranchLabels = { "Jalan Raya Sudirman (Aman & Mewah)", "Gang Senggol (Pintas & Penuh Kejutan)" }
        },
        
        -- Route A: Sudirman Boulevard (Wider, higher properties, bank)
        N_SUD_01 = {
            Id = "N_SUD_01",
            Name = "Bank Kota Sudirman",
            NodeType = "Bank",
            Position = Vector3.new(-30, 3, 80),
            NextNodes = { "N_SUD_02" },
        },
        N_SUD_02 = {
            Id = "N_SUD_02",
            Name = "Restoran Sultan Sudirman",
            NodeType = "Property",
            PropertyId = "JKT_05",
            Position = Vector3.new(-30, 3, 110),
            NextNodes = { "N_SUD_03" },
        },
        N_SUD_03 = {
            Id = "N_SUD_03",
            Name = "Toll Dalam Kota",
            NodeType = "Toll",
            TollCost = 500000,
            Position = Vector3.new(-20, 3, 140),
            NextNodes = { "N_MERGE_01" },
        },
        
        -- Route B: Gang Senggol (Shortcut, narrow, unpredictable events)
        N_GANG_01 = {
            Id = "N_GANG_01",
            Name = "Warung Madura Gang Senggol",
            NodeType = "Property",
            PropertyId = "JKT_03",
            Position = Vector3.new(30, 3, 80),
            NextNodes = { "N_GANG_02" },
        },
        N_GANG_02 = {
            Id = "N_GANG_02",
            Name = "Pos Ronda Warga",
            NodeType = "Event",
            Position = Vector3.new(20, 3, 120),
            NextNodes = { "N_MERGE_01" },
        },
        
        -- Merged Hub: Taman Suropati
        N_MERGE_01 = {
            Id = "N_MERGE_01",
            Name = "Taman Suropati (Checkpoint Gajian)",
            NodeType = "Salary",
            Position = Vector3.new(0, 3, 170),
            NextNodes = { "N_08" },
        },
        N_08 = {
            Id = "N_08",
            Name = "Showroom Motor Idaman",
            NodeType = "Property",
            PropertyId = "JKT_06",
            Position = Vector3.new(0, 3, 200),
            NextNodes = { "N_09" },
        },
        N_09 = {
            Id = "N_09",
            Name = "Pusat Investasi Cuan",
            NodeType = "Bank",
            Position = Vector3.new(0, 3, 230),
            NextNodes = { "N_FINISH" },
        },
        
        -- Terminal: Monas Plaza
        N_FINISH = {
            Id = "N_FINISH",
            Name = "Monas Plaza (FINISH)",
            NodeType = "Finish",
            Position = Vector3.new(0, 3, 270),
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
