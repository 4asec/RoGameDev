# TESTING & QUALITY ASSURANCE PLAN
# Verification Standards, Edge Cases & Test Matrices

**Document Version:** 1.0.0  
**Testing Principle:** No feature is complete until verified in a simulated multiplayer environment.

---

## 1. Test Suite Categories

```
┌────────────────────────────────────────────────────────────────────────┐
│                        QUALITY ASSURANCE SUITE                         │
├───────────────────┬───────────────────┬────────────────────────────────┤
│ 1. Core Mechanics │ 2. Economy Stress │ 3. Network & Edge Cases        │
│ • Turn cycling    │ • Negative cash   │ • Mid-turn disconnect          │
│ • Path branching  │ • Loan interest   │ • Reconnect before 7-min grace │
│ • Dice randomness │ • Race conditions │ • Multiple simultaneous drops  │
│ • Finish arrival  │ • Score formulas  │ • RemoteEvent spoofing/spam    │
└───────────────────┴───────────────────┴────────────────────────────────┘
```

---

## 2. Multiplayer Test Matrices

### 2.1 Player Scale Scenarios
| Scenario ID | Player Count | Target Duration | Success Criteria |
| :--- | :--- | :--- | :--- |
| `TC-MP-001` | 2 Players (1v1) | 15–20 minutes | Fast turns, continuous head-to-head interaction, clean FINISH transition. |
| `TC-MP-002` | 4 Players (Standard) | 20–25 minutes | Balanced board congestion, active property trading/rent, stable 60 FPS. |
| `TC-MP-003` | 6 Players (Full Public) | 25–30 minutes | Proper turn order queue, no UI overlap, smooth camera transitions. |
| `TC-MP-004` | 12 Players (Max Custom) | 35–45 minutes | Server memory under 400MB, no dropped RPC packets, scoreboard pagination. |

---

## 3. Disconnect & AI Reconnection Tests

### 3.1 Test Case: Mid-Turn Disconnection (`TC-DISC-001`)
- **Step 1:** Player 2 starts their turn with 25s on clock.
- **Step 2:** Simulate network drop (`PlayerRemoving`).
- **Expected Result:**
  - Red `LOST CONNECTION` tag mounts on character and scoreboard.
  - Turn timer completes or pauses gracefully.
  - `AIPlayerService` rolls dice and picks safest forward branch.
  - Player 2's session data and assets remain strictly intact.

### 3.2 Test Case: Reconnection within Grace Period (`TC-DISC-002`)
- **Step 1:** Disconnected player rejoins within 7 minutes.
- **Expected Result:**
  - Server recognizes player UserID.
  - AI relinquishes control instantly.
  - UI rebinds to current board state, camera aligns to player character, no money or property loss.

### 3.3 Test Case: Grace Period Expiration (`TC-DISC-003`)
- **Step 1:** Disconnected player does not return within 7 minutes.
- **Expected Result:**
  - Player status transitions to `OUT`.
  - Future turns are skipped.
  - Owned properties are placed in bank receivership or made purchasable.
  - Historic score is preserved for final podium ranking.

---

## 4. Economic Security & Exploit Testing

### 4.1 Exploit Tests
- **E-01 (Negative Money Exploit):** Client fires `RequestBuyProperty` when balance is less than purchase price.  
  *Expected:* Server rejects with `INSUFFICIENT_FUNDS` error log; zero state change.
- **E-02 (Dice Manipulation):** Client attempts to send predetermined roll value via RemoteEvent.  
  *Expected:* Server ignores client parameter, generates roll via secure `Random.new()`.
- **E-03 (Double Purchase Race Condition):** Two players landing on same tile simultaneously attempt to buy.  
  *Expected:* Transactional lock guarantees only the first verified request succeeds; second request receives `ALREADY_OWNED`.
- **E-04 (Infinite Loan Glitch):** Player requests more than 3 simultaneous loans or exceeds Rp 10M debt cap.  
  *Expected:* Server enforces hard debt ceiling and denies further borrowing.

---

## 5. Performance & Mobile Compliance

- **Memory Target:** Maximum client memory usage $\le 350 \text{ MB}$.
- **Frame Rate Target:** Stable 60 FPS on mid-range mobile devices (e.g., iPhone 11 / Samsung A52 equivalent).
- **Network Bandwidth:** Peak network send/receive rate $\le 50 \text{ KB/s}$ during standard turn play.
- **UI Scaling:** Validated across 16:9, 18:9, 21:9 aspect ratios and small phone viewports.
