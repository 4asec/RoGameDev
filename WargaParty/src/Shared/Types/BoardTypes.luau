--!strict
--[[
    BoardTypes.luau
    Graph data types for 3D open city board navigation.
]]

export type NodeType = "Start" | "Property" | "Bank" | "Event" | "Toll" | "Salary" | "Branch" | "Finish"

export type BoardNode = {
    Id: string,
    Name: string,
    NodeType: NodeType,
    Position: Vector3,
    NextNodes: { string }, -- IDs of connected nodes. If length > 1, it's an intersection.
    PropertyId: string?,
    EventPool: { string }?,
    TollCost: number?,
    BranchLabels: { string }?, -- Labels for route choices (e.g., "Jalur Cepat Sudirman", "Gang Senggol")
}

export type BoardMap = {
    CityName: string,
    StartNodeId: string,
    FinishNodeId: string,
    Nodes: { [string]: BoardNode },
}

return nil
