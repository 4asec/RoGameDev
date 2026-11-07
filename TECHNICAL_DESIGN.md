# TECHNICAL DESIGN DOCUMENT (TDD)
# System Architecture & Engineering Specifications

**Document Version:** 1.0.0  
**Language:** Luau (Roblox Studio)  
**Architecture Paradigm:** Service-Controller Modular Pattern  
**Authority Model:** 100% Server-Authoritative  

---

## 1. System Directory Structure

The codebase is organized into clean server, client, and shared boundaries:

```
D:\RoGameDev\
├── .gitignore
├── README.md
├── GDD.md
├── TECHNICAL_DESIGN.md
├── UI_UX_GUIDELINES.md
├── ECONOMY_DESIGN.md
├── EVENT_DESIGN.md
├── DEVELOPMENT_ROADMAP.md
├── TESTING_PLAN.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── OPEN_DECISIONS.md
└── src/
    ├── Server/
    │   ├── Init.server.luau
    │   └── Services/
    │       ├── MatchService.luau
    │       ├── LobbyService.luau
    │       ├── TurnService.luau
    │       ├── BoardService.luau
    │       ├── MovementService.luau
    │       ├── DiceService.luau
    │       ├── EconomyService.luau
    │       ├── PropertyService.luau
    │       ├── InvestmentService.luau
    │       ├── BankService.luau
    │       ├── EventService.luau
    │       ├── NPCService.luau
    │       ├── PlayerDataService.luau
    │       ├── RewardService.luau
    │       ├── QuestService.luau
    │       ├── InventoryService.luau
    │       ├── MonetizationService.luau
    │       ├── DisconnectService.luau
    │       └── AIPlayerService.luau
    ├── Client/
    │   ├── Init.client.luau
    │   └── Controllers/
    │       ├── CameraController.luau
    │       ├── UIController.luau
    │       ├── AnimationController.luau
    │       ├── AudioController.luau
    │       └── BoardVisualController.luau
    └── Shared/
        ├── Config/
        │   ├── GameConfig.luau
        │   ├── EconomyConfig.luau
        │   ├── EventConfig.luau
        │   ├── PropertyConfig.luau
        │   └── AudioConfig.luau
        ├── Network/
        │   └── RemoteDefinitions.luau
        ├── Types/
        │   ├── MatchTypes.luau
        │   ├── BoardTypes.luau
        │   └── PlayerTypes.luau
        └── Utils/
            ├── NetworkUtil.luau
            ├── MathUtil.luau
            ├── TableUtil.luau
            └── Promise.luau
```

---

## 2. Server Services Specification

### 2.1 Core Match & Lifecycle Services
- **`MatchService`**: Coordinates match state machine (`Lobby`, `IntroCinematic`, `InGameTurns`, `PostMatchPodium`). Manages room allocations, player slot indexing, and score tallies.
- **`TurnService`**: Enforces strict sequential turns. Manages turn timer countdown (25s), turn timeouts, skip conditions, and transitions between active players.
- **`DisconnectService`**: Listens to `Players.PlayerRemoving`. Marks players as disconnected, snapshots their state, triggers AI takeover via `AIPlayerService`, and manages the 7-minute reconnection timer.
- **`AIPlayerService`**: Autonomous controller that executes turns on behalf of disconnected or filler players with conservative decision matrices.

### 2.2 Board & Navigation Services
- **`BoardService`**: Loads and stores graph-based node maps. Each tile node has:
  ```lua
  type BoardNode = {
      Id: string,
      Type: "Property" | "Bank" | "Event" | "Toll" | "Start" | "Finish" | "Branch",
      Position: Vector3,
      NextNodes: { string }, -- Array of Node IDs (length > 1 indicates a branch)
      Data: { [string]: any }
  }
  ```
- **`MovementService`**: Computes valid traversal paths given a starting node, dice value, and selected branch choices. Validates character CFrames on the server to prevent teleport exploits.
- **`DiceService`**: Cryptographically secure server-side random dice generation (`Random.new()` with seed). Returns roll values (1–6) and broadcasts roll sequences to all clients.

### 2.3 Economy & Finance Services
- **`EconomyService`**: Manages match player balances. Provides transactional mutations (`Deposit`, `Withdraw`, `Transfer`) with atomic checks to prevent negative balance errors and race conditions.
- **`PropertyService`**: Manages ownership registry, upgrade levels (1–3), rent collection logic, and mortgage states.
- **`InvestmentService`**: Tracks active dice number predictions per player, countdown rounds (max 3 rounds), and dividend distribution whenever rolls occur.
- **`BankService`**: Handles loan originations, interest accumulation cycles per turn, debt limits (max 3 concurrent), and repayment transactions.

### 2.4 Meta & Progression Services
- **`PlayerDataService`**: Session-locked DataStore wrapper with automatic retry, exponential backoff, and migration schemas for persistent profiles (Coins, Gold, Cosmetics, Stats).
- **`QuestService` & `RewardService`**: Validates quest conditions, daily login streaks, daily wheel spins, and code redemptions.

---

## 3. Client Controllers Specification

- **`CameraController`**: Contextual state-driven camera system using TweenService and spring interpolation:
  - Modes: `IsometricBoard`, `FocusDice`, `FollowAvatar`, `CinematicTrain`, `PodiumView`.
- **`UIController`**: Manages responsive screen GUIs, animated modals, turn HUD, dice roll buttons, and Indonesian comedic popups.
- **`BoardVisualController`**: Renders dynamic board highlights, path arrows at intersections, tile ownership flags, and footprint trajectories.
- **`AnimationController`**: Handles avatar emotes, custom rolling stances, train seated idle animations, and celebratory finish dances.

---

## 4. Network Contract & Security

### 4.1 Remotes Architecture
All Remotes are strictly declared in `Shared/Network/RemoteDefinitions.luau`. Remote creation is centralized on the server during initialization.

| Remote Name | Type | Direction | Payload | Description |
| :--- | :--- | :--- | :--- | :--- |
| `RequestRollDice` | RemoteEvent | Client -> Server | None | Requests server to roll dice for active player |
| `DiceRolled` | RemoteEvent | Server -> Client | `(playerId: number, value: number)` | Broadcasts authoritative dice result |
| `RequestSelectBranch` | RemoteEvent | Client -> Server | `(branchIndex: number)` | Selects route when stopped at an intersection |
| `PlayerMoved` | RemoteEvent | Server -> Client | `(playerId: number, pathNodes: {string})` | Coordinates client-side smooth movement |
| `RequestBuyProperty` | RemoteFunction | Client -> Server | `(nodeId: string)` | Requests property acquisition |
| `RequestBankLoan` | RemoteFunction | Client -> Server | `(amount: number)` | Requests bank loan with interest calculation |
| `RequestRepayLoan` | RemoteFunction | Client -> Server | `(loanId: string, amount: number)` | Repays all or part of an existing loan |
| `RequestDiceInvestment`| RemoteFunction | Client -> Server | `(diceNumber: number, amount: number)` | Bets on a dice number |
| `MatchStateChanged` | RemoteEvent | Server -> Client | `(state: string, data: table)` | Broadcasts match lifecycle updates |

### 4.2 Security Rules
1. **Never trust client arguments:** All requests to buy, transfer, roll, or claim are validated against the server-authoritative turn owner, current tile position, and player balance.
2. **Rate Limiting:** Remote events employ debounce timers per player connection to prevent packet spamming.
3. **Server-Side Movement Validation:** Characters do not simulate physics freely; positions are interpolated along registered board node paths, checked against server timestamps.
