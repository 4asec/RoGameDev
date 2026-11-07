# Changelog

All notable changes to the **RoGameDev** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.3.0] - 2026-11-08

### Added
- **3D Indonesian City Environment (`EnvironmentService.luau`):**
  - Connected dark asphalt roads with yellow dashed center lines and concrete curbs/sidewalks across all 13 board nodes.
  - **Tugu Monas Landmark** at FINISH plaza: Multi-tiered marble podium, grand obelisk spire (85 studs tall), top observation deck, and glowing golden flame of independence with PointLight.
  - **Stasiun Gambir Landmark** at START: Raised concrete platform with structural canopy beams, train tracks with rails/ties, and 3D Indonesian Executive Train carriage in signature KAI livery.
  - **Jalan Sudirman Modern District**: Dual high-rise skyscrapers (120 studs glass tower with glowing neon window grids), Bank Kota Sudirman with classical marble pillars and ATM sign, and Restoran Sultan.
  - **Gang Senggol Traditional District**: Authentic *Warung Madura 24 Jam* with red-and-white awning and 3kg green LPG cylinder stack, traditional *Pos Ronda Kamling* with bamboo pillars and wooden kentongan, and *Warkop Cuan*.
  - **Taman Suropati Checkpoint**: Green urban park with stone fountain basin and tropical shade trees.
  - Street lighting network with overhead metal lamps and traffic signals at branching intersections.
  - Upgraded all 13 board game tiles from plain blocks into sleek, high-visibility 3D game pedestals with glowing neon borders, category badges, and emoji icons.
- **GitHub Integration:**
  - Published public repository `https://github.com/4asec/RoGameDev` and pushed initial releases cleanly.

---

## [0.2.0] - 2026-11-08

### Added
- **Core Architecture & Foundation (`src/`):**
  - Modular Rojo-ready architecture (`default.project.json`) partitioned into `Server/`, `Client/`, and `Shared/`.
  - Shared Configs: `GameConfig.luau`, `EconomyConfig.luau`, `PropertyConfig.luau`, `EventConfig.luau`.
  - Shared Network: `RemoteDefinitions.luau` defining RemoteEvents and RemoteFunctions.
  - Shared Types: `BoardTypes.luau`, `MatchTypes.luau`.
  - Shared Utils: `MathUtil.luau` (Rupiah formatting & math helpers), `TableUtil.luau`.
- **Server Services (`src/Server/Services/`):**
  - `DiceService`: Cryptographically secure server-authoritative dice rolling engine.
  - `BoardService`: 3D Open City Board graph system featuring the Jakarta Monas circuit with branching paths (*Jalan Sudirman* vs *Gang Senggol*).
  - `MovementService`: Path traversal calculations, intersection detection, and waypoint interpolation.
  - `EconomyService`: Transactional player balance mutations, overdraft protection, and final score evaluation.
  - `PropertyService`: Property purchase, tier 1–3 upgrade system, and automated rent collection.
  - `BankService`: Debt tracking, multi-loan limits, 5% per-turn interest accumulation, and repayment systems.
  - `InvestmentService`: Speculative dice outcome betting system over 3 rounds with dividend distribution.
  - `EventService`: Absurd Indonesian random events framework (*Tukang Parkir Gaib*, *Emak Sein Kiri*, *Bansos Nyasar*) and government policies.
  - `TurnService`: Sequential turn cycling, 25-second countdown timers, and skip logic.
  - `DisconnectService`: 7-minute connection grace period manager.
  - `AIPlayerService`: Heuristic autonomous bot fallback for disconnected players.
  - `PlayerDataService`: Persistent DataStore caching and session loading.
  - `MatchService`: Central match coordinator and finish line podium evaluator.
- **Client Controllers (`src/Client/Controllers/`):**
  - `BoardVisualController`: 3D tile rendering in Workspace and character movement animation.
  - `CameraController`: Contextual isometric camera with character tracking and smooth tweens.
  - `UIController`: Full responsive in-game HUD with turn banners, animated roll button, branch selector modal, event pop-ups, and podium results.
- **Roblox Studio Integration:**
  - Injected complete service and controller hierarchy into live Studio DataModel (`Place2`).
  - Generated 13 3D visual board tiles in Workspace.
  - Verified playtest execution in Studio with zero runtime errors.

---

## [0.1.0] - 2026-11-08

### Added
- Initialized local Git repository on branch `main` at `D:\RoGameDev`.
- Inspected environment tools (Git v2.54.0, Roblox Studio MCP bridge active on `Place2`).
- Established comprehensive documentation suite:
  - `GDD.md`: Complete Game Design Document.
  - `TECHNICAL_DESIGN.md`: Full Luau service architecture and server-authoritative network contract.
  - `UI_UX_GUIDELINES.md`: Visual identity, design tokens, responsive layout blueprints, and animation rules.
  - `ECONOMY_DESIGN.md`: Dual currency model, property pricing, dice investment math, bank loans, and end-game scoring formulas.
  - `EVENT_DESIGN.md`: Data-driven event schema, rarity weighting, Indonesian absurd event catalog, and policy system.
  - `DEVELOPMENT_ROADMAP.md`: Structured 10-phase execution plan from foundation to release readiness.
  - `TESTING_PLAN.md`: Verification matrices, multiplayer scaling tests, and exploit prevention checks.
  - `OPEN_DECISIONS.md`: Decision tracker for game title proposals, economic parameters, and turn timers.
  - `README.md`: Professional project landing page with architecture diagram and setup instructions.
  - `CONTRIBUTING.md`: Workflow standards, commit policies, and pull request guidelines.
