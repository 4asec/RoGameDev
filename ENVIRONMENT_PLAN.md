# WARGA PARTY — JAKARTA ENVIRONMENT PLAN & LEVEL DESIGN
**Document Version:** 1.0.0  
**Map Identifier:** MAP_01_JAKARTA_SHOWCASE  
**Lead Designer:** Senior Environment Art Director & Level Designer  
**Scope:** Master Layout, District Geography, Road Topology & Board Path Integration  

---

## 1. MASTER MAP CONCEPT & GEOGRAPHICAL TOPOGRAPHY

The Jakarta game board is engineered as an **organic, contiguous 3D metropolis** rather than a flat board or a tiny isolated diorama. The map measures **384 x 384 studs** in active playable area, situated neatly within the game world with layered background skylines extending beyond the borders to create seamless immersion.

```
+-----------------------------------------------------------------------+
|                       DISTRIK 4: MONAS CENTRAL PLAZA                  |
|          [Taman Medan Merdeka, Kolam Air Mancur, Tugu Monas]           |
|                                                                       |
|                          Node N_20 (FINISH / VICTORY)                 |
|                                     ▲                                 |
|                                     │                                 |
|                         [Bunderan HI & Convergence]                   |
|                                     ▲                                 |
|                     ┌───────────────┴───────────────┐                 |
|                     │                               │                 |
|            (Jalur Protokol)                (Jalur Alternatif)         |
|                     │                               │                 |
|         DISTRIK 2: SUDIRMAN CBD           DISTRIK 3: GANG SENGGOL     |
|   [Skyscrapers, Bank, Halte Busway]  [Ruko, Warteg, Pecel Lele, Pasar]|
|     Node N_SUD_01 -> N_SUD_05          Node N_GANG_01 -> N_GANG_05    |
|                     ▲                               ▲                 |
|                     │                               │                 |
|                     └───────────────┬───────────────┘                 |
|                                     │ (T-Junction Pemilihan Rute)     |
|                                     │                                 |
|                      DISTRIK 1: STASIUN GAMBIR                        |
|                  [Peron Kereta, Rel KAI, Plaza Start]                 |
|                  Node N_START -> N_01 -> N_02 -> N_03                 |
+-----------------------------------------------------------------------+
```

---

## 2. DISTRICT BREAKDOWN & VISUAL IDENTITY

### District 1: Gambir Gateway & Heritage Rail Corridor
- **Atmospheric Mood:** Nostalgic transit excitement, bustle of travelers, aroma of station coffee and pastry.
- **Architectural Style:** Colonial-modern fusion; arched steel station canopy, red brick highlights, polished stone peron tiles, double railway tracks.
- **Key Visual Anchors:**
  - `KAI_Executive_Train`: Stylized train coach parked at track 1 with warm interior lighting.
  - `Gambir_Concourse`: Ticket turnstiles, analog station clock, departure flight/train board.
  - `Station_Plaza`: Open paved courtyard with a row of parked orange and blue bajaj vehicles.
- **Board Gameplay Function:**
  - Houses `N_START` (The Grand Departure).
  - First 3 neutral tiles (`N_01`, `N_02`, `N_03`) introduce players to dice rolls and basic mini-events.
  - Culminates at `N_BRANCH_01` (The Big Fork), where players choose their path.

### District 2: Sudirman CBD (The High-Stakes Financial Boulevard)
- **Atmospheric Mood:** Sleek, orderly, high-powered corporate wealth with subtle satire of hustle culture.
- **Architectural Style:** Modern corporate glass towers (cyan and tinted navy glass), clean white concrete curbs, LED billboard displays, stylized busway shelters.
- **Key Visual Anchors:**
  - `Tower_Bank_Cuan_Rakyat`: Towering skyscraper with dynamic stock ticker decal.
  - `Halte_TransSudirman`: Elevated glass bus shelter with parked public transit angkot.
  - `Pohon_Tabebuia_Avenue`: Street divider blooming with bright yellow and pink cartoon blossoms.
- **Board Gameplay Function:**
  - Path Length: 5 Tiles (`N_SUD_01` to `N_SUD_05`).
  - High investment property tiles (expensive purchase price, hefty rent tolls).
  - Special Tile: `Bank ATM` (Deposit cash, take high-interest business loans).
  - Risk/Reward: Safe, predictable, high-value corporate economy.

### District 3: Gang Senggol & Pasar Tradisional (The High-Risk Street Life)
- **Atmospheric Mood:** Chaotic, vibrant, humorous, intimate, filled with Indonesian street culinary life.
- **Architectural Style:** 2-story colorful ruko (shophouses) with corrugated iron roofs, rolling doors, street-side plastic stools, hanging utility cables.
- **Key Visual Anchors:**
  - `Tenda_Pecel_Lele`: Classic blue and yellow canvas tent with steaming wok and street seating.
  - `Gerobak_Bakso_Dorong`: Traditional street food cart parked next to a banyan tree.
  - `Pos_Ronda`: Wooden community guardhouse with traditional kentongan slit drum.
  - `Tiang_Listrik_Semrawut`: Stylized concrete utility pole with comical tangled cables.
- **Board Gameplay Function:**
  - Path Length: 5 Tiles (`N_GANG_01` to `N_GANG_05`).
  - Low-cost properties (affordable warungs with volatile rent multipliers).
  - Chaos Event Tiles: "Razia Satpol PP" (skip a turn), "Gacor Arisan" (jackpot cash payout), "Pinjol Dadakan" (random debt).
  - Risk/Reward: Unpredictable, humorous, high-volatility chaos.

### District 4: Monas Central Plaza & Taman Medan Merdeka (The Grand Finale)
- **Atmospheric Mood:** Grand, celebratory, triumphant, breezy park atmosphere with patriotic flair.
- **Architectural Style:** Monumental neoclassical obelisk with a glowing gold flame, surrounded by pristine white marble terraces, circular fountain ponds, and tropical manicured lawn gardens.
- **Key Visual Anchors:**
  - `Tugu_Monas`: 110-stud monumental tower rising into the golden afternoon sky.
  - `Kolam_Air_Mancur`: Stepped water fountain with gentle reflective surface.
  - `Taman_Merdeka_Gardens`: Dense perimeter of stylized palm trees, park benches, and Indonesian national flags (`Merah Putih`).
- **Board Gameplay Function:**
  - Convergence Point: Both Sudirman and Gang Senggol merge into `N_MERGE_01` at Bunderan HI.
  - Final Lap: 3 victory tiles leading to `N_FINISH` at the base of Monas.
  - Passing Monas grants the "Gaji Bulanan Warga" (Lap completion stipend) and triggers special victory minigames.

---

## 3. ROAD TOPOLOGY & INTEGRATED BOARD NETWORK

### A. Coordinate Budget & Zone Boundaries
- **Center of World:** `Vector3.new(0, 0, 0)` located at the center of the Sudirman/Gang Senggol intersection.
- **District 1 (Gambir):** `Z = +120` to `+180` (South zone).
- **District 2 (Sudirman):** `X = -120` to `-20`, `Z = -40` to `+80` (West boulevard).
- **District 3 (Gang Senggol):** `X = +20` to `+120`, `Z = -40` to `+80` (East alleyway).
- **District 4 (Monas):** `X = -80` to `+80`, `Z = -180` to `-80` (North plaza).

### B. Board Tile Distribution (24 Total Nodes)

| Node ID | Physical Location | District | Tile Type | Visual Treatment |
| :--- | :--- | :--- | :--- | :--- |
| `N_START` | Gambir Station Platform 1 | Gambir | Start / Departure | Golden stone emblem with train icon |
| `N_01` | Gambir Ticket Concourse | Gambir | Opportunity | Green clover coin |
| `N_02` | Station Front Courtyard | Gambir | Property (Transit Kiosk)| Orange shophouse paving |
| `N_03` | Gambir Crossroad Exit | Gambir | Event (Ojol Traffic) | Red exclamation tile |
| `N_BRANCH_01` | T-Junction Senayan | Transition | Choice / Branch | Dual glowing directional arrows |
| `N_SUD_01` | Sudirman Financial Ave 1 | Sudirman CBD | Property (Office Floor)| Blue corporate glass tile |
| `N_SUD_02` | Halte TransSudirman | Sudirman CBD | Transit Hub | Busway icon tile |
| `N_SUD_03` | Tower Bank Cuan | Sudirman CBD | Bank / ATM | Cyber teal ATM vault tile |
| `N_SUD_04` | SCBD Coffee Corner | Sudirman CBD | Property (Cafe) | Roasted coffee bean badge |
| `N_SUD_05` | Sudirman North Gate | Sudirman CBD | Corporate Dividend | Gold dividend payout tile |
| `N_GANG_01` | Gang Senggol Entrance | Gang Senggol | Property (Warkop) | Wooden plank texture tile |
| `N_GANG_02` | Warung Pecel Lele | Gang Senggol | Culinary Hotspot | Lele fish emblem tile |
| `N_GANG_03` | Pos Ronda & Arisan | Gang Senggol | Chaos Event (Satpol PP)| Striped warning hazard tile |
| `N_GANG_04` | Pasar Kaget Subuh | Gang Senggol | Property (Kios Sayur) | Vegetable basket badge |
| `N_GANG_05` | Bengkel Motor Mas Joko | Gang Senggol | High-Stakes Gacha | Dice gamble lucky tile |
| `N_MERGE_01` | Bunderan HI Roundabout | Transition | Merge Node | Circular paving stone with fountain view |
| `N_16` | Jl. Medan Merdeka Barat | Monas Approach | Opportunity | Green Rupiah coin |
| `N_17` | Gerbang Barat Monas | Monas Approach | Property (Tourism Stall)| Red-white national ribbon |
| `N_18` | Pelataran Cawan Monas | Monas Plaza | Grand Event | Star medallion |
| `N_19` | Taman Merdeka Selatan | Monas Plaza | Property (Souvenir Hub)| Batik motif tile |
| `N_FINISH` | Tugu Monas Base | Monas Plaza | Victory / Climax | Grand golden pedestal with fire aura |

---

## 4. CAMERA CHOREOGRAPHY & VISUAL FRAMING

### A. Gameplay Camera (Orthographic-Perspective)
- **Positioning:** Offset `(28, 32, 28)` relative to current active player.
- **Angle:** `Pitch = -42°`, `Yaw = 45°`.
- **Field of View:** `48°`.
- **Dynamic Occlusion Handling:** Buildings directly between the camera ray and the active player node automatically lower their transparency to `0.35` via a client-side raycast dampener, ensuring zero visual blockage.

### B. Layered Visual Depth
To ensure the scene never looks flat:
1. **Foreground (Y = 0 to 4 studs):** Sidewalks, board nodes, curbs, small planters, street markings. Always sharp and clear.
2. **Midground (Y = 4 to 30 studs):** Shophouses, warkop tents, trees, bajaj, streetlights. Provides life and Indonesian flavor.
3. **Background (Y = 30 to 110 studs):** Sudirman skyscrapers, Monas obelisk tower, distant Jakarta skyline silhouettes. Provides metropolitan grandeur and immersion.
