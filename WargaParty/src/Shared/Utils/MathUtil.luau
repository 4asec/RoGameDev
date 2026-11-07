--!strict
--[[
    MathUtil.luau
    Utility functions for formatting Rupiah currency and vector interpolation.
]]

local MathUtil = {}

function MathUtil.FormatRupiah(amount: number): string
    local isNegative = amount < 0
    local absAmount = math.abs(amount)
    
    local formatted = tostring(math.floor(absAmount))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1.%2")
        if k == 0 then
            break
        end
    end
    
    if isNegative then
        return "-Rp " .. formatted
    else
        return "Rp " .. formatted
    end
end

function MathUtil.Clamp(val: number, minVal: number, maxVal: number): number
    return math.max(minVal, math.min(maxVal, val))
end

function MathUtil.LerpVector3(a: Vector3, b: Vector3, alpha: number): Vector3
    return a + (b - a) * alpha
end

return table.freeze(MathUtil)
