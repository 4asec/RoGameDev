# GAME DESIGN DOCUMENT (GDD)
# Indonesian Life Party Game (Working Project: RoGameDev)

**Document Version:** 1.0.0  
**Target Platform:** Roblox (Desktop, Mobile, Tablet, Console)  
**Target Audience:** All Ages / Teens (Emphasis on social humor & replayability)  
**Engine:** Roblox Luau (Server-Authoritative)  

---

## 1. Executive Summary & Vision

### 1.1 High Concept
An absurd, fast-paced, highly replayable multiplayer 3D board game that satirizes everyday life, financial struggles, and chaotic urban adventures in Indonesian cities. Players navigate branching city roads, buy local properties, invest in dice outcomes, borrow money from shady banks, dodge absurd traffic tickets and government policies, and race towards the FINISH line.

### 1.2 Core Pillars
1. **Situational & Absurd Comedy:** Captures relatable Indonesian experiences (e.g. "Tukang Parkir Gaib", "Razia Emak-emak", "Bansos Nyasar", "Macet Total").
2. **Dynamic 3D Open City Board:** Unlike traditional flat square boards, players explore navigable 3D urban landscapes featuring branching pathways that converge at a shared destination.
3. **Strategic Risk & Debt Management:** Real economic choices involving property acquisitions, bank loans, and dice speculation with high risk and hilarious penalties.
4. **Social & Inclusive Party Experience:** Turn-based mechanics suitable for casual gamers and streamers alike, featuring animated reactions, emotes, and comedic rewards for all rankings.

---

## 2. Match Structure & Game Modes

### 2.1 Match Types
- **Standard Public Matchmaking:** 2 to 6 players per match server.
- **Custom Private Room:** 2 to 12 players maximum (configurable by room host).
- **Match Duration:** 20–30 minutes target pacing.

### 2.2 Match Progression Lifecycle
```
[ Lobby & Matchmaking ]
         │
         ▼
[ Cinematic Opening: Train Journey to City ]
         │
         ▼
[ Board Overview & Turn Order Announcement ]
         │
         ▼
[ Turn Loop: Roll -> Branch Selection -> Move -> Resolve Tile/Event ]
         │
         ▼
[ Players Reach FINISH (Wait State) ]
         │
         ▼
[ All Players Arrived or Terminal State ]
         │
         ▼
[ Final Score Calculation & Podium Ceremony (Monkey Smile Award for Last Place) ]
         │
         ▼
[ Return to Lobby / Rewards Distributed ]
```

---

## 3. Map & Board Architecture

### 3.1 The Open City Board System
The board is not a flat loop. It is a stylistically scaled 3D city environment built from modular path nodes (Tile Nodes).
- **Path Branching:** Roads split into alternate routes (e.g., Short cut through a congested alleyway vs. Safe main road with expensive tolls).
- **Convergence:** All distinct branches eventually merge toward the city's terminal hub (FINISH).
- **Node Density:** 45 to 70 nodes per city map to maintain match duration within 25 minutes.

### 3.2 Featured Cities

#### 1. Jakarta (Metropolitan Hub)
- **Visuals:** Monas, modern skyscrapers, flyovers, TransJakarta bus stops, street food stalls (Warung Kaki Lima).
- **Route Flavors:** Sudirman Main Boulevard (high property value) vs. Gang Senggol (narrow shortcut with unexpected parking fees).
- **City Events:** Ganjil-Genap inspection, flooding shortcuts, viral street food hype.

#### 2. Yogyakarta (Cultural & Student Capital)
- **Visuals:** Malioboro street signs, angkringan carts, traditional keraton gates, vintage pedicabs (becak).
- **Route Flavors:** Jalan Malioboro pedestrian zone vs. Ring Road outer path.
- **City Events:** Angkringan discount, student budget bonus, spontaneous acoustic busking.

#### 3. Surabaya (The Heroic Industrial Metropolis)
- **Visuals:** Tugu Pahlawan, Suramadu bridge aesthetic, bustling harbors.
- **Route Flavors:** Industrial Port lane vs. Historic City Center.
- **City Events:** Hot weather stamina penalty, port cargo boom, wholesale bargain.

#### 4. Bali (Island & Tourism Paradise)
- **Visuals:** Candi bentar gates, palm trees, beachside cafes, art markets.
- **Route Flavors:** Sunset Beach road vs. Cultural Temple pass.
- **City Events:** High-season tourist influx, local ceremonies (road detour), art market bargaining.

---

## 4. Turn Mechanics & Movement System

### 4.1 Turn Sequence
1. **Turn Identification:** Active player is announced; camera focuses on player character with UI roll prompt.
2. **Dice Roll:** Player activates the roll button; 3D physics/visual dice roll animation executes.
3. **Movement Pathfinding:**
   - Character smoothly runs forward along board waypoints.
   - If a path branch/intersection is encountered, movement halts and interactive directional UI prompts the player to select their preferred path.
4. **Tile Landing & Resolution:**
   - Tile evaluates its type (Property, Bank, Event, Danger, Bonus, Toll).
   - Server validates tile logic and executes corresponding transactions or UI modals.
5. **Turn Transition:** End-of-turn actions resolve; camera resets; control passes to the next player.

### 4.2 FINISH Logic
- The first player to reach the FINISH tile does **not** terminate the match immediately.
- The finished player enters a protected spectator/celebration area.
- Other players continue taking turns until everyone crosses the finish line or a 5-turn countdown grace runs out.
- Cumulative ranking is calculated at the end of the entire match.

---

## 5. Economic & Financial Systems

### 5.1 Currency Types
1. **Match Rupiah (In-Match):** Session-only currency used for buying properties, paying tolls, taking loans, and investing during the match.
2. **Coins (Meta-Progression):** Earned from match placements, daily quests, and achievements. Used for cosmetic gacha, titles, and dice skins.
3. **Gold (Premium Progression):** High-tier reward currency for seasonal milestones and cosmetic bundles.

### 5.2 Property System
- Nodes can feature purchasable Indonesian businesses (e.g., *Warung Madura 24 Jam*, *Warkop Cuan*, *Bengkel Motor*, *Martabak Sultan*).
- When another player lands on an owned property, they pay rent to the owner.
- Owners can upgrade their properties up to Tier 3 to increase rental yield and final asset valuation.

### 5.3 Dice Investment Market
- Players can allocate capital into specific dice numbers (1 through 6) during their turn or at Investment tiles.
- Duration: Active for 3 full player cycles.
- When any player (including rivals) rolls that number, the investor receives a dividend.

### 5.4 Bank & Debt System
- Players can take out loans at Bank tiles or when cash-deficient.
- Each loan has an explicit principal, accumulated interest, and repayment terms.
- Partial and lump-sum repayments can be made at any point during the player's turn.
- Outstanding debt at the end of the match incurs severe penalties against final placement scoring.

---

## 6. Random Events & Government Policies

### 6.1 Event Rarities
- **Common (60%):** Everyday incidents (parking tickets, fuel price shift, finding small cash).
- **Uncommon (25%):** Business events (viral endorsement, power outage, street renovation).
- **Rare (12%):** Major city disruptions (heavy rainfall, sudden tax inspection, lucky lottery).
- **Legendary (3%):** Global citywide policies (hyperinflation, universal subsidy, presidential visit).

### 6.2 Fictional Indonesian Government Policies
Policies trigger periodically or via special Government Nodes:
- *Bansos Tunai:* All players below average wealth receive a relief payout.
- *Operasi Zebra Kilat:* Every player without insurance pays an on-the-spot fee.
- *Pemutihan Pajak:* All active bank loan interest is temporarily frozen for 2 rounds.

---

## 7. Cinematic & Presentation Systems

### 7.1 Train Journey Intro
1. **Phase 1 (The Ride):** Players sit inside an Indonesian executive train cabin as scenic countryside passes by outside the windows.
2. **Phase 2 (The Arrival):** Train brakes screech; dynamic station bell chime plays; doors glide open.
3. **Phase 3 (Grand Exit):** Avatars walk onto the station platform in turn order with custom intro stances.
4. **Phase 4 (City Reveal):** Cinematic aerial camera sweeps across the city board and transitions into isometric gameplay camera.

### 7.2 Camera Director
- **Isometric Top-Down:** Default gameplay overview with soft depth of field.
- **Cinematic Roll Focus:** Close-up on dice as it lands.
- **Travel Tracking:** Smooth third-person chase camera following avatar along sidewalks.
- **Event Presentation:** Picture-in-picture or full-screen dramatic comic modal with sound effects.

---

## 8. Multiplayer, Disconnects & Fairness

### 8.1 Reconnect & AI Takeover
- If a player disconnects, their character does not vanish.
- A red `LOST CONNECTION` tag appears above their avatar and on the scoreboard.
- An automated AI Player takes conservative turns on their behalf (avoiding reckless debt).
- The disconnected player has a **7-minute grace period** to rejoin and immediately resume their position and assets.
- If the grace period expires, the player is declared `OUT`.

### 8.2 Security & Authority
- **Zero Client Trust:** All rolls, movements, transactions, and purchases originate and validate on the Server.
- Client only sends requests (e.g. `RequestRollDice`, `RequestSelectBranch`); the server computes, verifies, and broadcasts states.
