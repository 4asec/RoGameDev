# WARGA PARTY — STYLE GUIDE & ART DIRECTION
**Document Version:** 1.0.0  
**Project Identity:** Warga Party  
**Lead Role:** Senior Environment Art Director & 3D World Designer  
**Platform:** Roblox (Luau Engine)  
**Target Visual Fidelity:** Premium Stylized 3D Cartoon Metropolis  

---

## 1. VISION & INSPIRATIONAL TRIAD

*Warga Party* brings the hilarious, absurd, and chaotic everyday life of Indonesia into a polished, high-replayability 3D multiplayer board game. The visual presentation must balance board game readability with rich environmental charm.

```
       [ Mario Party ]
       Board Readability &
       Vibrant Feedback
             ▲
             │
             │
[ Animal Crossing ] ◄───────► [ Overcooked ]
Cozy Charm, Friendly         Stylized 3D Bevels,
Silhouettes & Warmth         Punchy Colors & Clarity
             │
             ▼
    [ WARGA PARTY ]
  Authentic Indonesian Urban
  Atmosphere & Stylized Satire
```

1. **Mario Party (Board Presentation & Clarity):**
   - The playable board routes must never get lost inside environmental clutter.
   - Distinct, glowing, readable node tiles that instantly communicate game state.
   - Smooth isometric camera following players across intersections and events.

2. **Animal Crossing (Environmental Charm & Warmth):**
   - Friendly proportions, slightly oversized doors and windows, inviting architectural silhouettes.
   - Warm golden hour daylight, swaying tropical foliage, and gentle ambient occlusion.
   - Tactile feel: rounded curbs, clean asphalt, chunky concrete tiles.

3. **Overcooked (Stylized 3D Composition & Punchy Accents):**
   - Chunky chamfered geometry rather than razor-sharp realism.
   - High-contrast, saturated focal points (signboards, neon banners, yellow curbs).
   - Visual hierarchy: foreground gameplay elements pop, midground provides character, background provides metropolitan depth.

4. **Authentic Indonesian Urban Identity:**
   - Gambir railway heritage, Sudirman modern glass skyscrapers, tangled stylized electrical wires, colorful warung/warkop canopies, iconic street food carts (gerobak bakso/mie ayam), and the majestic gold flame of Monas.

---

## 2. COLOR PALETTE & LIGHTING SPECIFICATIONS

### A. Core Environmental Palette
The game avoids drab grayscale realism and hyper-dark grimy tones. Urban elements are clean, warm, and inviting.

| Element | Color Name | Hex Code | RGB | Material / Shading |
| :--- | :--- | :--- | :--- | :--- |
| **Primary Accent (Warmth)** | Jakarta Terracotta | `#E07A5F` | `224, 122, 95` | Matte Plaster / SmoothPlastic |
| **Secondary Accent (Transit)**| TransJakarta Teal Blue | `#264653` | `38, 70, 83` | Painted Metal / Plastic |
| **Vegetation & Tropical** | Monas Park Emerald | `#2A9D8F` | `42, 157, 143` | Stylized Foliage / Grass |
| **Highlight & Golden Hour** | Warung Mustard Sun | `#F4A261` | `244, 162, 97` | Warm Emissive / Neon (0.1) |
| **Roadway & Asphalt** | Urban Slate Grey | `#3D405B` | `61, 64, 91` | Matte Asphalt (No noisy specular) |
| **Pedestrian Sidewalk** | Clean Limestone Sand | `#F4F1DE` | `244, 241, 222` | Concrete / Paving Block |
| **National Landmark** | Monas Pure Marble | `#F8F9FA` | `248, 249, 250` | Smooth Marble |
| **Monas Flame** | Cawan Kencana Gold | `#FFD166` | `255, 209, 102` | Stylized Metal / Gold Foil |

### B. Board Node Functional Color System
Board tiles must follow an unambiguous color code visible from the top-down isometric camera:

| Node Type | Color | Hex | Purpose / Visual Cue |
| :--- | :--- | :--- | :--- |
| **START** | Golden Dawn | `#F9C74F` | Train Station Gateway emblem, particle shimmer |
| **PROPERTY (Low-tier)** | Kampoeng Orange | `#F8961E` | Warung & Ruko distrik, small rent flag |
| **PROPERTY (High-tier)**| Corporate Blue | `#4D908E` | Sudirman office tower, skyscraper hologram |
| **EVENT (Bencana/Chaos)**| Warning Coral | `#F94144` | Exclamation mark, spinning comic badge |
| **OPPORTUNITY (Cuan)** | Emerald Luck | `#43AA8B` | Indonesian Rupiah coin emblem (Rp) |
| **BANK / FINTECH** | Cyber Teal | `#577590` | ATM icon, holographic digital grid |
| **WARKOP / REST** | Coffee Caramel | `#BC6C25` | Steaming tea glass icon, cozy glow |
| **FINISH / MONAS** | Victory Gold | `#FFD700` | Fireworks emitter, grand Monas arch |

### C. Lighting Engine Configuration (`Lighting`)
- **Technology:** `Enum.Technology.Future` (Crucial for crisp local shadows and stylized ambient bounce).
- **TimeOfDay:** `16:30:00` (Late afternoon / Golden Hour).
- **Brightness:** `2.2`
- **OutdoorAmbient:** `RGB(120, 108, 98)` (Warm bounce, avoiding pitch black shadows).
- **ClockTime / GeographicLatitude:** `ClockTime: 16.5`, `GeographicLatitude: 6.2` (Equatorial Jakarta sun angle).
- **Atmosphere Settings:**
  - `Density`: `0.26`
  - `Offset`: `0.2`
  - `Color`: `RGB(255, 235, 215)` (Soft peach haze)
  - `Decay`: `RGB(140, 110, 95)`
  - `Haze`: `1.1`
  - `Glare`: `0.05`
- **Post-Processing Effects:**
  - `ColorCorrectionEffect`: `Saturation = 0.18`, `Contrast = 0.12`, `TintColor = RGB(255, 250, 242)`.
  - `BloomEffect`: `Intensity = 0.35`, `Size = 18`, `Threshold = 0.85`.
  - `SunRaysEffect`: `Intensity = 0.15`, `Spread = 0.7`.

---

## 3. ARCHITECTURE, GEOMETRY & SCALE STANDARDS

All models, environment assets, and props must be calibrated against standard Roblox avatar rigs.

```
                  ┌─────────┐
                  │ (Head)  │  ◄── 5.0 studs (R15 Avatar Standard)
                  │ ┌─────┐ │
                  │ │Torso│ │
                  │ └─────┘ │
                  │  |   |  │
 ═════════════════╧══╧═══╧══╧═════════════════  Y = 0.0 (Sidewalk)
```

### A. Architectural Metric System
- **1 Stud Benchmark:** ~0.28 meters (Roblox engine standard).
- **Avatar Height:** `5.0 studs` (R15 standard rig).
- **Doorway Dimensions:** `7.5 studs high` x `4.0 studs wide` (Slightly oversized for playful cartoon proportions).
- **Building Story Height:** `12.0 - 14.0 studs` per floor.
- **Shopfronts (Ruko / Warung):** `18 - 24 studs wide`, `20 - 28 studs deep`, `18 - 26 studs tall` (2-story ruko).
- **Skyscrapers (Sudirman):** `36 - 48 studs wide`, `60 - 90 studs tall` (Scaled to frame the background without obstructing top-down isometric gameplay).
- **Road Width:**
  - Standard 2-lane metropolitan street: `24 studs` wide (12 studs per lane).
  - Sidewalks: `8 - 10 studs` wide on each side (Spacious enough to embed 8-stud board tiles + street props).
  - Alleyway (Gang Senggol): `12 - 14 studs` total width (Intimate, narrow Indonesian kampung feel).

### B. Board Tile Geometry & Integration
- **Tile Physical Form:** Embedded circular or rounded-square paving slabs (`8 x 0.8 x 8 studs`).
- **Elevation:** Rests `0.15 studs` above sidewalk pavement to prevent Z-fighting while maintaining a flush, integrated urban appearance.
- **Edge Chamfer:** Clean beveled edge with a subtle emissive border (`Neon` transparency 0.6).
- **Decal / Surface UI:** Crisp vector icons indicating tile function, visible from high camera altitudes.

---

## 4. CAMERA & CINEMATOGRAPHIC SPECIFICATIONS

### A. Isometric Gameplay Camera
The primary camera is a smooth, high-angle isometric perspective that prioritizes board legibility:
- **CameraType:** `Enum.CameraType.Scriptable` (managed by `CameraController.client.luau`).
- **Pitch Angle:** `-42.0°` (Slightly higher than classic 45° to provide greater tile-forward visibility).
- **Yaw Angle:** `45.0°` (True isometric diagonal orientation).
- **Field of View (FOV):** `48°` (Reduces wide-angle lens distortion, giving a clean miniature diorama feel).
- **Offset from Player:** `Vector3.new(28, 32, 28)`.
- **Damping & Lerp:** Smooth dampening (`DeltaTime * 6.5`) to eliminate camera jitter during dice movements.

### B. Cinematic Camera Angles
- **Gambir Train Arrival Sequence:**
  - Low-angle tracking shot (`Pitch = -8°`, `FOV = 55°`) following the stylized executive train as it glides into platform 1.
  - Smooth pan up to the Gambir heritage station canopy.
- **Landmark Reveal (Monas):**
  - Dramatic sweeping orbit around the gold flame of Monas before transitioning smoothly back to the player's starting tile.

---

## 5. QUALITY BENCHMARKS: DO'S AND DON'TS

### DO:
- **Do use cohesive stylized modular mesh kits:** Clean silhouettes, rounded bevels, and uniform texel density.
- **Do embed board tiles into the city architecture:** Players should walk on actual sidewalks, pedestrian zones, and zebra crossings.
- **Do curate and strip scripts from Creator Store models:** Only use visual meshes and sanitize all unknown third-party scripts.
- **Do maintain clean visual hierarchy:** Gameplay paths must always be brighter and higher-contrast than decorative background buildings.

### DON'T:
- **Don't build complex props using raw Roblox primitive parts:** Never assemble vehicles, street food carts, or detailed buildings out of dozens of default plastic boxes and cylinders.
- **Don't use noisy hyper-realistic textures:** Avoid photographic concrete or grunge textures that clash with the cartoon aesthetic.
- **Don't leave the environment as an isolated diorama slab on an empty baseplate:** The city must feel continuous, bounded by layered skylines, tree lines, or perimeter avenues.
- **Don't obstruct the camera:** Buildings in the foreground must use automatic transparency or low rooflines so players are never hidden behind skyscrapers.
