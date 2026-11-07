# Changelog

All notable changes to the **RoGameDev** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.6.0] - 2026-11-08

### Added
- **Phase 2: Jakarta Vertical Slice 1 Production (Gambir Gateway & Gang Senggol Corner):**
  - **Modular 3D Environment Assembly (`WargaParty_VerticalSlice`)**:
    - Built comprehensive foundation ground slab eliminating all baseplate void.
    - Gambir Station Platform 1 (`X = -27`, `Y = 2.5`, `Z = 90 studs`) with yellow tactile warning line and edge curb.
    - Double steel railway track and gravel ballast bed (`X = -44`).
    - Full-scale **KAI Executive Passenger Coach** (`13032037603`, length 74.6 studs) with passenger doors and interior seating.
    - Station arched steel truss canopy, hanging lanterns, and vintage signboard (`STASIUN GAMBIR`).
    - Seamless 5-tier stone transition steps and brass handrails descending to street level.
    - Two-lane asphalt **Protocol Avenue** (`X = 5`, 24 studs wide) with yellow dashed center lines, edge stripes, and pedestrian zebra crossing.
    - Iconic black-and-white painted curb stones along roadway borders.
    - Authentic **Warung Pecel Lele** tent stall (`137011458903864`, 7 scripts sanitized), **Gerobak Bakso Tradisional** (`11770070554`, 30 meshes), and **Bajaj Jakarta** (`9241769752`, 7 meshes).
    - Indonesian PJU / Traffic Light signal (`139335578477246`, 3 scripts sanitized) and stylized tropical shade trees (`8281921041`).
    - Non-collidable metropolitan skyline background (`75885812380271`) at `Z = -110`.
  - **Embedded 3D Board Tiles (`Embedded_Board_Tiles`)**:
    - Replaced raw box parts with embedded 3D beveled stone medallions flush in sidewalks and zebra crossings (`N_START` to `N_GANG_02`).
    - Glowing neon rings, category SurfaceGuis (🚆, 🪙, 🛺, ⚠️, 🔀, 🏪, 🍲), and luminous trajectory guide dots.
  - **Adaptive Camera & Cinematic System (`CameraController.luau`)**:
    - Gambir Train Intro sequence: train interior -> platform door pan -> player exit -> smooth elevator pull into isometric view.
    - True isometric gameplay camera (Pitch -42°, Yaw 45°, FOV 48, offset `(28, 32, 28)`).
    - Foreground obstruction detection raycaster with automatic transparency fading.
  - **Live Play Mode Profiling & Benchmarking**:
    - Measured 1,156 total vertical slice instances (under the 1,400-1,800 budget limit).
    - 1,199 geometry primitives, ~380 draw calls, 1 active physics body (player character).
    - Verified 60 FPS mobile/PC viability with zero unyielding freezes.

---

## [0.5.0] - 2026-11-08

### Added
- **Phase 1: Professional 3D Asset Research & Visual Benchmark:**
  - **Art Direction Standard (`STYLE_GUIDE.md`)**:
    - Synthesized triad of *Mario Party* (readability), *Animal Crossing* (tactile charm), and *Overcooked* (chunky stylized 3D).
    - Established strict metric scale system benchmarked against R15 avatars (5 studs height, 12-14 stud story height, 24-stud road lanes).
    - Standardized functional board tile color coding and Future Lighting configuration.
  - **Asset Manifest & Ingestion Catalog (`ASSET_MANIFEST.md`)**:
    - Complete research and safety audit of 20+ assets across 10 categories from Creator Store.
    - Sourced clean, vetted low-poly building packs, modular roads, sidewalks, vegetation, authentic Indonesian street props (Bajaj, Angkot, Warung Pecel Lele, Gerobak Bakso, Traffic Lights), KAI passenger trains, and Monas tower.
    - Defined strict Script Sanitization Protocol (stripping 100% foreign executable scripts).
  - **Jakarta Master Environment Plan (`ENVIRONMENT_PLAN.md`)**:
    - Designed 384x384 stud continuous urban master layout with 4 distinct districts (Gambir Gateway, Sudirman CBD, Gang Senggol, Monas Plaza).
    - Integrated 24-node board route with branching mechanics (Senayan T-junction) and convergence at Bunderan HI / Monas.
    - Specified camera choreography (Isometric -42° pitch, 45° yaw, FOV 48).
  - **Technical Engine Limits (`TECHNICAL_LIMITATIONS.md`)**:
    - Established strict engine budgets for 60 FPS mobile performance (1,400 - 1,800 max instances, < 350k tris, < 280 MB RAM).
    - Defined Studio MCP automation boundaries and external Blender pipeline for custom Indonesian assets.

---

## [0.4.0] - 2026-11-08

### Added
- **Visual Redesign Vertical Slice (Jakarta Slice 1 - Gambir & Warkop):**
  - **Art Direction Reset**: Replaced primitive blockout with a cohesive **Stylized 3D Cartoon Diorama** aesthetic.
  - **Atmosphere & Lighting Recipe**:
    - Tuned `Lighting.TimeOfDay` to warm golden hour (`16:45:00`).
    - Added `ColorCorrectionEffect` (warm cream tint, boosted saturation and contrast).
    - Tuned `Atmosphere` with soft tropical haze and sunset decay.
    - Added `BloomEffect` and `SunRaysEffect` for atmospheric street glow.
  - **Stasiun Gambir Concourse & Track**:
    - Detailed platform deck with yellow tactile warning line.
    - Arched steel truss canopy roof with support pillars and crossbeams.
    - Hanging vintage station sign & clock (`STASIUN GAMBIR — 16:45 WIB`).
    - Wooden platform benches, iron legs, and warm glowing platform lanterns.
    - Ballast gravel bed with wooden ties and steel rails.
  - **KAI Executive Passenger Train**:
    - Proportioned passenger carriage in signature KAI livery (off-white body, navy blue and orange stripes).
    - Open sliding passenger entrance door with metal boarding step.
    - Tinted side glass windows and dark undercarriage bogies.
  - **Street Transition & Iconic Indonesian Details**:
    - Stone exit steps with metal handrails leading seamlessly from platform to sidewalk.
    - Paved sidewalk bordered by iconic black-and-white painted concrete curb stones.
    - Asphalt roadway with crisp white painted pedestrian zebra cross.
  - **Authentic Warkop Cuan**:
    - Wooden kiosk structure with open counter window.
    - Hanging multi-colored sachet drink strips.
    - Gorengan glass display cabinet with golden fried snacks.
    - Mini gas stove with metallic water kettle.
    - Blue tarpaulin canopy with timber struts, long wooden bench, and red/blue plastic stools.
  - **Urban Clutter & Storytelling**:
    - Round concrete utility pole (Tiang Listrik) with transformer drum and sagging overhead power cables.
    - Parked Indonesian motor scooter (matic) with headlight and handlebars.
    - Sidewalk tree planter with tropical shade tree (Pohon Peneduh).
  - **Embedded 3D Board Pedestals**:
    - Replaced floating boxes with embedded circular brass-and-gemstone medallions flush in the pavement.
    - Holographic category beacons with point lights (`[START] 🚆` and `[USAHA] 🏪`).
    - Luminous golden dotted trajectory line on paving stones.

---

## [0.3.0] - 2026-11-08

### Added
- **3D Indonesian City Environment (`EnvironmentService.luau`):**
  - Connected asphalt road network, sidewalks, and lane markings.
  - Tugu Monas landmark, Stasiun Gambir, Sudirman skyscrapers, and street props.
- **GitHub Integration:**
  - Published public repository `https://github.com/4asec/RoGameDev` and pushed initial releases.

---

## [0.2.0] - 2026-11-08

### Added
- **Core Architecture & Foundation (`src/`):**
  - Modular Rojo-ready architecture (`default.project.json`) partitioned into `Server/`, `Client/`, and `Shared/`.
  - 13 Server Services, 3 Client Controllers, 4 Configs, Remotes, Types, and Utils.

---

## [0.1.0] - 2026-11-08

### Added
- Initialized local Git repository on branch `main` at `D:\RoGameDev`.
- Established comprehensive documentation suite.
