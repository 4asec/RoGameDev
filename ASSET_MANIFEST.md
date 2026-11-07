# WARGA PARTY — 3D ASSET MANIFEST & RESEARCH BENCHMARK
**Document Version:** 1.0.0  
**Status:** Research & Verification Complete (Ready for Staged Ingestion)  
**Security Standard:** Strict Script Sanitization & Zero Untrusted Code  

---

## 1. ASSET SAFETY PROTOCOL & INGESTION RULES

All third-party assets evaluated from the Roblox Creator Store must undergo mandatory pre-flight inspection before insertion into production:

1. **Zero External Script Policy:**
   - Any third-party Model containing scripts (`Script`, `LocalScript`, `ModuleScript`) must be stripped of executable code unless authored by an approved first-party service.
   - Third-party scripts are common vectors for malicious backdoors, `require()` loaders, lag bombs, or unwanted GUI popups.
2. **Mesh Sanitization:**
   - Retain only `MeshPart`, `Part`, `Texture`, `SurfaceAppearance`, and `SpecialMesh`.
   - Delete all unused `ParticleEmitter`, `Sound`, `PointLight` (unless calibrated for street lighting), and `BillboardGui`.
3. **Anchor & Collision Pass:**
   - All environment geometry must have `Anchored = true` and `CanTouch = false` (except designated gameplay triggers).
   - Non-walkable props (streetlights, parked cars, background buildings) must have `CanCollide = false` or custom simplified collision boxes to optimize collision physics.

---

## 2. EVALUATED ASSET CATALOG BY CATEGORY

### Category A: Stylized City Buildings (CBD & Shophouses)

#### 1. City Model Building Skybox Pack
- **Asset Name:** City Model Building Sky Skybox House Street Tower
- **Asset ID:** `75885812380271`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/75885812380271)
- **Creator:** Crankneedle0649
- **Asset Type:** Model (130 parts, modular skyscrapers and shophouses)
- **Price:** Free (`$0.00`)
- **Script Status:** **ACCEPTED & SANITIZED (2 foreign scripts stripped)**
- **Scale:** Suitable (`173 x 253 x 268 studs` footprint, placed at Z = -110 as non-collidable background skyline)
- **Visual Quality & Fit:** **9/10** — Excellent low-poly stylized urban architecture; clean geometry with solid silhouette separation. Perfect for Sudirman CBD background.
- **Production Status:** **INGESTED INTO VERTICAL SLICE**

#### 2. Brada's City Building Pack (EVALUATED & REJECTED)
- **Asset Name:** Brada's City Building Pack
- **Asset ID:** `6748603434`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/6748603434)
- **Creator:** BattleBrada
- **Asset Type:** Model (1,998 primitive parts, 0 meshes)
- **Price:** Free (`$0.00`)
- **Script Status:** Clean (0 scripts)
- **Scale:** Extremely heavy instance count
- **Visual Quality & Fit:** **REJECTED** — Contains 1,998 individual primitive plastic parts for only 3 buildings. Exceeds the strict instance budget and violates the "no primitive part stacking" directive.
- **Production Status:** **REJECTED & REMOVED FROM STAGING**

---

### Category G: Train Station Assets

#### 1. Indonesian Train Station (Platform & Canopy) (EVALUATED & REJECTED)
- **Asset Name:** 🇮🇩 Indonesian Train Station Kereta Api RP
- **Asset ID:** `138136455459066`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/138136455459066)
- **Creator:** Swift_Hawk75404
- **Asset Type:** Model (577 parts, 0 meshes)
- **Script Status:** 1 script removed
- **Scale:** Miniature RO-scale (`9.4 x 5.0 x 29.5 studs`, tabletop scale)
- **Visual Quality & Fit:** **REJECTED** — Built for miniature tabletop train displays, not standard avatar scale. Replaced with bespoke Gambir heritage platform deck + arched steel truss canopy + full-scale KAI coach.
- **Production Status:** **REJECTED & REMOVED FROM STAGING**

#### 1. Road Model Pack (Modular System)
- **Asset Name:** Road model pack
- **Asset ID:** `102121652749164`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/102121652749164)
- **Creator:** akshaj974
- **Asset Type:** Model (Straight roads, T-junctions, 4-way intersections, bridges)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Standard modular roadway width (24 studs across, perfect 2-lane layout)
- **Visual Quality & Fit:** **9/10** — Clean asphalt surface without noisy grain; markings match stylized urban street needs.

#### 2. City Street Environment Stylized Road Pack
- **Asset Name:** [Road Pack] City Street Environment Stylized
- **Asset ID:** `118723696802541`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/118723696802541)
- **Creator:** Grace803Frost6807
- **Asset Type:** Model
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Compatible with 16-stud grid layout
- **Visual Quality & Fit:** **8.5/10** — Chunky cartoon curbs, vibrant road markings.

---

### Category C: Sidewalks and Intersections

#### 1. Low Poly Sidewalk Pack
- **Asset Name:** Low Poly Sidewalk Pack
- **Asset ID:** `2917507988`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/2917507988)
- **Creator:** BL00MIE
- **Asset Type:** Model (Modular sidewalk corners, curbs, transitions)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Perfect for 8-stud sidewalk grid with embedded board nodes
- **Visual Quality & Fit:** **9/10** — Rounded bevels on curb edges, matches *Animal Crossing* tactile aesthetic.

#### 2. Indonesian Road City Pack (Curbs & Segments)
- **Asset Name:** Indonesian Road City Pack Roads Long Dirt Street
- **Asset ID:** `111716598030496`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/111716598030496)
- **Creator:** Gracshad9015
- **Asset Type:** Model (Asphalt & concrete sidewalk combo)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Long straightaway segment (`47 x 1.1 x 362 studs`)
- **Visual Quality & Fit:** **8/10** — Useful for long peripheral boulevards framing the map boundaries.

---

### Category D: Stylized Trees and Vegetation

#### 1. Stylized Low Poly Tree Pack
- **Asset Name:** Stylized Low Poly Tree Pack
- **Asset ID:** `8281921041`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/8281921041)
- **Creator:** yetiii_050
- **Asset Type:** Model (Varied leafy canopy trees, shrubs)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** 12 to 22 studs height (proportional to buildings and avatars)
- **Visual Quality & Fit:** **9.5/10** — Volumetric cartoon tree crowns; clean emerald and olive tones. Essential for Monas Park (Medan Merdeka) and Sudirman street dividers.

#### 2. Stylized Windy Tree Pack (Asset Candidate with Script Stripping)
- **Asset Name:** 🌳 Stylized Windy Tree Pack | Low-Poly
- **Asset ID:** `125233229178878`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/125233229178878)
- **Creator:** twinks161721
- **Asset Type:** Model
- **Price:** Free (`$0.00`)
- **Script Status:** **CONTAINS SCRIPT (Wind movement script must be removed before production ingestion)**
- **Scale:** Suitable
- **Visual Quality & Fit:** **8.5/10** — Beautiful cloud-shaped foliage.

---

### Category E: Indonesian Urban Street Props

#### 1. Indonesian Penyetan / Pecel Lele Tent Stall
- **Asset Name:** Indonesian Penyetan Tent Stall Food Cart Street
- **Asset ID:** `137011458903864`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/137011458903864)
- **Creator:** Voltcho1354
- **Asset Type:** Model (Street food tent with typical Indonesian banner cloth)
- **Price:** Free (`$0.00`)
- **Script Status:** **CONTAINS SCRIPT (Has credit GUI & particle script — must be stripped to pure visual geometry)**
- **Scale:** Realistic street stall (`14 x 13 x 24 studs`)
- **Visual Quality & Fit:** **9.5/10** — Instant cultural recognition. Key anchor piece for Gang Senggol.

#### 2. Gerobak Bakso Tradisional
- **Asset Name:** Gerobak Bakso
- **Asset ID:** `11770070554` / `11595101455`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/11770070554)
- **Creator:** PenjagaPos_PJL / barbar9071
- **Asset Type:** Model (Wooden street cart, glass display, wheels)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** 6 x 6 x 8 studs (accurate avatar scale)
- **Visual Quality & Fit:** **9/10** — Perfect Indonesian street food prop.

#### 3. Indonesian Traffic Light & Street Light
- **Asset Name:** 🚦 Indonesian Traffic Light Road Street City RP
- **Asset ID:** `139335578477246`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/139335578477246)
- **Creator:** Swift_Hawk217
- **Asset Type:** Model (Yellow casing traffic light pole & PJU street light)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN (Visual only)**
- **Scale:** 18 studs tall (matches metropolitan street scale)
- **Visual Quality & Fit:** **9/10** — Faithful reproduction of Jakarta street signals.

---

### Category F: Stylized Vehicles

#### 1. Bajaj Khas Jakarta
- **Asset Name:** bajaj
- **Asset ID:** `9241769752`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/9241769752)
- **Creator:** Zylorey
- **Asset Type:** Model (3-wheeled Jakarta bajaj with license plate)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** 8 x 6 x 10 studs (matches R15 character seating)
- **Visual Quality & Fit:** **9.5/10** — Unmistakable Jakarta icon. Placed near Gambir exit and Gang Senggol corner.

#### 2. Indonesian Angkot Pack
- **Asset Name:** 3 INDONESIAN ANGKOTS [FREE]
- **Asset ID:** `15191461976`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/15191461976)
- **Creator:** JEMUELLLOYDDALIUAG
- **Asset Type:** Model (Public minivan variants: green, red, blue)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** 8 x 7 x 16 studs
- **Visual Quality & Fit:** **9/10** — Essential vehicle clutter for Sudirman avenue and bus stops.

#### 3. Pacifico Parked Cars (Low-Poly Civilian Fleet)
- **Asset Name:** Pacifico Parked Cars [Revamped]
- **Asset ID:** `98926724774714`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/98926724774714)
- **Creator:** dogfox0633
- **Asset Type:** Model (Non-drivable optimized civilian cars)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Optimized for road parking bays
- **Visual Quality & Fit:** **8.5/10** — Clean low-poly silhouettes without heavy texture overhead.

---

### Category G: Train Station Assets

#### 1. Indonesian Train Station (Platform & Canopy)
- **Asset Name:** 🇮🇩 Indonesian Train Station Kereta Api RP
- **Asset ID:** `138136455459066`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/138136455459066)
- **Creator:** Swift_Hawk75404
- **Asset Type:** Model (Waiting area, roof structure, station tracks, signage)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Station concourse (`60 x 24 x 90 studs`)
- **Visual Quality & Fit:** **9.5/10** — High architectural quality matching Gambir heritage aesthetics.

---

### Category H: Stylized Passenger Train

#### 1. Indonesian Coaches Trainset (Kereta Api Indonesia)
- **Asset Name:** Indonesian Coaches Trainset (Kereta Api Indonesia)
- **Asset ID:** `13032037603`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/13032037603)
- **Creator:** RizkyPT879
- **Asset Type:** Model (Executive passenger coach with orange/blue KAI stripes, interior seats)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN (Static model, scripts removed)**
- **Scale:** 12 studs wide x 12 studs tall x 84 studs long per carriage
- **Visual Quality & Fit:** **9.5/10** — Professional passenger train aesthetic. Serves as the introductory vehicle for character arrivals.

---

### Category I: Street Shops and Restaurants

#### 1. Warung Makan / Ruko Tradisional
- **Asset Name:** Warung Makan [FREE]
- **Asset ID:** `16403279361`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/16403279361)
- **Creator:** xzyerZack
- **Asset Type:** Model (Indonesian casual eatery with front awning and banner)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** 22 x 18 x 20 studs
- **Visual Quality & Fit:** **9/10** — Perfect for Gang Senggol and culinary tile stops.

#### 2. Inno Stylized Asset Pack (Shop Props & Furnishings)
- **Asset Name:** Inno Stylized Asset Pack 3D Game Props Env
- **Asset ID:** `121568152344632`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/121568152344632)
- **Creator:** Shadog2807
- **Asset Type:** Model (Chunky cartoon props, crates, benches, awnings)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** Fits avatar scale seamlessly
- **Visual Quality & Fit:** **9/10** — Directly matches the *Overcooked* art direction.

---

### Category J: City Landmark Assets (Monas)

#### 1. Monumen Nasional (Monas)
- **Asset Name:** MONUMEN NASIONAL
- **Asset ID:** `13449329976`
- **Creator Store Link:** [View on Creator Store](https://create.roblox.com/store/asset/13449329976)
- **Creator:** deni_saputra22
- **Asset Type:** Model (Complete Monas tower with base obelisk and gold flame)
- **Price:** Free (`$0.00`)
- **Script Status:** **CLEAN**
- **Scale:** ~85 studs height (needs minor rescale to 110 studs for dramatic background focal point)
- **Visual Quality & Fit:** **8.5/10** — Iconic silhouette. Will be placed in the center of District 4's grand marble plaza.

---

## 3. DISTRICT ASSET ASSIGNMENT MATRIX

| District | Core Architectural Mesh Kits | Cultural & Street Clutter Props | Vehicle Set |
| :--- | :--- | :--- | :--- |
| **District 1: Gambir Gateway** | `138136455459066` (Gambir Station), `2917507988` (Sidewalks) | Indonesian rail signs, benches, luggage trolleys | `13032037603` (KAI Train), `9241769752` (Bajaj) |
| **District 2: Sudirman CBD** | `75885812380271` (Skyscrapers), `102121652749164` (Avenue Roads) | `139335578477246` (PJU Streetlights), Bus stop shelters | `15191461976` (Angkot), `98926724774714` (Parked Cars) |
| **District 3: Gang Senggol** | `6748603434` (Shophouses), `121568152344632` (Stylized Props) | `137011458903864` (Pecel Lele), `11770070554` (Gerobak) | `9241769752` (Bajaj), Static scooter motorbikes |
| **District 4: Monas Plaza** | `13449329976` (Monas Tower), Marble terrace pavements | `8281921041` (Palms & Banyan Trees), Water fountains | Parade vehicles / Ceremonial perimeter |
