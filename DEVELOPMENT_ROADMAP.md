# DEVELOPMENT ROADMAP
# Project Phased Execution Plan (Phase 0 to Phase 10)

**Document Version:** 1.1.0  
**Current Milestone:** Phase 2 through Phase 6 Implemented & Verified in Roblox Studio  
**Execution Mode:** Iterative, Server-Authoritative, Test-Driven  

---

## Roadmap Overview

```
[ PHASE 0: Inspection & Setup ] ──► [ PHASE 1: Design Specs (GDD/TDD) ] ──► [ PHASE 2: Core Foundation ]
                                                                                   │
[ PHASE 5: Events & NPC ] ◄── [ PHASE 4: Economy & Banking ] ◄── [ PHASE 3: Gameplay & Board ]
       │
       ▼
[ PHASE 6: Multiplayer & AI ] ──► [ PHASE 7: Visuals & Train Intro ] ──► [ PHASE 8: Meta Progression ]
                                                                                   │
                                  [ PHASE 10: Release Checklist ] ◄── [ PHASE 9: QA & Balancing ]
```

---

## Detailed Phases & Milestones

### Phase 0: Environment Inspection & Studio Bridge
- [x] Inspect local tooling (Git, PATH, gh, winget).
- [x] Verify Roblox Studio MCP connectivity and active place status.
- [x] Assess synchronization workflows (Roblox Studio MCP vs Rojo).
- [x] Formulate initial directory layout and `.gitignore`.
- [x] Prepare comprehensive Game Design & Technical documentation suite.
- [x] Log decisions in `OPEN_DECISIONS.md`.

### Phase 1: Game Design & Core Architecture Formulation
- [x] Formulate provisional game name: *Warga Party: Petualangan Cuan & Apes*.
- [x] Complete GDD, Technical Design, UI/UX Guidelines, Economy Design, and Event Design.
- [x] Finalize baseline economic parameters (Rp 10M starting cash, 5% interest rate, Rp 2M gajian).

### Phase 2: Project Foundation & Service Skeleton
- [x] Create modular folder structure under `WargaParty/src/Server`, `src/Client`, `src/Shared`.
- [x] Create `default.project.json` for full Rojo compatibility.
- [x] Deploy services and controllers directly into live Roblox Studio DataModel via MCP bridge.
- [x] Implement session-locked `PlayerDataService` with DataStore retry wrapper.

### Phase 3: Core Gameplay Loop (Board, Dice, Turns, Movement)
- [x] Implement `BoardService` with 3D graph path node definition (Jakarta circuit).
- [x] Build 3D visual board tiles in Workspace with SurfaceGuis and distinct color coding.
- [x] Implement server-authoritative `DiceService` with secure randomness.
- [x] Implement `TurnService` with 25-second turn timers and round cycling.
- [x] Implement `MovementService` and client-side smooth path tweening.
- [x] Implement interactive branch selector at road forks (*Sudirman* vs *Gang Senggol*).
- [x] Implement FINISH node arrival and podium evaluator.

### Phase 4: Economy, Properties, Loans & Dice Speculation
- [x] Implement `EconomyService` with transactional mutations and currency safety.
- [x] Implement `PropertyService` (property purchase, tier 1–3 upgrades, rent collection).
- [x] Implement `BankService` (loan requests, debt tags, per-turn interest accumulation, repayments).
- [x] Implement `InvestmentService` (betting on dice faces for 3 rounds, dividend payout).
- [x] Build in-game Economy HUDs in `UIController`.

### Phase 5: Random Event Framework & Policies
- [x] Implement `EventService` and data-driven `EventConfig.luau`.
- [x] Implement Indonesian event catalog (*Tukang Parkir Gaib*, *Emak Sein Kiri*, *Bansos Nyasar*, etc.).
- [x] Implement Government Policy system with active citywide buff/debuff indicators (*Pemutihan Pajak*, *Inflasi Cabai*).

### Phase 6: Multiplayer, Lobby & Disconnect Resiliency
- [x] Implement `DisconnectService`: detect dropped players, maintain 7-minute grace timer.
- [x] Implement `AIPlayerService`: autonomous bot taking sensible turns for disconnected players.
- [x] Implement reconnection logic: restore player control without desync.
- [x] Verified full server/client bootstrap via Roblox Studio Play Mode test.

### Phase 7: Visual Polish, Expanded 3D Landmarks & Train Intro (Upcoming)
- [ ] Expand 3D Jakarta landmarks (Monas spire, detailed food stalls, overpasses).
- [ ] 4-phase Train Journey cinematic opening sequence.
- [ ] Custom character rolling and celebration animations.

### Phase 8: Meta-Progression & Cosmetic Economy (Upcoming)
- [ ] Cosmetic Shop UI (Dice skins, Auras, Player Titles).
- [ ] Daily Login streaks and Daily Quest rewards.
- [ ] Server-verified Redeem Code system.

### Phase 9: Quality Assurance & Economic Balancing (Upcoming)
- [ ] Multiplayer stress testing with 4–12 simulated players.
- [ ] Mobile touch input refinement.
- [ ] RemoteEvent exploit penetration testing.

### Phase 10: Release Readiness & Publishing (Upcoming)
- [ ] Universe deployment and public publishing.
