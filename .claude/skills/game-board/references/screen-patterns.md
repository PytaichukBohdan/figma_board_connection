# Screen Layout Patterns

Blueprints for each screen type. Build these by composing components from [component-recipes.md](component-recipes.md) and applying colors from [theme-system.md](theme-system.md).

---

## 1. Main Game Screen (375 x 812)

The primary gameplay view. Player watches the game and places bets.

```
+----[375px]------------------------------+
| HEADER (see Header recipe)              | 64px
| [Sound] [Online/Balance Stack] [Close]  |
+-----------------------------------------+
|                                         |
|         GAME AREA (flex-grow)           |
|   Full-bleed background image           |
|   Theme elements layered on top:        |
|   - Runway + airplane (Avia Aces)       |
|   - Flower grid + bees (Bumblebee)      |
|   - Crash graph (crash games)           |
|   - Slot reels (slot games)             |
|                                         |
+-----------------------------------------+
| BETTING PANEL (bottom-fixed)            |
| +-------------------------------------+ |
| | [Unput L: $amount with +/- buttons] | | 48px
| | [Tab row: 1  2  5  10]              | | 32px
| | [—————— divider line ——————]        | |
| | [Auto play label] [Switcher]        | | 32px
| | [========= BET BUTTON =========]    | | 56px
| +-------------------------------------+ |
+-----------------------------------------+
```

### Construction Steps

```js
// 1. Page wrapper
const screen = figma.createFrame();
screen.name = "Main Game";
screen.resize(375, 812);
screen.layoutMode = "VERTICAL";
screen.fills = [{ type: 'SOLID', color: PAGE_BACKGROUND }];
screen.clipsContent = true;

// 2. Background (absolute positioned, fills entire frame)
// The MBg component in Avia Aces is a 375x812 frame with layered images:
//   - Sky gradient (bg) at 0,0 — 375x792
//   - Island image at 220,209 — 105x33
//   - Aircraft carrier at 0,246 — 375x566
//   - Plane on runway at 28,325 — 314x200
//   - Rubber band at 34,248 — 309x26
//   - Clouds at various positions — 310x108, 333x121
// For new themes: replace with theme-appropriate layered background images

// 3. Header (recipe from component-recipes.md)
screen.appendChild(header);
header.layoutSizingHorizontal = "FILL";

// 4. Game area (spacer — fills remaining space)
const gameArea = figma.createFrame();
gameArea.name = "Game Area";
gameArea.fills = []; // Transparent — background shows through
screen.appendChild(gameArea);
gameArea.layoutSizingHorizontal = "FILL";
gameArea.layoutGrow = 1;

// 5. Betting panel
const bettingPanel = figma.createFrame();
bettingPanel.name = "Betting Panel";
bettingPanel.layoutMode = "VERTICAL";
bettingPanel.paddingLeft = 8; bettingPanel.paddingRight = 8;
bettingPanel.paddingBottom = 8;
bettingPanel.fills = [];
screen.appendChild(bettingPanel);
bettingPanel.layoutSizingHorizontal = "FILL";

// Inner panel with background
const panelInner = figma.createFrame();
panelInner.name = "Panel Inner";
panelInner.layoutMode = "VERTICAL";
panelInner.itemSpacing = 8;
panelInner.paddingLeft = 12; panelInner.paddingRight = 12;
panelInner.paddingTop = 12; panelInner.paddingBottom = 12;
panelInner.cornerRadius = 16;
panelInner.fills = [{ type: 'SOLID', color: SURFACE_PRIMARY }];
bettingPanel.appendChild(panelInner);
panelInner.layoutSizingHorizontal = "FILL";

// Add: Unput L, Tab row, divider, Switch cells, Button
// Each from component-recipes.md, all with layoutSizingHorizontal = "FILL"
```

---

## 2. Menu Screen (375 x 812)

Settings and navigation hub.

```
+----[375px]------------------------------+
| HEADER                                  | 64px
| [Sound] [Online/Balance Stack] [Close]  |
+-----------------------------------------+
|                                         |
|  MENU PANEL (centered)                  |
|  +-----------------------------------+  |
|  | MENU (title)                      |  |
|  |-----------------------------------|  |
|  | Settings Section (border-bottom)  |  |
|  | [🎵 Music]           [toggle]    |  | 48px each
|  | [🎮 Game Sounds]     [toggle]    |  |
|  | [🎧 UI Sounds]       [toggle]    |  |
|  |-----------------------------------|  |
|  | Navigation Section               |  |
|  | [🕐 My Bets]              [>]   |  | 48px each
|  | [🏆 Leaderboard]          [>]   |  |
|  | [❓ How to Play]          [>]   |  |
|  | [📄 Game Rules]           [>]   |  |
|  | [🛡 Provably Fair]        [>]   |  |
|  |-----------------------------------|  |
|  | Powered by [logo]                |  | 40px
|  +-----------------------------------+  |
|                                         |
+-----------------------------------------+
```

### Key Properties
- Menu panel: positioned at left 8px, top 74px (below header)
- Width: 359px (375 - 16px padding)
- Background: SURFACE_PRIMARY with glow shadow
- Corner radius: 16px
- Sections divided by border-bottom (white/6)

---

## 3. Splash / Loading Screen (375 x 812)

First screen the player sees.

```
+----[375px]------------------------------+
|                                         |
|                                         |
|           [GAME LOGO]                   |
|         (large, centered)               |
|                                         |
|                                         |
|    [Optional: game preview image]       |
|                                         |
|                                         |
|         ████████████░░░░ 72%            | Loading bar
|              or                         |
|        [PRESS TO START]                 | Button CTA
|                                         |
+-----------------------------------------+
```

### Loading Bar Construction
```js
const barBg = figma.createFrame();
barBg.name = "Loading Bar BG";
barBg.resize(280, 12);
barBg.cornerRadius = 6;
barBg.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.1 } }];

const barFill = figma.createFrame();
barFill.name = "Loading Bar Fill";
barFill.resize(200, 12);  // 72% of 280
barFill.cornerRadius = 6;
barFill.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: ACCENT_GRADIENT_FROM_WITH_ALPHA },
    { position: 1, color: ACCENT_GRADIENT_TO_WITH_ALPHA }
  ],
  gradientTransform: [[1, 0, 0], [0, 1, 0]]
}];
barBg.appendChild(barFill);
```

---

## 4. Leaderboard Screen (375 x 812)

Ranked table of top players.

```
+----[375px]------------------------------+
| SUB-HEADER                              | 48px
| [< Back]    Leaderboard     [...]       |
+-----------------------------------------+
| TAB BAR                                 | 40px
| [All Time]  [Today]  [This Week]        |
+-----------------------------------------+
| TABLE HEADER                            | 36px
| # | Player  | Bet    | x    | Payout   |
+-----------------------------------------+
| SCROLLABLE ROWS                         |
| 1  D***4    $100    2.5x   $250.00     | 48px each
| 2  A***7    $200    1.8x   $360.00     |
| 3  K***2    $50     3.2x   $160.00     |
| 4  M***9    $150    0.0x   -$150.00    | (red for loss)
| ...                                     |
+-----------------------------------------+
```

### Sub-Header (variation of Header for info screens)
```js
const subHeader = figma.createFrame();
subHeader.name = "Sub Header";
subHeader.layoutMode = "HORIZONTAL";
subHeader.counterAxisAlignItems = "CENTER";
subHeader.resize(375, 48);
subHeader.paddingLeft = 8; subHeader.paddingRight = 8;
subHeader.itemSpacing = 8;
subHeader.fills = [{ type: 'SOLID', color: SURFACE_PRIMARY }];

// Back button (Button Icon 32px with left arrow)
// Title text (flex-grow, centered, 20px)
// Optional right action (dots menu, filter)
```

### Tab Bar (40px variant)
```js
const tabBar = figma.createFrame();
tabBar.name = "Tab Bar";
tabBar.layoutMode = "HORIZONTAL";
tabBar.resize(375, 40);
tabBar.paddingLeft = 8; tabBar.paddingRight = 8;
tabBar.itemSpacing = 4;
tabBar.fills = [];

// Add Tab / 32px instances with labels: "All Time", "Today", "This Week"
// Active tab: different fill or underline
```

### Table Row (data)
```js
const dataRow = figma.createFrame();
dataRow.name = "Table Row";
dataRow.layoutMode = "HORIZONTAL";
dataRow.counterAxisAlignItems = "CENTER";
dataRow.resize(359, 48);
dataRow.paddingLeft = 12; dataRow.paddingRight = 12;
dataRow.paddingTop = 8; dataRow.paddingBottom = 8;
dataRow.itemSpacing = 8;
dataRow.fills = [];

// Rank text (fixed 24px width)
// Player name (flex-grow)
// Bet amount (fixed 60px)
// Multiplier (fixed 40px)
// Payout (fixed 80px, green for win / red for loss)

// Alternate row background: every other row gets white/3 fill
```

---

## 5. Jackpot Screen (1440 x 1024, Desktop)

Slot/jackpot game view with tier badges and prize grid.

```
+------[1440px]---------------------------------------------------+
|                    BACKGROUND IMAGE                              |
|                                                                  |
|              [MINI]     [MAJOR]     [MEGA]                       | Tier badges
|                                                                  |
|    +-------+-------+-------+-------+-------+                    |
|    | cell  | cell  | cell  | cell  | cell  |                    | Row 1
|    +-------+-------+-------+-------+-------+                    |
|    | cell  | cell  | cell  | cell  | cell  |                    | Row 2
|    +-------+-------+-------+-------+-------+                    |
|    | cell  | cell  | cell  | cell  | cell  |                    | Row 3
|    +-------+-------+-------+-------+-------+                    |
|                                                                  |
|                   [TAP TO OPEN]                                  | Button
+------------------------------------------------------------------+
```

### Grid Construction
```js
const grid = figma.createFrame();
grid.name = "Prize Grid";
grid.layoutMode = "VERTICAL";
grid.itemSpacing = 0;
grid.fills = [];

for (let r = 0; r < 3; r++) {
  const row = figma.createFrame();
  row.name = `Row ${r + 1}`;
  row.layoutMode = "HORIZONTAL";
  row.itemSpacing = 0;
  row.fills = [];

  for (let c = 0; c < 5; c++) {
    const cell = figma.createFrame();
    cell.name = "Cell";
    // Cells alternate: 186x194 and 182x194
    cell.resize(c % 2 === 0 ? 186 : 182, 194);
    cell.fills = []; // Will contain symbol image
    row.appendChild(cell);
  }

  grid.appendChild(row);
  row.layoutSizingHorizontal = "HUG";
}
// Grid total: ~924 x 582
```

### Tier Badge Row
```js
const tierRow = figma.createFrame();
tierRow.name = "Jackpot Tiers";
tierRow.resize(713, 144);
tierRow.fills = [];
// Position centered: x = (1440 - 713) / 2 = 363.5, y = 58

// Badges are absolutely positioned (not auto-layout):
// mini:  x=142, y=34.4,  size=104x109
// major: x=279, y=20.7,  size=149x123
// mega:  x=462, y=0,     size=134x144
```

---

## 6. Win Celebration Overlay (same dimensions as game screen)

Appears on top of the game when player wins.

```
+------------------------------------------+
|  ████ DARK OVERLAY rgba(0,0,0,0.85) ████ |
|  ██                                  ███ |
|  ██     [JACKPOT MEGA title]         ███ |
|  ██     [Prize box artwork]          ███ |
|  ██                                  ███ |
|  ██        $ 335.23                  ███ |
|  ██     (88px, white, shadow)        ███ |
|  ██                                  ███ |
|  ██       [TAP CONTINUE]            ███ |
|  ████████████████████████████████████████ |
+------------------------------------------+
```

### Win Amount Text
```js
const winAmount = figma.createText();
winAmount.characters = "$ 335.23";
winAmount.fontSize = 88;
winAmount.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
winAmount.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
winAmount.textCase = "UPPER";
winAmount.textAlignHorizontal = "CENTER";
// Text shadow applied via effects on a containing frame
```

---

## 7. Provably Fair Screen (375 x 812)

Verification page with input fields and informational text.

```
+----[375px]------------------------------+
| SUB-HEADER                              |
| [< Back]    Provably Fair    [...]      |
+-----------------------------------------+
|                                         |
|  [Shield icon, large centered]          |
|                                         |
|  Explanatory text about the fairness    |
|  system, how seeds work, etc.           |
|                                         |
|  [Server Seed: ________]  [Copy]       |
|  [Client Seed: ________]  [Copy]       |
|  [Nonce: ________]        [Copy]       |
|                                         |
|  [========= VERIFY =========]          |
|                                         |
+-----------------------------------------+
```

### Input + Copy Row
```js
const inputRow = figma.createFrame();
inputRow.name = "Seed Input";
inputRow.layoutMode = "HORIZONTAL";
inputRow.counterAxisAlignItems = "CENTER";
inputRow.itemSpacing = 8;
inputRow.fills = [];

// Label (fixed width)
// Input field (flex-grow, uses Input Small recipe)
// Copy button (Button Icon 32px)
```

---

## 8. Game Rules Screen (375 x 812)

Scrollable rich text with optional illustrations.

```
+----[375px]------------------------------+
| SUB-HEADER                              |
| [< Back]     Game Rules       [...]     |
+-----------------------------------------+
|                                         |
|  SCROLLABLE CONTENT (clipsContent)      |
|                                         |
|  How to Play                            |
|  ─────────────────────────────          |
|  1. Set your bet amount                 |
|  2. Press the Start button              |
|  3. Watch the multiplier rise           |
|  4. Cash out before the crash!          |
|                                         |
|  [Illustration frame placeholder]       |
|                                         |
|  Payout Rules                           |
|  ─────────────────────────────          |
|  - Min bet: $1                          |
|  - Max bet: $1000                       |
|  - Max win: 32x                         |
|                                         |
+-----------------------------------------+
```

---

## Assembly Order for a Full Game Board

When building a complete set of screens:

1. **Create a new Figma page** named after the game
2. **Build screens left to right** with 100px gaps:
   - Position 0: Splash screen
   - Position 475: Main Game screen
   - Position 950: Menu screen
   - Position 1425: Leaderboard
   - Position 1900: My Bets
   - Position 2375: Provably Fair
   - Position 2850: Game Rules
3. **Build popups** below the main row (y offset +900):
   - Alert popup
   - Win celebration popup
   - Game rules popup overlay
4. **Build desktop variants** (if needed) in a separate row below
5. **Organize assets** on a separate "Assets" page
