# CrashLab Game Board Skills Specification

> Single reference document for Claude Code. When asked to build a game board, load this spec to know which patterns, components, structures, and Figma references to use.

---

## Reference Boards

| Board | File Key | Genre | Key Patterns |
|-------|----------|-------|--------------|
| **Avia Aces** | `HbStpqwXkiU8WCBGJyWfum` | Crash / Aviation | Full responsive UI (mobile 375px + desktop 1024px+), HUD, bet controls, multiplier, leaderboard, menu, provably fair, onboarding |
| **Bumblebee (Bumble Road)** | `b8CiLoiovYYxbh3lg2T5dU` | Slot / Bonus | Asset kit page, 6-color symbol system, jackpot mini-game flow (3 screens), character variants, component sets with Property 1 variants |

---

## Shared Design System

**Library:** `Cruhslab - design system`
**Library key:** `lk-65a310e82d99e2574d53aa7f8ceda223a68c78cbe4bcd11b38f3da66c9f251f4c2fb206576dc99aa89e3fe3c87a1bad1701710bc3d64886ccb38b5bd022be1b5`

| Component | Component Key | Type | Use Case |
|-----------|--------------|------|----------|
| Button | `37473b6da3943a3c37d3af6037a147271a5ab30b` | component_set | Primary CTA ("START", "BOOST", "TAP TO PLAY") |
| Button icon | `780abbe9084c51f4631734c5152d7d454de442be` | component_set | Icon-only actions |
| Button icon / 40px | `82664236e76f81598383e8e8db70ae079e8c4239` | component_set | Larger icon buttons (+/- for bet) |
| Button icon / 32px | `00503238aa9d7d4840c39aaf2b584132a9c88bd0` | component_set | Smaller icon buttons |
| Bet button | `c396f2317b315f9a524f6c1d05db4e6d750b6f4f` | component_set | Bet amount quick-select chips |
| Bet stack | `30f14fd215fb15ca0117192a3bc8f847f01d6843` | component_set | Bet amount display with +/- controls |
| Switcher | `1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e` | component_set | Toggle for Music / Sounds / Auto play |
| Tab / 40px | `e8fba16a4dbcfcdef679d4b82f4c7f05109192c4` | component_set | Larger filter tabs |
| Tab / 32px | `b12f4fa3b88d1b6af3c0d7f55647489ce3722198` | component_set | Period filters (DAY / WEEK / MONTH / ALL) |
| Popup | `b22b514eea035af33c163df5cbd71652a6f2d249` | component_set | Modal dialogs, overlays |
| Alert | `3ffe570922a484bb2e013ce0a89aa24853a463aa` | component_set | Notification banners |
| Header | `4d3c237393adbeba5c135a536a1c6943b3ab8ade` | component_set | Game top bar (online count, balance, menu) |
| Input S | `47bfa3765a6f5b528c834680592126cb442490d0` | component_set | Small input field |
| Input L | `25f2647b73f6f9ea7360740ff9a611d179b700f9` | component_set | Large input field (bet amount, seed hashes) |
| Drop | `0c94282b842f65e9c1e4b54869246f24f4141260` | component_set | Dropdown selector |
| Keyboard | `fcaceed0327ffe6b58374bf4f7e40b778d7e9403` | component | Numeric keypad overlay |

**How to look up components at runtime:**

1. Call `search_design_system(query="<component name>", fileKey="<target file key>")` — the `fileKey` is the file you are building in (not the library file)
2. Filter results by `libraryName: "Cruhslab - design system"` to ensure you're using the shared DS
3. Use the returned `componentKey` when creating instances via `use_figma`
4. To restrict to this library only, pass `includeLibraryKeys: ["lk-65a310e82d99e2574d53aa7f8ceda223a68c78cbe4bcd11b38f3da66c9f251f4c2fb206576dc99aa89e3fe3c87a1bad1701710bc3d64886ccb38b5bd022be1b5"]`

**Important:** Individual skills list only component names needed, not keys. Use this table as the key reference when building.

---

## Tier 1 -- Board-Level Skills

### `game-board-crash`

**Purpose:** Assemble a complete crash-style game board from scratch.

**Trigger phrases:** "build a crash game", "create an aviator-style game", "new crash game board"

**Board structure:**
```
Page: "DEV"
  Section: "Mobile"
    Frame: "Default"          375x812  -- Plane on runway, HUD, bet controls
    Frame: "Menu"             375x812  -- Settings overlay with toggles + nav
    Frame: "Type"             375x812  -- Bet input with numeric keyboard
    Frame: "Start game"       375x812  -- In-flight, multiplier running
    Frame: "Start game boost" 375x812  -- In-flight with boost button active
    Frame: "Leaderboard"      375x812  -- Top X / Top Win tabs, data rows
    Frame: "Leaderboard"      375x812  -- Alternate tab state
    Frame: "My bets"          375x812  -- Bet history grouped by date
    Frame: "Provably fair"    375x812  -- Seed/hash fields, bet check table
    Frame: "Game rule"        375x812  -- Text content (RTP, rules, rounds)
    Frame: "table"            375x812  -- Paytable data

  Section: "Desktop"
    Frame: "Desktop - 1"      1024x768 -- Default with leaderboard sidebar
    Frame: "Desktop - 2"      1024x768 -- Menu open
    Frame: "Desktop - 3"      1024x768 -- Typing bet
    Frame: "Desktop - 4"      1024x768 -- Game started, leaderboard collapsed
    Frame: "Desktop - 5"      1024x768 -- In-flight, plane distant
    Frame: "Leaderboard"      1024x768 -- Full-screen leaderboard
    Frame: "Leaderboard"      1024x768 -- Alternate state
    Frame: "My bets"          1024x768 -- Full-screen bet history
    Frame: "Provably fair"    1024x768 -- Full-screen provably fair
    Frame: "Game rules"       1024x768 -- Full-screen rules

  Section: "Onboarding"
    Frame: "mOnboarding"      375x812  -- Mobile splash
    Frame: "wOnboarding"      1024x768 -- Web splash
    Frame: "mOnboarding"      375x812  -- Mobile tutorial
    Frame: "wOnboarding"      1024x768 -- Web tutorial with "PRESS TO START"
```

**DS components to import:** Header, Button, Bet button, Bet stack, Switcher, Tab/32px, Input L, Keyboard, Popup, Drop

**Visual references (screenshot these before building):**

| What | File Key | Node ID |
|------|----------|---------|
| Mobile default (runway) | `HbStpqwXkiU8WCBGJyWfum` | `102:619` |
| Mobile menu | `HbStpqwXkiU8WCBGJyWfum` | `81:1340` |
| Mobile keyboard/type | `HbStpqwXkiU8WCBGJyWfum` | `102:735` |
| Mobile in-flight | `HbStpqwXkiU8WCBGJyWfum` | `102:1073` |
| Mobile in-flight boost | `HbStpqwXkiU8WCBGJyWfum` | `120:745` |
| Mobile leaderboard | `HbStpqwXkiU8WCBGJyWfum` | `146:1337` |
| Mobile my bets | `HbStpqwXkiU8WCBGJyWfum` | `271:2039` |
| Mobile provably fair | `HbStpqwXkiU8WCBGJyWfum` | `145:737` |
| Mobile game rules | `HbStpqwXkiU8WCBGJyWfum` | `271:1937` |
| Desktop default + sidebar | `HbStpqwXkiU8WCBGJyWfum` | `178:859` |
| Desktop clean (no sidebar) | `HbStpqwXkiU8WCBGJyWfum` | `236:2110` |
| Onboarding section | `HbStpqwXkiU8WCBGJyWfum` | `933:5511` |

**Composition rules:**
1. Every mobile screen starts with `Header` component at top (0,0), width 375, height 74
2. Content area sits below header at y=74, width 359, x=8 (8px side padding)
3. Bet controls panel anchored to bottom of mobile screens
4. Desktop screens show game viewport left, sidebar panel right
5. All text uses custom game font (e.g., "Janda Manatee Solid Cyrillic")
6. Background components (`BG`, `mBG`) fill the entire frame behind all content

---

### `game-board-slot`

**Purpose:** Assemble a complete slot/bonus game asset kit board.

**Trigger phrases:** "build a slot game kit", "create a bonus game board", "new slot game assets"

**Board structure:**
```
Page: "Kit Content"
  -- Asset Rows (loose on canvas, organized spatially) --
  Row 1: Game logo + Big Win graphic           y ~2200
  Row 2: Character variants (3 poses/sizes)    y ~2200, x-offset
  Row 3: Full symbols with stems (in frame)    y ~4770
  Row 4: Compact symbols (no stems)            y ~7000
  Row 5: Special symbols (wild, scatter)       y ~7000, x-offset
  Row 6: Background assets                     y ~9800
  Row 7: Preview frames (start page, hex)      y ~15700

  -- Jackpot Feature Screens --
  Frame: "jackpot" (start)    1440x1024        x ~13700
  Frame: "jackpot" (grid)     1440x1024        x ~15200
  Frame: "jackpot" (win)      1440x1024        x ~16700

  -- Component Sets --
  Frame: "jp-state"           ~3957x1189       Component set (mini/major/mega)
  Frame: "jp-win"             ~4100x1511       Component set (3 variants)
```

**DS components to import:** Button

**Local components to create:**

**jp-state** (component set with Property 1):
| Variant | Visual | Size (approx) |
|---------|--------|---------------|
| `mini` | Small green gift box, "MINI" text | 834x880 |
| `major` | Medium teal gift box, "MAJOR" text | 1201x990 |
| `mega` | Large blue/red gift box, "MEGA" text | 1079x1157 |

**jp-win** (component set with Property 1):
| Variant | Visual | Size (approx) |
|---------|--------|---------------|
| `jp-mini` | Gift box + "JACKPOT MINI" text | 1125x1479 |
| `jp-major` | Gift box + "JACKPOT MAJOR" text | 1125x1479 |
| `jp-mega` | Gift box + "JACKPOT MEGA" text | 1125x1479 |

**Visual references:**

| What | File Key | Node ID |
|------|----------|---------|
| Full kit overview | `b8CiLoiovYYxbh3lg2T5dU` | `0:1` |
| Game logo | `b8CiLoiovYYxbh3lg2T5dU` | `139:6` |
| Big Win graphic | `b8CiLoiovYYxbh3lg2T5dU` | `139:7` |
| Character (bee) | `b8CiLoiovYYxbh3lg2T5dU` | `61:7` |
| Symbol stems row | `b8CiLoiovYYxbh3lg2T5dU` | `93:823` |
| Special flower | `b8CiLoiovYYxbh3lg2T5dU` | `90:9` |
| Net symbol | `b8CiLoiovYYxbh3lg2T5dU` | `90:3` |
| Background | `b8CiLoiovYYxbh3lg2T5dU` | `254:1799` |
| Start page preview | `b8CiLoiovYYxbh3lg2T5dU` | `254:1798` |
| Hex preview frame | `b8CiLoiovYYxbh3lg2T5dU` | `254:1800` |
| Jackpot start | `b8CiLoiovYYxbh3lg2T5dU` | `289:1904` |
| Jackpot grid | `b8CiLoiovYYxbh3lg2T5dU` | `289:2002` |
| Jackpot win | `b8CiLoiovYYxbh3lg2T5dU` | `289:2052` |
| jp-state variants | `b8CiLoiovYYxbh3lg2T5dU` | `289:2126` |
| jp-win variants | `b8CiLoiovYYxbh3lg2T5dU` | `289:2127` |

**Composition rules:**
1. Asset rows are loose rectangles on the canvas (not wrapped in section frames)
2. Symbol frames group related symbols with consistent internal spacing
3. Jackpot screens are 1440x1024, placed side by side with ~40px gap
4. Component sets are placed below the jackpot screens
5. Each component variant is a separate symbol child inside the set frame
6. The Button component (from DS) is used in all jackpot screens with different label text

---

## Tier 2 -- Screen-Level Skills

### `game-screen-hud`

**Purpose:** Build the standard game HUD with header, character cards, and bet controls.

**Trigger phrases:** "add game HUD", "build bet controls", "create game header and controls"

**Anatomy (mobile, 375px):**
```
+-----------------------------------------------+
| [sound] . ONLINE: 1920    D***4 +200      [=] |  <- Header component
|         @ BALANCE:              $1000          |
+-----------------------------------------------+
| +----------+ +----------+ +----------+         |  <- Selection cards
| | [plane]  | | [plane]  | | [plane]  |         |
| | POWER    | | POWER    | | POWER    |         |
| | -------- | | ======== | | -------- |         |
| | STABILITY| | STABILITY| | STABILITY|         |
| | -------- | | ======== | | -------- |         |
| +----------+ +----------+ +----------+         |
|                                                |
|          [game viewport area]                  |
|                                                |
| +--------------------------------------------+ |
| | [-]          $ 50                      [+] | |  <- Bet controls
| +--------------------------------------------+ |
| |    1     |    2     |    5     |   10       | |  <- Quick-select tabs
| +--------------------------------------------+ |
| | AUTO PLAY                            [off] | |  <- Switcher
| +--------------------------------------------+ |
| | ========= START ========================== | |  <- CTA Button
| +--------------------------------------------+ |
+------------------------------------------------+
```

**Anatomy (desktop, 1024px+):**
```
+----------------------------------------------------------+-----------+
| [sound]  . ONLINE: 1920    D***4 +200              [=]  |           |
|          @ BALANCE:              $1000                    |           |
+----------------------------------------------------------+           |
|   +----------+ +----------+ +----------+                 | LEADER   |
|   | [plane]  | | [plane]  | | [plane]  |                 | BOARD    |
|   | POWER    | | POWER    | | POWER    |                 |          |
|   | STABILITY| | STABILITY| | STABILITY|                 | rows...  |
|   +----------+ +----------+ +----------+                 |          |
|                                                          |          |
|              [game viewport area]                        |          |
|                                                          |          |
|        +--------------------------------------+          |          |
|        | [-]       $ 50                  [+]  |          |          |
|        | 1    |  2   |   5   |  10            |          +---------+
|        | AUTO PLAY                     [off]  |          |PROVABLY |
|        | ========= START ===============      |          |FAIR   > |
|        +--------------------------------------+          +---------+
+----------------------------------------------------------+-----------+
```

**DS components:** Header, Button, Bet button, Bet stack, Switcher, Tab/32px, Input L, Button icon/40px

**Reference nodes:**

| What | Node ID |
|------|---------|
| Mobile default | `HbStpqwXkiU8WCBGJyWfum` `102:619` |
| Mobile with keyboard | `HbStpqwXkiU8WCBGJyWfum` `102:735` |
| Desktop default | `HbStpqwXkiU8WCBGJyWfum` `236:2110` |
| Desktop with sidebar | `HbStpqwXkiU8WCBGJyWfum` `178:859` |

---

### `game-screen-leaderboard`

**Purpose:** Build leaderboard and bet history screens with tabbed filtering.

**Trigger phrases:** "add leaderboard", "create leaderboard screen", "build bet history"

**Anatomy (mobile, 375px):**
```
+-----------------------------------------------+
| Header (with X close button)                   |
+-----------------------------------------------+
| LEADERBOARD                                    |  <- Title (24px bold)
+-----------------------------------------------+
| [# LEADERBOARD]  [@ MY BETS]                  |  <- Primary tabs
+-----------------------------------------------+
| TOP X   TOP WIN                                |  <- Secondary filter
+-----------------------------------------------+
| [DAY]  |  WEEK  | MONTH  |  ALL               |  <- Tab/32px period filter
+-----------------------------------------------+
| 14:31  [plane]  12   122.33X   1 231        >  |  <- Data row
| 14:31  [plane]  92   120.12X     411        >  |
| 14:31  [plane]  31   112.33X   123 231      >  |
| 14:31  [plane]  54   102.33X     912        >  |
| 14:31  [plane]  67    90.42X     421        >  |
| 14:31  [plane]  32    90.01X   4 411        >  |
+-----------------------------------------------+
```

**Data row anatomy:**
```
| time | icon | round# | multiplier | win_amount | > |
```

**My Bets variant** groups rows under date headers ("Today", "Yesterday").

**DS components:** Header, Tab/32px, (local table row instances)

**Reference nodes:**

| What | Node ID |
|------|---------|
| Mobile leaderboard | `HbStpqwXkiU8WCBGJyWfum` `146:1337` |
| Mobile leaderboard alt state | `HbStpqwXkiU8WCBGJyWfum` `146:1420` |
| Mobile my bets | `HbStpqwXkiU8WCBGJyWfum` `271:2039` |
| Desktop leaderboard | `HbStpqwXkiU8WCBGJyWfum` `271:2616` |

---

### `game-screen-menu`

**Purpose:** Build a settings/navigation menu overlay.

**Trigger phrases:** "add game menu", "create settings screen", "build menu overlay"

**Anatomy (mobile, 375px):**
```
+-----------------------------------------------+
| Header (with X close button)                   |
+-----------------------------------------------+
| MENU                                           |
+-----------------------------------------------+
| [music icon]     MUSIC                   [on]  |  <- Row + Switcher
| [speaker icon]   GAME SOUNDS             [on]  |
| [headphones]     UI SOUNDS              [off]  |
+-----------------------------------------------+
| [money icon]     MY BETS                    >   |  <- Row + chevron
| [trophy icon]    LEADERBOARD                >   |
| [? icon]         HOW TO PLAY                >   |
| [doc icon]       GAME RULES                 >   |
| [check icon]     PROVABLY FAIR              >   |
+-----------------------------------------------+
| Powered by [vortex logo]                       |
+-----------------------------------------------+
|          [bet controls remain visible]         |
+-----------------------------------------------+
```

**DS components:** Header, Switcher

**Reference node:** `HbStpqwXkiU8WCBGJyWfum` `81:1340`

---

### `game-screen-info`

**Purpose:** Build text-heavy informational screens (game rules, provably fair).

**Trigger phrases:** "add game rules screen", "create provably fair page", "build info screen"

**Game Rules anatomy:**
```
+-----------------------------------------------+
| Header (with X close button)                   |
+-----------------------------------------------+
| GAME RULES                                     |
+-----------------------------------------------+
| Cricket crush game rules                       |  <- Subtitle
|                                                |
| Return to Player                               |  <- Section title (bold)
| The overall theoretical return to               |
| the player is 97%.                             |
|                                                |
| Calculating wins                               |  <- Section title (bold)
| The longer the plane stays in the air,         |
| the bigger the win...                          |
|                                                |
| Rounds                                         |  <- Section title (bold)
| After one round ends, the next round           |
| starts in 5 seconds...                         |
+-----------------------------------------------+
```

**Provably Fair anatomy:**
```
+-----------------------------------------------+
| Header (with X close button)                   |
+-----------------------------------------------+
| PROVABLY FAIR                                  |
+-----------------------------------------------+
| Your next seed              RANDOM v           |  <- Label + Drop
| +------------------------------------------+   |
| | BFD3D731A0822B8C                     [copy]|  |  <- Input L
| +------------------------------------------+   |
| Server's next hash                             |
| +------------------------------------------+   |
| | F216E04BC108C45152DA297...            [copy]|  |  <- Input L
| +------------------------------------------+   |
+-----------------------------------------------+
| SELECT BET TO CHECK                            |
| 14:31  [plane]  12  12.33X  123 231         >  |  <- Data rows
| 14:31  [plane]  92  41.12X  101 012         >  |
| ...                                            |
+-----------------------------------------------+
```

**DS components:** Header, Input L, Drop, (table rows)

**Reference nodes:**

| What | Node ID |
|------|---------|
| Game rules | `HbStpqwXkiU8WCBGJyWfum` `271:1937` |
| Provably fair | `HbStpqwXkiU8WCBGJyWfum` `145:737` |
| Provably fair (alternate) | `HbStpqwXkiU8WCBGJyWfum` `212:1515` |

---

### `game-screen-jackpot`

**Purpose:** Build a 3-screen jackpot/bonus mini-game flow.

**Trigger phrases:** "add jackpot feature", "create bonus game", "build jackpot flow"

**Screen 1 -- Start (1440x1024):**
```
+----------------------------------------------------------+
|                    [background image]                     |
|                                                          |
|              JACKPOT                                     |  <- Title (stylized)
|               GAME                                       |  <- Subtitle
|                                                          |
|           +------+  +--------+  +----+                   |
|           | gift |  | GIFT   |  |gift|                   |  <- 3 gift boxes
|           | box  |  | BOX    |  |box |                   |    (small/large/small)
|           +------+  +--------+  +----+                   |
|                                                          |
|            [======= TAP TO PLAY =========]               |  <- Button (DS)
+----------------------------------------------------------+
```

**Screen 2 -- Grid (1440x1024):**
```
+----------------------------------------------------------+
|                    [background image]                     |
|      [jp-mini]      [jp-major]      [jp-mega]            |  <- jp-state instances
|                                                          |
|    +------+ +------+ +------+ +------+ +------+         |
|    |  ?   | |  ?   | |  ?   | |  ?   | |  ?   |         |  <- Row 1 (5 hex cells)
|    +------+ +------+ +------+ +------+ +------+         |
|    +------+ +------+ +------+ +------+ +------+         |
|    |  ?   | |  ?   | |  ?   | |  ?   | |  ?   |         |  <- Row 2
|    +------+ +------+ +------+ +------+ +------+         |
|    +------+ +------+ +------+ +------+ +------+         |
|    |  ?   | |  ?   | |  ?   | |  ?   | |  ?   |         |  <- Row 3
|    +------+ +------+ +------+ +------+ +------+         |
|                                                          |
|            [======= TAP TO OPEN =========]               |  <- Button (DS)
+----------------------------------------------------------+
```

**Screen 3 -- Win (1440x1024):**
```
+----------------------------------------------------------+
|              [dark overlay over grid]                    |
|                                                          |
|      [jp-mini]      [jp-major]      [jp-mega]            |  <- Dimmed
|                                                          |
|                  JACKPOT                                 |
|                   MEGA                                   |  <- jp-win instance
|               +----------+                               |
|               |  opened  |                               |
|               | gift box |                               |
|               +----------+                               |
|                $ 335.23                                  |  <- Prize amount
|                                                          |
|            [====== TAP CONTINUE =========]               |  <- Button (DS)
+----------------------------------------------------------+
```

**Local components to create:**
- `jp-state` component set: Property 1 = mini | major | mega
- `jp-win` component set: Property 1 = jp-mini | jp-major | jp-mega

**DS components:** Button

**Reference nodes:**

| What | Node ID |
|------|---------|
| Jackpot start | `b8CiLoiovYYxbh3lg2T5dU` `289:1904` |
| Jackpot grid | `b8CiLoiovYYxbh3lg2T5dU` `289:2002` |
| Jackpot win | `b8CiLoiovYYxbh3lg2T5dU` `289:2052` |
| jp-state variants | `b8CiLoiovYYxbh3lg2T5dU` `289:2126` |
| jp-win variants | `b8CiLoiovYYxbh3lg2T5dU` `289:2127` |

---

## Tier 3 -- Asset-Level Skills

### `game-asset-symbols`

**Purpose:** Organize game symbols into a structured, consistent asset grid.

**Trigger phrases:** "organize game symbols", "create symbol sheet", "lay out game icons"

**Layout pattern:**
```
+------------------------------------------------------------------+
|  Frame: "Symbol Row 1" (full variants with stems/bases)          |
|  +-------+ +-------+ +-------+ +-------+ +-------+ +-------+   |
|  | sym_1 | | sym_2 | | sym_3 | | sym_4 | | sym_5 | | sym_6 |   |
|  | red   | |orange | | blue  | | d.blue| | pink  | |purple |   |
|  |       | |       | |       | |       | |       | |       |   |
|  | stem  | | stem  | | stem  | | stem  | | stem  | | stem  |   |
|  +-------+ +-------+ +-------+ +-------+ +-------+ +-------+   |
+------------------------------------------------------------------+

  (Below, loose on canvas)

  +-------+ +-------+ +-------+ +-------+ +-------+ +-------+
  | sym_1 | | sym_2 | | sym_3 | | sym_4 | | sym_5 | | sym_6 |   <- Compact row
  | (head | | (head | | (head | | (head | | (head | | (head |      (no stems)
  | only) | | only) | | only) | | only) | | only) | | only) |
  +-------+ +-------+ +-------+ +-------+ +-------+ +-------+

  +---------+  +----------+
  | Special | | Special  |                                        <- Special symbols
  | sym A   | | sym B    |
  +---------+  +----------+

  +-----+ +-----+ +-----+
  | chr | | chr | | chr |                                         <- Character poses
  | sm  | | med | | lg  |
  +-----+ +-----+ +-----+
```

**Naming convention:** `{theme}_{index}_{color}` or `Untitled-1_{index}_{color}`

**Sizing rules:**
- Full symbol row: wrapped in a containing frame, height ~1900px
- Compact symbols: ~1500-1900px height (placed as loose rectangles)
- Consistent spacing between symbols within a row (~200-300px gap)
- Frame 1 (stems) aligned to a shared baseline

**Reference nodes:**

| What | Node ID |
|------|---------|
| Symbol stems row (frame) | `b8CiLoiovYYxbh3lg2T5dU` `93:823` |
| Full kit (shows compact row) | `b8CiLoiovYYxbh3lg2T5dU` `0:1` |
| Character (bee) | `b8CiLoiovYYxbh3lg2T5dU` `61:7` |
| Special symbol (net) | `b8CiLoiovYYxbh3lg2T5dU` `90:3` |
| Special symbol (flower) | `b8CiLoiovYYxbh3lg2T5dU` `90:9` |

---

### `game-screen-onboarding`

**Purpose:** Build an onboarding splash and tutorial flow for a game.

**Trigger phrases:** "add onboarding", "create splash screen", "build tutorial flow"

**Splash screen anatomy (desktop, 1024x768):**
```
+----------------------------------------------------------+
|                                                          |
|              [dark gradient background]                  |
|                                                          |
|                    AVIAT                                  |
|                    ACES                                   |  <- Game logo (centered)
|                                                          |
|                   vortex                                 |  <- Provider logo
|                  --------                                |  <- Loading bar
|                                                          |
+----------------------------------------------------------+
```

**Tutorial screen anatomy (desktop, 1024x768):**
```
+----------------------------------------------------------+
|                   AVIAT ACES                              |  <- Game logo (smaller)
|                    vortex                                 |
|                                                          |
|  +----------------+ +----------------+ +----------------+|
|  |  [illustration]| |  [illustration]| |  [illustration]||
|  |                | |                | |                ||
|  | Pick a plane.  | | Press BOOST    | | Each boost is  ||
|  | Faster plane   | | during the     | | your choice.   ||
|  | means faster   | | flight to go   | | Once the       ||
|  | multiplier     | | further and    | | plane lands,   ||
|  | growth per     | | grow your      | | you get your   ||
|  | boost          | | multiplier     | | winnings       ||
|  +----------------+ +----------------+ +----------------+|
|                                                          |
|                  PRESS TO START                          |  <- CTA text
+----------------------------------------------------------+
```

**Mobile variant:** Same content but single-column, possibly paginated/scrollable.

**Reference nodes:**

| What | Node ID |
|------|---------|
| Onboarding section (all) | `HbStpqwXkiU8WCBGJyWfum` `933:5511` |
| Mobile splash | `HbStpqwXkiU8WCBGJyWfum` `933:5512` |
| Web tutorial | `HbStpqwXkiU8WCBGJyWfum` `933:5526` |
| Mobile tutorial | `HbStpqwXkiU8WCBGJyWfum` `933:5540` |
| Web splash | `HbStpqwXkiU8WCBGJyWfum` `933:5549` |

---

## Usage Guide

### When the user asks to build a game board:

1. **Identify the game type** -- crash/aviator or slot/bonus -- and select Tier 1 skill
2. **Screenshot the reference nodes** listed in the skill to understand visual patterns
3. **Search the DS** via `search_design_system(query, fileKey)` to find component keys
4. **Load `figma-use` skill** before any `use_figma` call
5. **Build section by section**, screenshotting after each section for validation
6. **For custom art** (backgrounds, characters, symbols), expect user-provided assets or generate placeholders

### When the user asks to build a specific screen:

1. Select the matching Tier 2 skill
2. Screenshot the reference node to understand the exact layout
3. Use `get_design_context` on the reference node for detailed code/structure
4. Reproduce the structure using DS components from the shared library
5. Adapt text content, colors, and assets to the user's theme

### When the user asks to organize assets:

1. Select the matching Tier 3 skill
2. Follow the layout pattern and naming conventions
3. Ensure consistent spacing and alignment within rows

### Cross-cutting rules:

- Always `search_design_system` before building to verify component availability
- Always screenshot after building each section for visual QA
- Always load `figma-use` skill before any `use_figma` call
- Pass `skillNames="figma-use"` to every `use_figma` call
- Use DS component keys (not names) for reliable imports
- Create local component sets (like jp-state, jp-win) when the DS doesn't cover game-specific elements
