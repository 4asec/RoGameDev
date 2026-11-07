# ECONOMY DESIGN DOCUMENT (EDD)
# Financial Models, Formulas & Balancing Specifications

**Document Version:** 1.0.0  
**Economic Model:** Dynamic Risk-Reward & Social Cash Flow  
**Target Match Length:** 20–30 Minutes  

---

## 1. Dual Currency Model

### 1.1 In-Match Economy (Session-Only)
- **Match Rupiah (Rp):** Used solely inside an active match for properties, tolls, investments, and loans.
- **Starting Capital:** `Rp 10,000,000` per player at match start.
- **Salary / Lap Bonus:** When passing or landing on designated checkpoint tiles, players receive `Rp 2,000,000` ("Gajian Bulanan").

### 1.2 Meta Progression Currency (Persistent)
- **Coins:** Earned from match performance (1st: 500 Coins, 2nd: 300 Coins, 3rd: 150 Coins, Participation: 75 Coins). Used for shop cosmetics, titles, and standard avatar effects.
- **Gold:** Premium/Special progression currency granted via level milestones, achievements, or event battles. Used for exclusive dice skins and auras.

---

## 2. Property & Business Architecture

### 2.1 Property Tiers
Each property node on the city map belongs to one of three districts:

| District Tier | Example Businesses | Purchase Price | Base Rent | Upgrade Cost (Tier 2 / 3) |
| :--- | :--- | :--- | :--- | :--- |
| **Tier 1 (Pinggiran)** | Warung Kopi, Tambal Ban, Gerobak Cilok | Rp 1,500,000 | Rp 300,000 | Rp 1,000,000 / Rp 2,000,000 |
| **Tier 2 (Perumahan)** | Minimarket Lokal, Laundry Kiloan, Barber | Rp 3,500,000 | Rp 800,000 | Rp 2,500,000 / Rp 5,000,000 |
| **Tier 3 (Pusat Kota)** | Mall Megah, Showroom Motor, Restoran Sultan | Rp 7,500,000 | Rp 2,000,000 | Rp 5,000,000 / Rp 10,000,000 |

### 2.2 Rent Formula
$$\text{Rent} = \text{BaseRent} \times (1 + (\text{UpgradeLevel} - 1) \times 0.75) \times \text{PolicyMultiplier}$$

Where:
- `UpgradeLevel` $\in \{1, 2, 3\}$.
- `PolicyMultiplier` defaults to `1.0`, altered by active Government Policies (e.g. `1.5` during "Festival Belanja", `0.5` during "Pajak Usaha Tinggi").

---

## 3. Dice Investment Market

### 3.1 Mechanics
A player can allocate capital toward a specific dice face (Numbers 1 through 6).
- **Cost per Ticket:** Configurable tiers (`Rp 500,000` or `Rp 1,000,000`).
- **Maximum Active Investments:** 2 concurrent investments per player.
- **Duration:** 3 rounds (decrements each time the investing player's turn concludes).
- **Trigger:** Whenever ANY player in the match rolls that number, the investor receives a dividend.

### 3.2 Mathematical Expectation
In a 4-player game, over 3 rounds, there will be approximately 12 dice rolls total.
Probability of rolling a specific face per roll is $P = \frac{1}{6} \approx 16.67\%$.
Expected occurrences across 12 rolls:
$$E[X] = 12 \times \frac{1}{6} = 2 \text{ hits}$$

- At `Rp 500,000` ticket cost and `Rp 1,500,000` dividend per hit:
  - 0 hits: $-\text{Rp 500,000}$ (Net Loss)
  - 1 hit: $+\text{Rp 1,000,000}$ (Net Profit)
  - 2 hits: $+\text{Rp 2,500,000}$ (High Profit)
  - 3+ hits: Massive jackpot returns!
This guarantees an exciting speculative gambling mechanic without breaking early-game liquidity.

---

## 4. Bank Loan & Debt System

### 4.1 Loan Borrowing Rules
- Available when landing on Bank Nodes or via Emergency Loan Prompt when facing a debt shortfall.
- Loan denominations: Increments of `Rp 1,000,000` up to a maximum total debt cap of `Rp 10,000,000`.
- Each loan is tagged with an ID and timestamp:
  ```lua
  type LoanRecord = {
      Id: string,
      Principal: number,
      AccumulatedInterest: number,
      InterestRate: number, -- Default 0.05 (5% per turn)
      CreatedAtRound: number
  }
  ```

### 4.2 Interest Accrual
At the start of each borrowing player's turn:
$$\text{InterestToAdd} = \text{Principal} \times \text{InterestRate}$$
$$\text{AccumulatedInterest} \mathrel{+}= \text{InterestToAdd}$$

### 4.3 Repayment
- Players can repay any partial or full balance during their turn via the Bank HUD.
- Payments reduce `AccumulatedInterest` first, then reduce `Principal`.

### 4.4 Non-Bankruptcy Guarantee
Unlike traditional Monopoly where players are abruptly eliminated upon running out of cash, this game **never prematurely eliminates players**:
- If cash drops below zero, player balance is capped at `0`, and the unpaid sum is automatically appended as a high-interest **Emergency Bank Loan**.
- This keeps all players engaged and laughing until the final podium ceremony!

---

## 5. End-Game Scoring Formula

Cumulative match standing is evaluated once all players have completed their journey:

$$\text{FinalScore} = \text{Cash} + (\text{PropertyEquity} \times 1.2) + \text{InvestmentNetProfit} - (\text{TotalOutstandingDebt} \times 1.5) + \text{FinishBonus}$$

Where:
- Finish Order Bonuses:
  - 1st Place Arrival: `+Rp 5,000,000`
  - 2nd Place Arrival: `+Rp 3,000,000`
  - 3rd Place Arrival: `+Rp 1,000,000`
  - 4th+ Arrival: `Rp 0`
- The `1.5x` penalty on remaining unpaid debt ensures that players cannot exploit excessive loans without suffering major point penalties.
