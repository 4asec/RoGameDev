# EVENT DESIGN DOCUMENT (EDD-EVT)
# Random Events, Government Policies & NPC Encounters

**Document Version:** 1.0.0  
**Design Principle:** Data-driven, culturally authentic, hilarious, and situational  

---

## 1. Event Data Schema

All events are defined declaratively in `Shared/Config/EventConfig.luau` using this schema:

```lua
type EventDefinition = {
    Id: string,
    Title: string,
    Description: string,
    Rarity: "Common" | "Uncommon" | "Rare" | "Legendary",
    Scope: "ActivePlayer" | "AllPlayers" | "TargetRival" | "CityWide",
    CityRestriction: { string }?, -- nil means available in all cities
    EffectType: "CashDelta" | "PropertyRentDelta" | "MovePlayer" | "PolicyTrigger" | "LoanFreeze",
    Parameters: { [string]: any },
    DialogNPC: {
        Name: string,
        Role: string,
        AvatarAssetId: string?,
        Catchphrase: string
    }?
}
```

---

## 2. Event Rarity & Distribution

| Rarity | Weight | Typical Impact | Visual / Audio Cue |
| :--- | :--- | :--- | :--- |
| **Common** | 60% | Small monetary changes ($\pm \text{Rp } 100\text{k} - 500\text{k}$) | Green/White pop-up card, comedic sound effect |
| **Uncommon** | 25% | Moderate financial shifts ($\pm \text{Rp } 1\text{M} - 2.5\text{M}$), temporary movement debuffs | Blue pop-up card, camera shake |
| **Rare** | 12% | Major property swings, global market shockwaves | Purple banner, dramatic brass horn sting |
| **Legendary** | 3% | Global city policy transformations, complete debt relief or windfall | Gold animated card, fireworks, siren announcement |

---

## 3. Indonesian Absurd Event Catalog

### 3.1 Common Events
1. **`EVT_PARKIR_GAIB` (Tukang Parkir Gaib):**
   - *NPC:* Bang Jack (Tukang Parkir Rompi Oranye)
   - *Catchphrase:* *"Priiittt! Terus... terus... yak balas gan!"*
   - *Description:* Tiba-tiba muncul dari balik pohon padahal tadi sepi.
   - *Effect:* Potong `Rp 150,000` dari pemain aktif.
2. **`EVT_GORENGAN_CRUNCH` (Nemu Uang Kembalian):**
   - *Description:* Beli gorengan Rp 5,000 dikasih uang kembalian Rp 50,000 karena penjualnya salah lihat.
   - *Effect:* Tambah `Rp 45,000` ke saldo pemain aktif.
3. **`EVT_KNALPOT_BRONG` (Kena Tilang Suara Knalpot):**
   - *NPC:* Pak Polisi Ramah
   - *Description:* Knalpot motormu terlalu berisik bikin ayam tetangga kaget.
   - *Effect:* Denda tilang `Rp 300,000`.

### 3.2 Uncommon Events
4. **`EVT_VIRAL_TIKTOK` (Warungmu Viral di Medsos):**
   - *Description:* Seorang food vlogger mereview warungmu dengan kata "GOKIL PARAH ABIEZZZ".
   - *Effect:* Semua properti milik pemain aktif menghasilkan sewa +50% selama 2 putaran.
5. **`EVT_EMAK_SEIN_KIRI` (Emak-emak Sein Kiri Belok Kanan):**
   - *NPC:* Ibu Nurul (Ratu Jalanan)
   - *Description:* Kamu kaget menghindari motor sein kiri belok kanan, ban motormu masuk got.
   - *Effect:* Mundur 2 petak ke belakang dan bayar bengkel `Rp 500,000`.
6. **`EVT_MATI_LAMPU` (Pemadaman Bergilir PLN):**
   - *Description:* Daerah bisnismu gelap gulita. Mesin kasir mati total.
   - *Effect:* Properti di distrik pusat kota tidak dapat menarik uang sewa selama 1 putaran.

### 3.3 Rare Events
7. **`EVT_BANJIR_KIRIMAN` (Banjir Kiriman Datang):**
   - *Description:* Air setinggi betis menggenangi jalan utama. Perahu karet darurat lewat!
   - *Effect:* Semua pemain di jalur utama tertunda pergerakannya (dadu berikutnya dibatasi maksimal 3).
8. **`EVT_BANSOS_NYASAR` (Bantuan Sosial Salah Alamat):**
   - *NPC:* Pak RT Subur
   - *Description:* Dus bansos berisi sembako dan amplop misterius mendarat di depan pintu rumahmu.
   - *Effect:* Pemain dengan saldo terendah mendapatkan suntikan dana `Rp 2,500,000`.

### 3.4 Legendary Events
9. **`EVT_PEMUTIHAN_PAJAK` (Amnesti Finansial Nasional):**
   - *NPC:* Bapak Walikota Idaman
   - *Description:* Pemerintah kota mengumumkan pemutihan denda dan pembekuan bunga bank!
   - *Effect:* Semua bunga pinjaman bank aktif untuk seluruh pemain dibekukan selama 3 putaran.
10. **`EVT_INFLASI_SEMBILAN_BAHAN` (Krisis Cabai & Bawang):**
    - *Description:* Harga cabai melonjak tajam! Biaya hidup dan denda melonjak drastis.
    - *Effect:* Semua denda petak dilipatgandakan 2x lipat selama 2 putaran ke depan.

---

## 4. City-Specific Exclusive Events

- **Jakarta:**
  - `EVT_JKT_MACET_TOL`: Macet horor di Tol Dalam Kota, lewati giliran melempar dadu atau bayar ojek helikopter Rp 1M.
  - `EVT_JKT_GANJIL_GENAP`: Plat nomor genap dilarang lewat jalur Sudirman pada putaran ini.
- **Yogyakarta:**
  - `EVT_YOG_ANGKRINGAN_REJEKI`: Makan nasi kucing dan sate usus bareng mahasiswa, hemat pengeluaran +Rp 300,000.
  - `EVT_YOG_MALIOBORO_FEST`: Diskon belanja souvenir, semua harga beli properti di Malioboro diskon 20%.
- **Surabaya:**
  - `EVT_SBY_PANAS_POLL`: Suhu 38 derajat celsius! Semua pemain beli es teh jumbo (potong Rp 50,000 per orang).
  - `EVT_SBY_BEBEK_SINJAY`: Makan bebek goreng legendaris, boost dadu +2 langkah pada lemparan berikutnya.
- **Bali:**
  - `EVT_BALI_UPACARA_ADAT`: Jalur utama ditutup untuk prosesi upacara adat, seluruh pemain wajib belok ke jalan alternatif.
  - `EVT_BALI_TURIS_BORONG`: Turis asing memborong dagangan senimu, dapatkan bonus devisa `Rp 3,000,000`.
