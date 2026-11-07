# UI/UX DESIGN GUIDELINES
# Indonesian Life Party Game Visual Design System

**Document Version:** 1.0.0  
**Design Philosophy:** Modern Minimalism meets Playful Indonesian Cartoon Satire  
**Key Goal:** Clean, readable, responsive, and completely distinct from default generic Roblox interfaces.

---

## 1. Visual Identity & Design Tokens

### 1.1 Color Palette
- **Primary Accent (Cuan Gold):** `#FBBF24` (Amber 400) — Represents money, winning, and golden opportunities.
- **Secondary Accent (Semangat Red):** `#EF4444` (Red 500) — Represents debts, hazards, high-stake events.
- **Tertiary Accent (Santai Cyan):** `#06B6D4` (Cyan 500) — Represents investments, safe tiles, and transport routes.
- **Success Green:** `#10B981` (Emerald 500) — Positive earnings, completed repayments.
- **Dark Neutral (Batu Aspal):** `#1E293B` (Slate 800) — Main container backgrounds and modal frames.
- **Card Surface:** `#334155` (Slate 700) — Inner card backgrounds with subtle borders.
- **Light Text:** `#F8FAFC` (Slate 50) — High contrast text for primary readability.
- **Muted Text:** `#94A3B8` (Slate 400) — Subtitles, stats labels, and hint text.

### 1.2 Typography
- **Title & Headers:** `FredokaOne` or `LuckiestGuy` (Playful, bold, highly legible cartoon feel).
- **Body & Numeric Values:** `GothamBold` / `GothamMedium` (Modern geometric sans-serif for sharp financial readouts).

### 1.3 Shapes & Styling
- **Corner Radius:** Standardized `UICorner` of `12px` to `16px` for cards; `8px` for buttons.
- **Outlines / Strokes:** `UIStroke` with `2px` width, color `#475569` or vibrant accent highlight when active.
- **Gradients:** Subtle top-to-bottom gradients (`UIGradient`) giving tactile depth without visual clutter.

---

## 2. In-Game HUD Layout

```
┌────────────────────────────────────────────────────────────────────────┐
│  [ MATCH INFO / ROUND ]                      [ PLAYER STATUS LIST ]    │
│  "Putaran 4 / 20"                            ┌───────────────────────┐ │
│  "Kota: Jakarta (Sudirman)"                  │ 👑 Player1  Rp 14.5M  │ │
│                                              │ ⏳ Player2  Rp 8.2M   │ │
│                                              │ 🔴 Player3  Rp 4.0M   │ │
│                                              │    (LOST CONNECTION)  │ │
│                                              └───────────────────────┘ │
│                                                                        │
│                                                                        │
│                     [ 3D BOARD VIEWPORT ]                             │
│                                                                        │
│                                                                        │
│                                                                        │
│  [ ACTIVE EVENT BANNER ]                                               │
│  "⚠️ Razia Emak-emak: Semua pemain di jalur barat kena denda!"         │
│                                                                        │
│  ┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐  │
│  │ 🏦 BANK & HUTANG │    │   🎲 ROLL DICE   │    │ 📈 INVESTASI     │  │
│  │  "Rp 2,500,000"  │    │  [ PUTAR DADU ]  │    │  "Dadu 4: 2x"    │  │
│  └──────────────────┘    └──────────────────┘    └──────────────────┘  │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Contextual Animation & Micro-Interactions

### 3.1 Interaction Standards
- **Button Hover:** Scale `1.0` -> `1.05` over `0.15s` (`Enum.EasingStyle.Quad`, `Enum.EasingDirection.Out`).
- **Button Press:** Scale `1.05` -> `0.95` with subtle haptic/click sound.
- **Card Entrance:** Slide up with Spring physics (`Enum.EasingStyle.Back`, `Enum.EasingDirection.Out`).
- **Dice Result Reveal:** Dramatic 3D tumble, dramatic slow-down, followed by an explosive starburst particle burst upon settling.

---

## 4. Responsive UI & Multiplatform Support

- **Scale over Offset:** All parent frames use normalized `UDim2.new(scaleX, 0, scaleY, 0)` with `UIAspectRatioConstraint`.
- **Safe Zone Anchoring:**
  - Desktop: Standard 16:9 and ultrawide boundary checks.
  - Mobile / Tablet: Insets to accommodate touch controls, device notches, and camera cutouts.
- **Touch Target Sizes:** Minimum interactive button size is `48x48` logical points to ensure comfortable thumb navigation on phones.
