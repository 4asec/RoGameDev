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

### A. Vertical Slice 1 Active Coordinates & Zone Boundaries
- **Center of Roadway:** `X = 5, Y = 0.2, Z = 0` (Main Protocol Avenue).
- **Gambir Platform 1 & Track:** `X = -44` (Rails) to `X = -27` (Platform deck), `Z = -45 to +45`.
- **Station Concourse Steps & Ramp:** `X = -18 to -13, Z = -20 to +20` (Stepped descent from Y = 2.5 to Y = 0.8).
- **West Sidewalk & Pangkalan Bajaj:** `X = -10, Y = 0.8, Z = -50 to +50`.
- **Pedestrian Zebra Crossing:** `Z = 24 to 34, X = -6.5 to +16.5`.
- **East Sidewalk & Gang Senggol Promenade:** `X = 22, Y = 0.8, Z = -50 to +50`.
- **Warung Pecel Lele & Street Food Hub:** `X = 27, Y = 0.8, Z = 34`.
- **Background Skyline Framing:** `X = -20, Y = 0, Z = -110` (Non-collidable background).

### B. Vertical Slice Board Nodes (Embedded 3D Pedestals)

| Node ID | Physical Coordinates (Vector3) | District / Location | Node Type | Gameplay & Visual Treatment |
| :--- | :--- | :--- | :--- | :--- |
| `N_START` | `(-26.0, 2.56, 0.0)` | Gambir Platform 1 | Start | Golden stone slab with 🚆 train icon; player arrival point. |
| `N_01` | `(-18.0, 2.56, 12.0)` | Concourse Tiket Gambir | Opportunity | Emerald luck slab with 🪙 Rupiah coin; chance event. |
| `N_02` | `(-10.0, 0.86, 22.0)` | Pangkalan Bajaj Gambir | Property | Transit blue slab with 🛺 bajaj emblem; purchasable kiosk. |
| `N_03` | `(-8.0, 0.86, 29.0)` | Penyeberangan Zebra Cross | Event | Coral warning slab with ⚠️ exclamation; traffic check. |
| `N_BRANCH_01` | `(5.0, 0.46, 29.0)` | Simpang Senayan / Zebra Cross | Branch | Golden crossroads slab with 🔀 branch fork indicator. |
| `N_GANG_01` | `(18.0, 0.86, 29.0)` | Kios Sayur Gang Senggol | Property | Orange commercial slab with 🏪 kiosk icon; affordable shop. |
| `N_GANG_02` | `(22.0, 0.86, 36.0)` | Warung Pecel Lele Cak Slamet | Property | Caramel culinary slab with 🍲 meal badge; high-return eatery. |
| `N_FINISH` | `(22.0, 0.86, 50.0)` | Monas Plaza Showcase | Finish | Golden finish victory pedestal. |

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
