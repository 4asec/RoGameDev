# DEVELOPMENT ROADMAP
# Project Phased Execution Plan (Phase 0 to Phase 10)

**Document Version:** 1.0.0  
**Current Phase:** PHASE 0 (Environment Inspection & Design Formulation)  
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

### Phase 0: Environment Inspection & Studio Bridge (CURRENT)
- [x] Inspect local tooling (Git, PATH, gh, rojo).
- [x] Verify Roblox Studio MCP connectivity and active place status.
- [x] Assess synchronization workflows (Roblox Studio MCP multi-edit vs Rojo).
- [x] Formulate initial directory layout and `.gitignore`.
- [x] Prepare comprehensive Game Design & Technical documentation suite.
- [x] Log pending decisions in `OPEN_DECISIONS.md`.
- [ ] Receive User Approval to proceed into Phase 1 & 2.

### Phase 1: Game Design & Core Architecture Approval
- [ ] Review GDD, TDD, EDD, and naming choices with User.
- [ ] Finalize working project folder name (`D:\RoGameDev\[GAME_NAME]\`).
- [ ] Confirm baseline economic parameters and scoring weights.

### Phase 2: Project Foundation & Service Skeleton
- [ ] Create folder structure under `src/Server`, `src/Client`, `src/Shared`.
- [ ] Implement central Service loader (`Init.server.luau`) and Controller loader (`Init.client.luau`).
- [ ] Deploy initial folder structure and RemoteEvents to Roblox Studio DataModel.
- [ ] Implement mock PlayerDataService with session-locking pattern.

### Phase 3: Core Gameplay Loop (Board, Dice, Turns, Movement)
- [ ] Implement `BoardService` with 3D graph path node definition.
- [ ] Build initial prototype map (Jakarta Monas route) with branching nodes.
- [ ] Implement server-authoritative `DiceService` (secure random generation).
- [ ] Implement `TurnService` with 25s turn timer and round cycling.
- [ ] Implement `MovementService` and client-side smooth path interpolation.
- [ ] Implement interactive branch selector at road forks.
- [ ] Implement FINISH node arrival and waiting state.

### Phase 4: Economy, Properties, Loans & Dice Speculation
- [ ] Implement `EconomyService` with transactional mutations and currency safety.
- [ ] Implement `PropertyService` (property purchase, tier 1-3 upgrades, rent deduction).
- [ ] Implement `BankService` (loan requests, debt tags, per-turn interest accumulation, repayments).
- [ ] Implement `InvestmentService` (betting on dice faces for 3 rounds, dividend payout).
- [ ] Build in-game Economy HUDs (Bank modal, Investment modal, Property purchase prompt).

### Phase 5: Random Event Framework & Policies
- [ ] Implement `EventService` and data-driven `EventConfig.luau`.
- [ ] Implement comedic event pop-up cards on client.
- [ ] Build Indonesian event catalogs (Tukang Parkir Gaib, Emak Sein Kiri, Bansos, etc.).
- [ ] Implement Government Policy system with active citywide buff/debuff indicators.

### Phase 6: Multiplayer, Lobby & Disconnect Resiliency
- [ ] Implement Lobby and room matchmaking architecture.
- [ ] Implement `DisconnectService`: detect dropped players, start 7-minute grace timer.
- [ ] Implement `AIPlayerService`: autonomous bot taking sensible turns for disconnected players.
- [ ] Implement seamless reconnection: restore player control without desync.

### Phase 7: Visuals, 3D Environments & Train Cinematic Intro
- [ ] Design and assemble 3D Jakarta landmarks (Monas, street stalls, flyovers).
- [ ] Implement 4-phase Train Journey opening sequence:
  - Phase 1: Cabin travel & window scenery.
  - Phase 2: Station arrival & chime.
  - Phase 3: Grand exit onto platform.
  - Phase 4: Board reveal sweep transition.
- [ ] Implement contextual `CameraController` (Isometric, follow, dice focus).

### Phase 8: Meta-Progression & Cosmetic Economy
- [ ] Implement persistent player profile schema (Coins, Gold, Wins, Matches Played).
- [ ] Implement Cosmetic Inventory (Dice skins, Auras, Player Titles).
- [ ] Implement Daily Login streaks, Daily Quest system, and Daily Spin Wheel.
- [ ] Implement Server-verified Code Redemption system.

### Phase 9: Quality Assurance & Economic Balancing
- [ ] Run automated & multiplayer test suite (2 to 12 players).
- [ ] Test edge cases: simultaneous disconnects, debt overflow, zero-cash states, branch spamming.
- [ ] Performance profiling: ensure 60 FPS on mobile and low-end devices.
- [ ] Exploit penetration testing on all RemoteEvents.

### Phase 10: Release Readiness & Publishing
- [ ] Finalize release documentation and changelogs.
- [ ] Verify Roblox compliance & monetization safety.
- [ ] Prepare game thumbnail, icon, and promotional assets.
- [ ] Deploy production build to Roblox Universe.
