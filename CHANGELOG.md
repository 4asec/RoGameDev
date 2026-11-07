# Changelog

All notable changes to the **RoGameDev** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
