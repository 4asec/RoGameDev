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

### A. Vertical Slice 1 Reworked Coordinates & Non-Overlapping Zone Boundaries
- **Slice Ground Foundation:** `X = 0, Y = -2.0, Z = 0` (Solid concrete diorama slab: `120 x 4 x 120` studs, eliminating all void).
- **Zona 1 & 2: Gambir Platform & Track:**
  - Steel Rails & Ties: `X = -46.0, Y = 1.1, Z = 0` (Gravel bed width 14 studs, length 100 studs).
  - Single **KAI Executive Coach** (`K1 0 96`): `X = -46.0, Y = 7.6, Z = 0.0` (Dimensions: `10.0 x 12.4 x 74.6` studs). Clearance to platform edge: 4.5 studs.
  - Platform Deck: `X = -28.0, Y = 1.25, Z = 0.0` (Dimensions: `16 x 2.5 x 90` studs).
  - Tactile Yellow Warning Line: `X = -35.4, Y = 2.53, Z = 0.0`.
  - Station Steel Canopy: Roof `X = -27.5, Y = 18.9, Z = 0.0` with warm platform lanterns.
- **Zona 3: Station Transition Steps & West Plaza:**
  - 5-Tier Broad Stone Steps: `X = -19.4 to -14.6, Y = 2.16 down to 0.80, Z = 0` (40 studs wide).
  - West Sidewalk Plaza: `X = -10.75, Y = 0.4, Z = 0` (Width 6.5 studs, length 100 studs).
  - Pangkalan Bajaj: Parked at North bay `X = -10.5, Y = 0.85, Z = -28.0` (Clear of stairs and board tiles).
  - Stylized Sidewalk Tree: Planter at `X = -10.5, Y = 0.85, Z = -38.0`.
  - PJU Street Light Pole: `X = -7.8, Y = 7.4, Z = -10.0`.
- **Zona 4: Protocol Avenue & Zebra Crossing:**
  - Two-Lane Asphalt Road: `X = 4.5, Y = 0.2, Z = 0` (Width 24 studs, length 100 studs).
  - Dashed Yellow Centerline: Along `X = 4.5`.
  - Pedestrian Zebra Crossing: `Z = 24 to 34, X = -5.5 to +14.5` (White stripes on asphalt).
- **Zona 5: Persimpangan Utama & Traffic Light Gantry:**
  - Sinyal Gantry Overhead: Mast base anchored on East curb at `X = 16.2, Y = 0.85, Z = 22.0`, cantilever arm extends across road over zebra crossing.
- **Zona 6: Gang Senggol Promenade & Sentra Kuliner:**
  - East Sidewalk Promenade: `X = 21.5, Y = 0.4, Z = 0` (Width 10 studs, length 100 studs).
  - Culinary Ground Strip: `X = 33.5, Y = 0.4, Z = 0` (Width 14 studs, pebble finish).
  - Gerobak Bakso Mamang: `X = 30.5, Y = 0.85, Z = 4.0`.
  - Warung Pecel Lele Tenda: `X = 33.5, Y = 0.85, Z = 32.0` (16 studs pedestrian clearance between food stalls).
  - Stylized Shade Tree: Planter at `X = 21.5, Y = 0.85, Z = -20.0`.
  - Shophouse Facades (Ruko): Wall at `X = 43.0, Y = 12.0, Z = 15.0` with rolling metal doors and colorful canvas awnings.
- **Zona 7: Background Metropolitan Skyline Framing:**
  - Distant Skyscrapers: `X = -10.0, Y = 0.0, Z = -185.0` (Front edge at `Z = -51.0`, strictly behind slice boundary `Z <= -50`).

### B. Vertical Slice Board Nodes (Embedded 3D Pedestals)

| Node ID | Physical Coordinates (Vector3) | District / Location | Node Type | Gameplay & Visual Treatment |
| :--- | :--- | :--- | :--- | :--- |
| `N_START` | `(-26.0, 2.56, 0.0)` | Gambir Platform 1 | Start | Golden beveled medallion with 🚆 train icon; player arrival point. |
| `N_01` | `(-17.5, 2.56, 14.0)` | Concourse Tiket Gambir | Opportunity | Emerald luck medallion with 🪙 Rupiah coin; chance event. |
| `N_02` | `(-10.5, 0.86, 16.0)` | Pangkalan Bajaj Gambir | Property | Transit blue medallion with 🛺 bajaj emblem; purchasable kiosk. |
| `N_03` | `(-7.5, 0.86, 29.0)` | Penyeberangan Zebra Barat | Event | Coral warning medallion with ⚠️ exclamation; traffic check. |
| `N_BRANCH_01` | `(4.5, 0.46, 29.0)` | Simpang Senayan / Zebra Cross | Branch | Golden crossroads medallion with 🔀 branch fork indicator. |
| `N_GANG_01` | `(21.0, 0.86, 29.0)` | Sentra Kuliner Gang Senggol | Culinary | Red culinary medallion with 🍲 meal badge; high-return eatery. |
| `N_GANG_02` | `(21.0, 0.86, 42.0)` | Gang Senggol Promenade | Social | Green community medallion with 🏪 kiosk icon; leads to Pasar. |

### C. Automated Spatial Collision Audit Results
- **Initial Structural Conflicts:** 152 collisions (skyline engulfment, train diagonal span, gantry offset penetration, Bajaj on tile N_02, food stalls touching shophouses).
- **Post-Rework Macro Conflicts:** **0 conflicts** (100% verified non-overlapping AABB geometry).

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
