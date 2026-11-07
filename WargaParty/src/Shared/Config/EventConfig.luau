--!strict
--[[
    EventConfig.luau
    Absurd Indonesian everyday events, government policies, and NPC interactions.
]]

export type EventDef = {
    Id: string,
    Title: string,
    Description: string,
    Rarity: "Common" | "Uncommon" | "Rare" | "Legendary",
    Scope: "ActivePlayer" | "AllPlayers" | "LowestBalancePlayer",
    City: string?,
    EffectType: "CashDelta" | "RentBoost" | "StepBack" | "FreezeInterest" | "DoubleFines",
    Amount: number?,
    DurationRounds: number?,
    NPC: {
        Name: string,
        Role: string,
        Catchphrase: string,
    }?
}

local EventConfig = {
    RarityWeights = {
        Common = 60,
        Uncommon = 25,
        Rare = 12,
        Legendary = 3,
    },
    
    Catalog = {
        -- Common Events
        EVT_PARKIR_GAIB = {
            Id = "EVT_PARKIR_GAIB",
            Title = "Tukang Parkir Gaib",
            Description = "Tiba-tiba muncul dari balik pohon pas motor mau keluar. 'Priiittt!'",
            Rarity = "Common",
            Scope = "ActivePlayer",
            EffectType = "CashDelta",
            Amount = -150000,
            NPC = {
                Name = "Bang Jack",
                Role = "Tukang Parkir Rompi Oranye",
                Catchphrase = "Priiiitt! Balas stir gan!"
            }
        },
        EVT_GORENGAN_CRUNCH = {
            Id = "EVT_GORENGAN_CRUNCH",
            Title = "Rejeki Gorengan",
            Description = "Beli bakwan Rp 5.000, dikasih kembalian Rp 50.000 karena penjualnya ngantuk.",
            Rarity = "Common",
            Scope = "ActivePlayer",
            EffectType = "CashDelta",
            Amount = 45000,
        },
        EVT_TILANG_KNALPOT = {
            Id = "EVT_TILANG_KNALPOT",
            Title = "Knalpot Terlalu Merdu",
            Description = "Knalpot brong motormu bikin ayam tetangga senam jantung.",
            Rarity = "Common",
            Scope = "ActivePlayer",
            EffectType = "CashDelta",
            Amount = -300000,
            NPC = {
                Name = "Pak Polisi Santun",
                Role = "Polantas",
                Catchphrase = "Selamat siang, bisa tunjukkan surat-suratnya?"
            }
        },
        
        -- Uncommon Events
        EVT_VIRAL_MEDSOS = {
            Id = "EVT_VIRAL_MEDSOS",
            Title = "Viral Masuk FYP",
            Description = "Food vlogger kondang mereview warungmu: 'GOKIL PARAH ABIS!'. Pelanggan membludak!",
            Rarity = "Uncommon",
            Scope = "ActivePlayer",
            EffectType = "RentBoost",
            Amount = 50, -- +50% rent boost
            DurationRounds = 2,
        },
        EVT_EMAK_SEIN_KIRI = {
            Id = "EVT_EMAK_SEIN_KIRI",
            Title = "Emak-Emak Sein Kiri Belok Kanan",
            Description = "Menghindari manuver maut emak-emak, motormu terperosok ke selokan.",
            Rarity = "Uncommon",
            Scope = "ActivePlayer",
            EffectType = "StepBack",
            Amount = -2, -- mundur 2 langkah
        },
        
        -- Rare Events
        EVT_BANSOS_NYASAR = {
            Id = "EVT_BANSOS_NYASAR",
            Title = "Bantuan Sosial Salah Alamat",
            Description = "Dus sembako plus amplop misterius terdampar di depan pintu rumahmu.",
            Rarity = "Rare",
            Scope = "LowestBalancePlayer",
            EffectType = "CashDelta",
            Amount = 2500000,
            NPC = {
                Name = "Pak RT Subur",
                Role = "Pengurus Wilayah",
                Catchphrase = "Yang penting warganya seneng dulu dah!"
            }
        },
        
        -- Legendary Policies
        EVT_PEMUTIHAN_PAJAK = {
            Id = "EVT_PEMUTIHAN_PAJAK",
            Title = "Kebijakan: Pemutihan Denda & Bunga",
            Description = "Bapak Walikota mengumumkan amnesti nasional! Bunga pinjaman bank dibekukan sementara.",
            Rarity = "Legendary",
            Scope = "AllPlayers",
            EffectType = "FreezeInterest",
            DurationRounds = 3,
            NPC = {
                Name = "Bapak Walikota",
                Role = "Pemerintah Kota",
                Catchphrase = "Mari wujudkan kota yang sentosa tanpa beban riba!"
            }
        },
        EVT_INFLASI_SEMBILAN_BAHAN = {
            Id = "EVT_INFLASI_SEMBILAN_BAHAN",
            Title = "Kebijakan: Lonjakan Harga Cabai & Bawang",
            Description = "Harga komoditas melonjak drastis! Semua biaya denda dilipatgandakan 2x lipat.",
            Rarity = "Legendary",
            Scope = "AllPlayers",
            EffectType = "DoubleFines",
            DurationRounds = 2,
        }
    } :: { [string]: EventDef }
}

return table.freeze(EventConfig)
