--!strict
--[[
    TableUtil.luau
    Deep copying and helper methods for Luau tables.
]]

local TableUtil = {}

function TableUtil.DeepCopy<T>(original: T): T
    if type(original) ~= "table" then
        return original
    end
    
    local copy = {}
    for k, v in pairs(original :: any) do
        copy[TableUtil.DeepCopy(k)] = TableUtil.DeepCopy(v)
    end
    return copy :: any
end

function TableUtil.FindIndex<T>(tbl: { T }, predicate: (T) -> boolean): number?
    for i, item in ipairs(tbl) do
        if predicate(item) then
            return i
        end
    end
    return nil
end

return table.freeze(TableUtil)
