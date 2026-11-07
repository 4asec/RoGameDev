# Open Decisions Log (OPEN_DECISIONS.md)

This document tracks all critical game design, economic, technical, and creative decisions that require explicit approval or input from the Game Director (User) before being finalized into code.

---

## 1. Project Naming & Branding

| Proposal | Title | Tone / Theme | Pros / Cons | Status |
| :--- | :--- | :--- | :--- | :--- |
| **Option A (Recommended)** | **Warga Party: Petualangan Cuan & Apes** | Absurd, humorous, culturally resonant | Directly communicates multiplayer party gameplay + everyday Indonesian ups and downs. | **Pending User Review** |
| **Option B** | **Kerasnya Kota: Board Game Indonesia** | Urban hustle, satirical | Strong urban survival theme, slightly more mature tone. | Pending User Review |
| **Option C** | **Cuan & Chaos: Indonesian Life Party** | Bilingual, modern, snappy | Highly marketable to both local and international Roblox players. | Pending User Review |
| **Option D** | **Nasib Warga: Jalan Pintas Ibukota** | Relatable, satirical board game | Emphasizes board paths, shortcuts, and twists of fate. | Pending User Review |

*Decision Required:* Select or supply the official game name to establish project folder `D:\RoGameDev\[GAME_NAME]\` and Studio branding.

---

## 2. Economy & Financial Formulas

### OD-ECO-001: Starting Cash & Cash Flow
- **Proposed Baseline:** Each player begins match with `Rp 10,000,000` (virtual in-match currency).
- **Scale:** All prices and fines are scaled in intuitive Indonesian Rupiah increments (e.g., Rp 50,000 for parking, Rp 2,000,000 for small shop property).
- **Status:** *Pending validation during Phase 4 prototyping.*

### OD-ECO-002: Dice Investment Formula
- **Concept:** Players bet on a specific dice number (1 to 6) for up to 3 rounds.
- **Proposed Parameters:**
  - Investment Tier 1: Rp 500,000 -> Payout: Rp 1,500,000 per roll (3x multiplier).
  - Investment Tier 2: Rp 1,000,000 -> Payout: Rp 3,000,000 per roll (3x multiplier).
  - Max simultaneous active dice investments per player: 2.
  - Payment source: Bank pays the dividend (does not drain the rolling player unless an "investor extortion" event is active).
- **Status:** *Pending simulation and balance testing.*

### OD-ECO-003: Bank Loan & Debt Limits
- **Proposed Limits:** Maximum 3 concurrent loans per player.
- **Interest Rate:** 5% per player round.
- **Unpaid Debt Penalty:** Players never instantly go bankrupt; instead, remaining debt at FINISH is penalized with a 1.5x score deduction multiplier.
- **Collateral / Property Ties:** If loan is taken for a property acquisition, mortgaging reduces property rent collection by 50% until repaid.
- **Status:** *Pending User Review.*

---

## 3. FINISH Scoring System

### OD-FIN-001: Scoring Weights
When all players cross the FINISH line (or match timer expires), match ranking is calculated via Cumulative Score:
$$\text{Score} = \text{Cash} + (\text{Property Value} \times 1.2) + \text{Investment Gains} - (\text{Outstanding Debt} \times 1.5) + \text{Finish Order Bonus}$$

Proposed Finish Order Bonuses:
- 1st to Finish: +Rp 5,000,000 score bonus
- 2nd to Finish: +Rp 3,000,000 score bonus
- 3rd to Finish: +Rp 1,000,000 score bonus
- Others: 0 bonus (encourages completing the journey without neglecting board acquisitions).

- **Status:** *Pending User Review.*

### OD-FIN-002: Last Place Humor Feature
- Lowest-ranked player receives the humorous "Monkey-Smile" result title & comedic badge screen ("Sabar Ya Warga").
- **Status:** *Approved in master prompt concept.*

---

## 4. Map & Board Architecture

### OD-MAP-001: First Playable Map
- **Recommendation:** Start with **Jakarta (Monas & Pusat Bisnis)** as the initial milestone map to prototype landmarks, road branches, traffic jam events, and property tiles.
- Subsequent cities (Yogyakarta, Surabaya, Bali) to be built modularly in Phase 7.
- **Status:** *Pending User Review.*

### OD-MAP-002: Turn Timer & AFK Enforcement
- Standard turn timer: 25 seconds per turn.
- If player does not roll/choose route within 25 seconds:
  - System automatically rolls dice and chooses the default forward path.
  - If inactive for 2 consecutive turns, Disconnect/AI system temporarily assumes control.
- **Status:** *Pending User Review.*

---

## 5. Technology & Synchronization

### OD-TECH-001: Script Synchronization Workflow
- **Current State:** Rojo is not installed in the system PATH. Roblox Studio MCP is fully operational and provides direct script injection (`multi_edit`), runtime execution (`execute_luau`), and hierarchy search (`search_game_tree`).
- **Proposed Workflow:** 
  - Author and maintain all source files in `D:\RoGameDev\[GAME_NAME]\src\`.
  - Use an automated deployment sync script / MCP toolchain to push changes directly into Roblox Studio DataModel.
  - Structure folders so that if the user decides to install Rojo later, no code restructuring is required.
- **Status:** *Proposed for Phase 0 approval.*
