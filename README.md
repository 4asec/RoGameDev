# RoGameDev — Indonesian Life Party Board Game

[![Platform](https://img.shields.io/badge/Platform-Roblox-00A2FF?logo=roblox&logoColor=white)](https://www.roblox.com)
[![Language](https://img.shields.io/badge/Language-Luau-00A2FF?logo=lua&logoColor=white)](https://luau.org)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#)
[![Status](https://img.shields.io/badge/Development-Phase%200%20(Setup)-yellow)](#)
[![Architecture](https://img.shields.io/badge/Authority-100%25%20Server--Authoritative-brightgreen)](#)

> A chaotic, hilarious, and highly replayable multiplayer 3D board game set across recognizable Indonesian cities. Buy local businesses, speculate on dice rolls, borrow from shady banks, dodge absurd traffic tickets, and race to the finish line with your friends!

---

## 🎮 Game Overview

- **Genre:** Multiplayer 3D Party Board Game / Life Simulation / Social Economy
- **Players:** 2–6 Players (Standard Matchmaking) | 2–12 Players (Custom Rooms)
- **Match Duration:** 20–30 Minutes
- **Key References (Design Inspiration only):** *The Game of Life*, *Monopoly*, *Roblox Party*, *Mario Party*

### Key Features
- 🏙️ **3D Open City Board System:** Move through dynamic, branching Indonesian city roads (Jakarta, Yogyakarta, Surabaya, Bali) that converge at a central terminal.
- 🎲 **Speculative Dice Investments:** Invest in specific dice rolls for up to 3 rounds and collect payouts whenever any player rolls your number!
- 🏦 **Strategic Bank & Debt System:** Take out loans with accumulating interest, repay at will, and navigate non-punitive bankruptcy.
- 🛵 **Indonesian Absurd Situations:** Face hilarious everyday events (Tukang Parkir Gaib, Emak Sein Kiri, Bansos Nyasar, Ganjil Genap).
- 🚆 **Cinematic Train Journey:** Dynamic match opening featuring a moving 3D train ride with player avatars before stepping onto the city platform.
- 🔄 **Robust Disconnect & Reconnect:** 7-minute grace period with automatic AI substitution to keep the match moving smoothly.

---

## 🏗️ Technical Architecture

```
[ Roblox Clients (Mobile, PC, Console) ]
                  ▲
                  │  RemoteEvents & RemoteFunctions (Rate Limited)
                  ▼
[ Server Services (ServerScriptService) ]
  ├── MatchService       (Match State & Lifecycle)
  ├── TurnService        (Sequential Turn Timers & Cycling)
  ├── BoardService       (Graph Pathfinding & Node Registry)
  ├── MovementService    (Server-Validated Movement)
  ├── DiceService        (Cryptographically Secure Rolls)
  ├── EconomyService     (Transactional Balances & Checks)
  ├── PropertyService    (Asset Registry, Rent & Upgrades)
  ├── InvestmentService  (Dice Speculation & Dividends)
  ├── BankService        (Loans, Interest & Repayments)
  ├── EventService       (Data-Driven Event Dispatches)
  ├── DisconnectService  (Connection Monitoring & Grace Timers)
  └── AIPlayerService    (Heuristic Bot Replacements)
```

---

## 📁 Repository Structure

```
D:\RoGameDev\
├── .gitignore               # Git exclusions
├── README.md                # Project landing documentation
├── GDD.md                   # Game Design Document
├── TECHNICAL_DESIGN.md      # Luau service & network architecture
├── UI_UX_GUIDELINES.md      # Design system, tokens & layouts
├── ECONOMY_DESIGN.md        # Mathematical models & formulas
├── EVENT_DESIGN.md          # Event schemas & Indonesian catalogs
├── DEVELOPMENT_ROADMAP.md   # 10-Phase milestone plan
├── TESTING_PLAN.md          # Test cases, edge cases & matrices
├── CHANGELOG.md             # Semantic versioned changes
├── CONTRIBUTING.md          # Team contribution rules
├── OPEN_DECISIONS.md        # Decision tracker awaiting review
└── src/                     # Luau source code (Server, Client, Shared)
```

---

## 🚀 Development Workflow

This project is developed using **Google Antigravity IDE** coupled directly with **Roblox Studio** via the **Roblox Studio MCP bridge**.

1. **Source Code:** Kept locally inside `D:\RoGameDev\src\` under strict version control.
2. **Roblox Studio Synchronization:** Deployed and updated directly to the live DataModel using Roblox Studio MCP tools (`multi_edit` and `execute_luau`).
3. **Version Control:** Incremental Git commits following strict review protocols.

---

## 📋 Open Decisions & Action Items

See [`OPEN_DECISIONS.md`](OPEN_DECISIONS.md) for game title proposals and economic parameter confirmations currently awaiting user review.
