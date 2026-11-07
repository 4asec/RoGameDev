--!strict
--[[
    PropertyConfig.luau
    Definitions for districts, property prices, upgrades, and base rent calculations.
]]

export type PropertyDef = {
    Id: string,
    Name: string,
    District: "Pinggiran" | "Perumahan" | "PusatKota",
    City: string,
    Price: number,
    BaseRent: number,
    UpgradeTiers: { [number]: number },
}

local PropertyConfig = {
    DistrictMultipliers = {
        Pinggiran = 1.0,
        Perumahan = 1.35,
        PusatKota = 1.8,
    },
    
    -- Rent formula: BaseRent * (1 + (UpgradeLevel - 1) * 0.75) * PolicyMultiplier
    UpgradeMultiplier = 0.75,
    
    Catalog = {
        -- Jakarta
        JKT_01 = {
            Id = "JKT_01",
            Name = "Warkop Cuan 24 Jam",
            District = "Pinggiran",
            City = "Jakarta",
            Price = 1500000,
            BaseRent = 300000,
            UpgradeTiers = { [2] = 1000000, [3] = 2000000 },
        },
        JKT_02 = {
            Id = "JKT_02",
            Name = "Tambal Ban Tubeless Kilat",
            District = "Pinggiran",
            City = "Jakarta",
            Price = 1800000,
            BaseRent = 350000,
            UpgradeTiers = { [2] = 1200000, [3] = 2200000 },
        },
        JKT_03 = {
            Id = "JKT_03",
            Name = "Warung Madura Berkah",
            District = "Perumahan",
            City = "Jakarta",
            Price = 3500000,
            BaseRent = 800000,
            UpgradeTiers = { [2] = 2500000, [3] = 5000000 },
        },
        JKT_04 = {
            Id = "JKT_04",
            Name = "Laundry Kiloan Wangi",
            District = "Perumahan",
            City = "Jakarta",
            Price = 4000000,
            BaseRent = 900000,
            UpgradeTiers = { [2] = 2800000, [3] = 5500000 },
        },
        JKT_05 = {
            Id = "JKT_05",
            Name = "Restoran Sultan Sudirman",
            District = "PusatKota",
            City = "Jakarta",
            Price = 7500000,
            BaseRent = 2000000,
            UpgradeTiers = { [2] = 5000000, [3] = 10000000 },
        },
        JKT_06 = {
            Id = "JKT_06",
            Name = "Showroom Motor Idaman",
            District = "PusatKota",
            City = "Jakarta",
            Price = 8500000,
            BaseRent = 2400000,
            UpgradeTiers = { [2] = 6000000, [3] = 12000000 },
        },
    } :: { [string]: PropertyDef }
}

return table.freeze(PropertyConfig)
