# Game Board Skills Specification

> **Purpose**: Define a set of self-sufficient Claude Code skills for building mobile game boards in Figma, derived from the Avia Aces and Bumblebee (Bumble Road) reference boards. Each skill encodes reusable patterns, layout structures, and component usage so Claude can build new game boards for any theme without referencing the original Figma files.

> **Design System**: Cruhslab - design system (library key: `lk-65a310e82d99e2574d53aa7f8ceda223a68c78cbe4bcd11b38f3da66c9f251f4c2fb206576dc99aa89e3fe3c87a1bad1701710bc3d64886ccb38b5bd022be1b5`)

---

## Table of Contents

1. [Design System Component Registry](#1-design-system-component-registry)
2. [Skill 1: game-board-main — Main Game Screen](#skill-1-game-board-main)
3. [Skill 2: game-board-menu — Menu & Info Screens](#skill-2-game-board-menu)
4. [Skill 3: game-board-splash — Loading & Splash Screens](#skill-3-game-board-splash)
5. [Skill 4: game-board-popup — Popups & Modals](#skill-4-game-board-popup)
6. [Skill 5: game-board-betting — Betting Controls](#skill-5-game-board-betting)
7. [Skill 6: game-board-table — Data Tables & Lists](#skill-6-game-board-table)
8. [Skill 7: game-board-jackpot — Jackpot & Win Systems](#skill-7-game-board-jackpot)
9. [Skill 8: game-board-header — Header & Navigation](#skill-8-game-board-header)
10. [Skill 9: game-board-assets — Theme Asset Kit Assembly](#skill-9-game-board-assets)
11. [Cross-Skill Patterns & Conventions](#cross-skill-patterns)
12. [Triggering & Description Strategy](#triggering-strategy)

---

## 1. Design System Component Registry

Every skill references these shared components by key. This is the single source of truth — skills must import components by `componentKey` at runtime via `figma.importComponentSetByKeyAsync(key)` (for component sets) or `figma.importComponentByKeyAsync(key)` (for single components). Keys are stable across files; node IDs are not.

### Buttons & Actions

| Component | Type | componentKey | Variants / Notes |
|-----------|------|-------------|------------------|
| **Button** | component_set | `37473b6da3943a3c37d3af6037a147271a5ab30b` | Primary CTA. Variants include size and state. Used for "Place Bet", "Start", "Close" actions. |
| **Button icon** | component_set | `780abbe9084c51f4631734c5152d7d454de442be` | Icon-only button, general size. Used for settings, sound, close. |
| **Button icon / 40 px** | component_set | `82664236e76f81598383e8e8db70ae079e8c4239` | Large icon button (40px). Header actions. |
| **Button icon / 32px** | component_set | `00503238aa9d7d4840c39aaf2b584132a9c88bd0` | Small icon button (32px). Inline actions. |
| **Bet button** | component_set | `c396f2317b315f9a524f6c1d05db4e6d750b6f4f` | The main betting CTA. Wider, more prominent than regular Button. Variants for active/disabled/pressed states. |

### Betting & Input Controls

| Component | Type | componentKey | Variants / Notes |
|-----------|------|-------------|------------------|
| **Bet slider** | component_set | `5664c3b9b3fd396dc8bb2d8d3b54535fff845da0` | Horizontal slider for bet amount. Has min/max range indicators. |
| **Bet stack** | component_set | `30f14fd215fb15ca0117192a3bc8f847f01d6843` | Vertical stack of preset bet amounts (quick-pick chips). Variants for selected/unselected states. |
| **Unput S** (Input Small) | component_set | `47bfa3765a6f5b528c834680592126cb442490d0` | Small input field. Used for bet amounts, search. Variants for focused/default/error states. |
| **keyboaard** | component | `fcaceed0327ffe6b58374bf4f7e40b778d7e9403` | Full numeric keyboard overlay. Single component (not a set). Appears when user taps input fields. |

### Navigation & Tabs

| Component | Type | componentKey | Variants / Notes |
|-----------|------|-------------|------------------|
| **Tab / 32px** | component_set | `b12f4fa3b88d1b6af3c0d7f55647489ce3722198` | Small tab for switching views (32px height). Variants: active/inactive. |
| **Tab / 40px** | component_set | `e8fba16a4dbcfcdef679d4b82f4c7f05109192c4` | Large tab (40px height). Used in main menu navigation. Variants: active/inactive. |
| **Tab line fill** | component_set | `40dc9fc988e446ba214c660aebbc05f226b1bc26` | Underline-style tab indicator. Used as alternative tab style. |
| **Swither** (Switcher/Toggle) | component_set | `1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e` | On/off toggle. Used for sound, notifications, settings. Variants: on/off. |

### Containers & Overlays

| Component | Type | componentKey | Variants / Notes |
|-----------|------|-------------|------------------|
| **Popup** | component_set | `b22b514eea035af33c163df5cbd71652a6f2d249` | Modal popup container with backdrop. Variants for different content types (info, confirmation, game rules). |
| **Alert** | component_set | `3ffe570922a484bb2e013ce0a89aa24853a463aa` | Inline alert banner. Variants: info/warning/error/success. Appears at top of screen. |
| **Table** | component_set | `f5600da5f1240401a150078f2f6225723787b71b` | Data table container with header and rows. Used for leaderboard, bet history. |

### Layout & Navigation (confirmed keys)

| Component | Type | componentKey | Variants / Notes |
|-----------|------|-------------|------------------|
| **Header** | component_set | `4d3c237393adbeba5c135a536a1c6943b3ab8ade` | Top navigation bar with logo slot, balance display, and action buttons. Present on every screen. |
| **Row** | component_set | `448aaa34c7ac9ee31a9cd038ac570b0a0289224e` | Individual row inside Table component. Used for leaderboard entries, bet history items. |
| **Settings input** | component_set | `dc4c943d901d0dd9e533952ffb215f8e6bed7db7` | Form field for settings screens. Label + input pattern. |
| **Unput L** (Input Large) | component_set | `25f2647b73f6f9ea7360740ff9a611d179b700f9` | Large input field. Used for prominent text entry (seed verification, search). |
| **Switch cells** | component_set | `882c98e20f8962e6f3ff94aaa5b4ea2016dca806` | Grid cells that toggle on/off. Used in game rules and settings. |
| **Togl** (Toggle) | component_set | `2539bd82d99386fd31e945f535f60b5e6340ae9a` | Simple toggle switch. Alternative to Swither for inline toggle. |
| **Drop** (Dropdown) | component_set | `0c94282b842f65e9c1e4b54869246f24f4141260` | Dropdown selector. Used in settings and filter controls. |
| **Common** (Icons) | component_set | `748acb726a9508cc2cff135522e0ff73db826b62` | Shared icon library component. Contains utility icons (Copy, X, CaretRight, etc.). |
| **Progress** | component_set | `2085354bcffbe48f934ff972c81c3788d367aae5` | Progress bar. Used for loading screens and game progression indicators. |
| **Tab line** | component_set | `b926bc6084c42194af7e2477809bb45f41d0ab94` | Thin underline tab indicator. Alternative tab style to Tab line fill. |

### Instances Observed (keys to be discovered at runtime)

These appear in the boards but their component keys were not confirmed via search:

- **Pills/Normal/32/Normal** — Pill-shaped filter/tag elements
- **BG** / **mBG** / **wBg** — Background containers (full/mobile/wide variants)
- **Button close** — Close/X button for popups (may be a variant of Button icon)
- **Icon outline** — Generic icon wrapper
- Specific Phosphor-style icons: **Copy**, **X**, **CaretRight**, **DotsThreeVertical**, **Trophy**, **ClockCountdown**, **ShieldCheck**

### Color Variable Tokens

All from **Collection 2** (key: `640727dc98dd3b96f3e037b7fd683c7cb5b5bbf8`), scope: `ALL_SCOPES`.

| Color Family | Available Steps | Key Examples |
|--------------|----------------|-------------|
| Colors/Base/White | 3, 6, 10, 20, 40, 60, 80, 100 (opacity variants) | White/100: `771ae8a6833e4ffae6a670337fe535fa8a481087` |
| Colors/Cyan | 25, 50, 100, 300, 400, 600, 700 | Cyan/50: `c7b89166ac2973ffad8737ecce96c105200aa6ca` |
| Colors/Yellow | 25-950 (full 12-step scale) | Yellow/400: `1284c93e961e781c04093f3c8bd16a42437d4311` |
| Colors/Green | 25-950 (full 12-step scale) | — |
| Colors/Green light | 25-950 | Green-light/500: `#66c61c`, Green-light/950: `#15290a` |
| Colors/Orange | 25-950 (full 12-step scale) | — |
| Colors/Purple | 25-950 (full 12-step scale) | — |
| Colors/Gray cool | 25-950 (full 12-step scale) | — |
| Colors/Blue | 25, 50 | Blue/25: `fd9fc7bbaaafd028450f40cb53a7c2ef833157f4` |
| Colors/Pink | 25, 50 | — |
| Colors/Teal | 25 | — |
| Colors/Moss | 25, 50 | — |
| Colors/Rose | 50 | — |

### Button Component Styling Reference (from Bumblebee board inspection)

The Button component uses these specific design tokens — useful for matching style when building custom elements:

```
Border: 2px solid Colors/Green-light/950 (#15290a)
Border radius: 12px (token: --radius-(12))
Padding: 24px horizontal (token: --spacing-(24)), 16px vertical
Background: Gradient from Green-light/500 (#66c61c) to Green/600 (#099250)
Text: "Janda Manatee Solid Cyrillic", 32px, uppercase, white
Glow: 30px green glow (Green/400 #3ccb7f)
Inner highlight: inset 0px 3px 1px Colors/Green-light/200 (#d0f8ab)
Inner shadow: inset 0px -3px 1px Colors/Green-light/800 (#326212)
Text shadow: 0px 2px 0px Colors/Green-light/950 (#15290a)
```

---

## Skill 1: game-board-main

### Name
`game-board-main`

### Description (trigger text)
Build the main gameplay screen for a mobile game board in Figma. Use when the user asks to "create a game board", "build the main game screen", "design the gameplay view", "make a crash/aviator game screen", "build a slot game screen", or any request for the primary interactive game view with betting controls. This is the central screen where players see the game animation and place bets.

### What It Builds
The main game screen — the most complex screen in any game board. It is the full-screen view where the player watches the game unfold and interacts with betting controls.

### Layout Pattern (from reference boards)

```
+------------------------------------------+
|              HEADER (fixed top)           |
|  [Logo]  [$Balance]  [Sound] [Settings]  |
+------------------------------------------+
|                                           |
|           GAME AREA (flexible)            |
|  Full-bleed background image/animation    |
|  Theme-specific content fills this area   |
|  (runway + planes, flower grid + bees,    |
|   slot reels, crash graph, etc.)          |
|                                           |
+------------------------------------------+
|         BETTING CONTROLS (fixed bottom)   |
|  +--------------------------------------+|
|  | [Bet Stack]  [Input]  [Bet Button]   ||
|  |              [Slider]                ||
|  +--------------------------------------+|
+------------------------------------------+
```

### Screen Dimensions
- **Mobile portrait**: 375 x 812 (iPhone standard) or 390 x 844
- **Desktop landscape**: 1440 x 1024 (observed in Bumblebee jackpot frames)

### Construction Steps

1. **Create the page wrapper frame**
   - Size: 375 x 812 (mobile) or 1440 x 1024 (desktop)
   - `layoutMode: "VERTICAL"`
   - `primaryAxisAlignItems: "MIN"` (top-aligned)
   - `layoutSizingVertical: "FIXED"`, `layoutSizingHorizontal: "FIXED"`
   - No padding — content goes edge to edge

2. **Add background**
   - Import or place a theme-specific background image as the first layer
   - The background should fill the entire frame (use `constraints` or absolute positioning)
   - In reference boards: dark blue gradient (Avia Aces) or sky/nature scene (Bumblebee)

3. **Add Header** (import from DS)
   - Search for "Header" component via `search_design_system`
   - Place at top, `layoutSizingHorizontal: "FILL"`
   - Override logo slot with game-specific logo
   - Override balance text with placeholder: "$ 1,250.00"

4. **Add Game Area**
   - Create a frame for the main game visualization
   - `layoutGrow: 1` (takes remaining space)
   - `layoutSizingHorizontal: "FILL"`
   - This is where theme-specific content goes (planes, flowers, graph, reels)
   - The game area is typically transparent or uses the background image showing through

5. **Add Betting Controls section** (bottom)
   - See [Skill 5: game-board-betting](#skill-5-game-board-betting) for detailed construction
   - Import: Bet button, Bet stack (or Bet slider), Input Small
   - Horizontal layout with spacing

### DS Components Used
- Header (`4d3c237393adbeba5c135a536a1c6943b3ab8ade`)
- BG / mBG (runtime lookup — search "background" or inspect existing screens)
- Bet button (`c396f2317b315f9a524f6c1d05db4e6d750b6f4f`)
- Bet stack (`30f14fd215fb15ca0117192a3bc8f847f01d6843`)
- Bet slider (`5664c3b9b3fd396dc8bb2d8d3b54535fff845da0`)
- Unput S (`47bfa3765a6f5b528c834680592126cb442490d0`)
- Button icon / 32px (`00503238aa9d7d4840c39aaf2b584132a9c88bd0`)
- Progress (`2085354bcffbe48f934ff972c81c3788d367aae5`) — for loading indicator in game area

### Theme Customization Points
| Element | Avia Aces Example | Bumblebee Example | What to Customize |
|---------|-------------------|-------------------|-------------------|
| Background | Dark blue sky gradient with clouds | Bright sky with green hills | Background image/gradient |
| Game area content | Runway, airplane, multiplier text | Flower grid (5x3), bees | Game-specific artwork |
| Logo | "Avia Aces" neon text | "Bumble Road" honey text | Game logo asset |
| Color accent | Gold/yellow on navy | Orange/green on sky blue | Accent color for buttons, highlights |

---

## Skill 2: game-board-menu

### Name
`game-board-menu`

### Description (trigger text)
Build menu and information screens for a mobile game board in Figma. Use when the user asks to "create the menu screen", "build a leaderboard", "design the my bets screen", "make a provably fair page", "build game rules", "design settings screen", or any request for secondary/info screens that sit behind the main game view. These screens share a consistent shell: header with tabs at top, scrollable content area below.

### What It Builds
The family of secondary screens accessed from the game's menu. In both reference boards, these follow a consistent shell pattern with swappable content.

### Layout Pattern

```
+------------------------------------------+
|              HEADER (fixed top)           |
|  [< Back]  [Screen Title]  [...]         |
+------------------------------------------+
|           TAB BAR (optional)              |
|  [All Bets] [My Bets] [Top Wins]         |
+------------------------------------------+
|                                           |
|        CONTENT AREA (scrollable)          |
|                                           |
|  Content varies by screen type:           |
|  - Table rows (leaderboard, bet history)  |
|  - Settings form (settings input fields)  |
|  - Rich text (game rules, provably fair)  |
|  - Stats cards (win/loss summary)         |
|                                           |
+------------------------------------------+
```

### Screen Types Found in Reference Boards

#### A. Menu / Navigation Hub
- Grid or list of menu items leading to sub-screens
- Each item: icon + label + chevron (CaretRight)
- Items observed: Leaderboard, My Bets, Provably Fair, Game Rules, Settings

#### B. Leaderboard
- Header with title "Leaderboard"
- Tab bar: filtering by time period (All Time, Today, This Week)
- Table with ranked rows: [Rank] [Player Name] [Bet Amount] [Multiplier] [Payout]
- Scrollable, with alternating row backgrounds

#### C. My Bets
- Header with title "My Bets"
- Tab bar: All Bets / Active / Won / Lost
- Table rows: [Time] [Bet Amount] [Multiplier] [Result] [Payout]
- Status indicators: green (won), red (lost), yellow (active)

#### D. Provably Fair
- Header with title "Provably Fair"
- Rich text content explaining the fairness system
- Input fields for seed verification
- ShieldCheck icon prominently displayed
- "Verify" button at bottom

#### E. Game Rules
- Header with title "Game Rules"
- Rich text with illustrated instructions
- Switch cells for toggling rule categories
- Scrollable content

### Construction Steps

1. **Create wrapper** (375 x 812 mobile, VERTICAL auto-layout)
2. **Import Header** — set title text, add back button (CaretRight flipped or dedicated back icon)
3. **Add Tab bar** (if needed) — import Tab / 32px or Tab / 40px, create horizontal row of tabs
4. **Add Content area** — frame with `layoutGrow: 1`, `layoutMode: "VERTICAL"`, `clipsContent: true` for scrolling
5. **Populate content** based on screen type (see above)

### DS Components Used
- Header (`4d3c237393adbeba5c135a536a1c6943b3ab8ade`)
- Tab / 32px (`b12f4fa3b88d1b6af3c0d7f55647489ce3722198`)
- Tab / 40px (`e8fba16a4dbcfcdef679d4b82f4c7f05109192c4`)
- Tab line (`b926bc6084c42194af7e2477809bb45f41d0ab94`)
- Tab line fill (`40dc9fc988e446ba214c660aebbc05f226b1bc26`)
- Table (`f5600da5f1240401a150078f2f6225723787b71b`)
- Row (`448aaa34c7ac9ee31a9cd038ac570b0a0289224e`)
- Settings input (`dc4c943d901d0dd9e533952ffb215f8e6bed7db7`)
- Swither (`1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e`)
- Switch cells (`882c98e20f8962e6f3ff94aaa5b4ea2016dca806`)
- Drop (`0c94282b842f65e9c1e4b54869246f24f4141260`)
- Button icon / 32px (`00503238aa9d7d4840c39aaf2b584132a9c88bd0`)
- Common icons (`748acb726a9508cc2cff135522e0ff73db826b62`) — CaretRight, DotsThreeVertical, Trophy, ClockCountdown, ShieldCheck, Copy

---

## Skill 3: game-board-splash

### Name
`game-board-splash`

### Description (trigger text)
Build loading, splash, and intro screens for a mobile game board in Figma. Use when the user asks to "create a loading screen", "build a splash screen", "design the intro", "make a start screen", "build the game's welcome/landing screen", or any request for the first screen a player sees when opening the game. Includes logo reveal, loading progress, and "Press to Start" call-to-action.

### What It Builds
The first screen(s) a player sees. From the reference boards, there are typically 2-3 splash variants:

### Screen Variants

#### A. Logo / Brand Screen
```
+------------------------------------------+
|                                           |
|                                           |
|            [GAME LOGO]                    |
|          large, centered                  |
|                                           |
|          "LOADING..."                     |
|         [████████░░░░] 67%               |
|                                           |
+------------------------------------------+
```
- Full-screen background (theme-specific)
- Centered game logo (large, prominent)
- Loading bar at bottom third
- Subtle animation implied (logo pulse, progress bar fill)

#### B. Press to Start
```
+------------------------------------------+
|                                           |
|            [GAME LOGO]                    |
|           (smaller than A)                |
|                                           |
|   [Game preview / illustration]           |
|   showing the game board in action        |
|                                           |
|         [PRESS TO START]                  |
|          (Button, pulsing)                |
|                                           |
+------------------------------------------+
```
- Background with game preview
- Logo at top
- Central illustration or game preview
- Large CTA button at bottom: "PRESS TO START" or "PLAY NOW"

#### C. Info Splash (observed in Avia Aces)
```
+------------------------------------------+
|          [GAME LOGO small]                |
|                                           |
|  +------------------------------------+  |
|  |  How to Play:                       |  |
|  |  1. Place your bet                  |  |
|  |  2. Watch the multiplier rise       |  |
|  |  3. Cash out before crash!          |  |
|  +------------------------------------+  |
|                                           |
|           [READY TO PLAY]                 |
+------------------------------------------+
```

### Construction Steps

1. **Create wrapper** (375 x 812, no auto-layout or VERTICAL centered)
2. **Place background** — full-bleed theme background
3. **Place logo** — centered, upper third of screen
4. **Add loading bar** (Variant A) or **CTA button** (Variant B)
   - Loading bar: manual frame with rounded rect fill + progress indicator
   - CTA: Import Button component, set label to "PRESS TO START"
5. **Optional game preview** — placeholder frame for game illustration

### DS Components Used
- Button (`37473b6da3943a3c37d3af6037a147271a5ab30b`) — for CTA
- Progress (`2085354bcffbe48f934ff972c81c3788d367aae5`) — for loading bar
- BG (runtime lookup — search "background" in DS)

---

## Skill 4: game-board-popup

### Name
`game-board-popup`

### Description (trigger text)
Build popup overlays and modal dialogs for a mobile game board in Figma. Use when the user asks to "create a popup", "build a modal", "design an alert dialog", "make a confirmation popup", "build a game rules overlay", "design a win/loss popup", "create a cashout confirmation", or any overlay that appears on top of the main game screen. Includes semi-transparent backdrop and centered content card.

### What It Builds
Overlay popups that appear on top of game screens. From the reference boards, several popup types exist.

### Popup Types

#### A. Alert / Notification Popup
```
+------------------------------------------+
|  ░░░░░░ SEMI-TRANSPARENT BACKDROP ░░░░░░ |
|  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ |
|  ░░ +--------------------------------+ ░░ |
|  ░░ |  [Alert icon]                  | ░░ |
|  ░░ |  Alert Title                   | ░░ |
|  ░░ |  Alert message text here       | ░░ |
|  ░░ |                                | ░░ |
|  ░░ |  [OK Button]                   | ░░ |
|  ░░ +--------------------------------+ ░░ |
|  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ |
+------------------------------------------+
```

#### B. Confirmation Popup
```
+------------------------------------------+
|  ░░░░░░ SEMI-TRANSPARENT BACKDROP ░░░░░░ |
|  ░░ +--------------------------------+ ░░ |
|  ░░ |          [X close]             | ░░ |
|  ░░ |  Confirm Cash Out?             | ░░ |
|  ░░ |  You will receive $125.50      | ░░ |
|  ░░ |                                | ░░ |
|  ░░ |  [Cancel]      [Confirm]       | ░░ |
|  ░░ +--------------------------------+ ░░ |
+------------------------------------------+
```

#### C. Game Rules / Info Popup
```
+------------------------------------------+
|  ░░░░░░ SEMI-TRANSPARENT BACKDROP ░░░░░░ |
|  ░░ +--------------------------------+ ░░ |
|  ░░ | Game Rules            [X close]| ░░ |
|  ░░ |                                | ░░ |
|  ░░ | [Scrollable rich text content] | ░░ |
|  ░░ | with illustrations, tables,    | ░░ |
|  ░░ | and step-by-step instructions  | ░░ |
|  ░░ |                                | ░░ |
|  ░░ | [Got It]                       | ░░ |
|  ░░ +--------------------------------+ ░░ |
+------------------------------------------+
```

### Construction Steps

1. **Create backdrop frame** (375 x 812, fills entire screen)
   - Fill: solid black at 50-70% opacity `{r: 0, g: 0, b: 0}` with opacity 0.5-0.7
   - `layoutMode: "VERTICAL"`, center-aligned both axes

2. **Import Popup component** from DS
   - The Popup component set provides the card container
   - Override title, message, and button labels

3. **Add close button** — Import Button close or Button icon / 32px with X icon

4. **Add action buttons** — Import Button, place in horizontal row at bottom of popup

### DS Components Used
- Popup (`b22b514eea035af33c163df5cbd71652a6f2d249`)
- Alert (`3ffe570922a484bb2e013ce0a89aa24853a463aa`)
- Button (`37473b6da3943a3c37d3af6037a147271a5ab30b`)
- Button close (likely a variant of Button icon — search "close" or "button" at runtime)
- Button icon / 32px (`00503238aa9d7d4840c39aaf2b584132a9c88bd0`)
- Common icons (`748acb726a9508cc2cff135522e0ff73db826b62`) — for X/close icon

---

## Skill 5: game-board-betting

### Name
`game-board-betting`

### Description (trigger text)
Build the betting controls section for a mobile game board in Figma. Use when the user asks to "create betting controls", "build the bet panel", "design the wager section", "make bet input with slider", "build the bottom bet bar", or any request for the UI where players set their bet amount and place bets. This is the bottom section of the main game screen.

### What It Builds
The betting controls docked at the bottom of the main game screen. This is the primary interaction point for players.

### Layout Variants

#### A. Compact (Avia Aces style — mobile portrait)
```
+------------------------------------------+
| [Bet Stack]  [$ Input]  [BET BUTTON]     |
|              [====Slider====]             |
+------------------------------------------+
```
- Single row: preset chips (Bet stack) | amount input (Unput S) | CTA (Bet button)
- Below: full-width slider (Bet slider)
- When input tapped: numeric keyboard slides up from bottom

#### B. Expanded with Keyboard
```
+------------------------------------------+
| [Bet Stack]  [$ Input]  [BET BUTTON]     |
|              [====Slider====]             |
+------------------------------------------+
|                                           |
|  [1] [2] [3]    [Min]  [Max]             |
|  [4] [5] [6]    [1/2]  [2x]             |
|  [7] [8] [9]    [Undo] [OK]             |
|      [0] [.]                              |
+------------------------------------------+
```

#### C. Desktop wide (Bumblebee style — landscape)
```
+-------------------------------------------------------+
| [Bet Stack vertical] | [$ Amount]  [BET]              |
|                      | [========Slider========]       |
+-------------------------------------------------------+
```

### Construction Steps

1. **Create betting section frame**
   - `layoutMode: "VERTICAL"`, padding 12-16px
   - Background: semi-transparent dark fill or blurred backdrop
   - `layoutSizingHorizontal: "FILL"`

2. **Create top row** (HORIZONTAL auto-layout, gap 8-12px)
   - Import **Bet stack** — preset amount chips
   - Import **Unput S** — bet amount input field
   - Import **Bet button** — main CTA

3. **Add slider row** (below top row)
   - Import **Bet slider** — full width
   - `layoutSizingHorizontal: "FILL"`

4. **Keyboard overlay** (separate, conditionally visible)
   - Import **keyboaard** component
   - Positioned at bottom, overlaying the game area when active

### DS Components Used
- Bet button (`c396f2317b315f9a524f6c1d05db4e6d750b6f4f`)
- Bet stack (`30f14fd215fb15ca0117192a3bc8f847f01d6843`)
- Bet slider (`5664c3b9b3fd396dc8bb2d8d3b54535fff845da0`)
- Unput S (`47bfa3765a6f5b528c834680592126cb442490d0`)
- keyboaard (`fcaceed0327ffe6b58374bf4f7e40b778d7e9403`)

### Text Overrides
| Component | Property to Override | Example Value |
|-----------|---------------------|---------------|
| Unput S | Input text | "100.00" |
| Bet button | Label | "BET" or "PLACE BET" |
| Bet stack | Chip values | "10", "50", "100", "500" |

---

## Skill 6: game-board-table

### Name
`game-board-table`

### Description (trigger text)
Build data tables and list views for a mobile game board in Figma. Use when the user asks to "create a leaderboard table", "build a bet history", "design a results table", "make a ranking list", "build a transaction log", or any request for tabular data display within a game board. Includes header row, sortable columns, and scrollable content.

### What It Builds
Data tables used in leaderboard, bet history, and results screens.

### Layout Pattern

```
+------------------------------------------+
|  COLUMN HEADERS                           |
|  [Player] [Bet] [Multiplier] [Payout]    |
+==========================================+
|  Row 1: avatar  $50   2.5x   $125.00    |
|  Row 2: avatar  $100  1.8x   $180.00    |
|  Row 3: avatar  $200  0.0x   -$200.00   |
|  Row 4: avatar  $75   3.2x   $240.00    |
|  ...scrollable...                         |
+------------------------------------------+
```

### Table Variants from Reference Boards

#### A. Leaderboard Table
- Columns: Rank, Player, Bet, Multiplier, Payout
- Sorted by payout (descending) or multiplier
- Top 3 highlighted with trophy/medal icons
- Alternating row backgrounds (subtle)

#### B. Bet History Table
- Columns: Time, Bet Amount, Multiplier, Result (Win/Loss), Payout
- Status color coding: green text for wins, red for losses
- Most recent at top
- Filter tabs above: All / Won / Lost

#### C. Settings Table (list-style)
- Each row: [Label]  [Control on right]
- Controls: Swither (toggle), CaretRight (navigation), value display
- No column headers

### Construction Steps

1. **Import Table component** from DS — this provides the container frame
2. **Create header row** — horizontal auto-layout with column labels
3. **Create data rows** — import Row or table row component, override text for each cell
4. **Add scrollable wrapper** — frame with `clipsContent: true` around rows
5. **Add filter tabs** (if needed) — Tab / 32px instances above table

### DS Components Used
- Table (`f5600da5f1240401a150078f2f6225723787b71b`)
- Row (`448aaa34c7ac9ee31a9cd038ac570b0a0289224e`)
- Tab / 32px (`b12f4fa3b88d1b6af3c0d7f55647489ce3722198`)
- Swither (`1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e`) — for settings-style lists
- Common icons (`748acb726a9508cc2cff135522e0ff73db826b62`) — Trophy, DotsThreeVertical

---

## Skill 7: game-board-jackpot

### Name
`game-board-jackpot`

### Description (trigger text)
Build jackpot display systems and win celebration screens for a mobile game board in Figma. Use when the user asks to "create a jackpot screen", "build win celebration", "design the big win popup", "make jackpot tiers", "build mini/major/mega jackpot indicators", or any request for jackpot-related UI elements. Includes jackpot tier badges, win animations, and prize grid layouts.

### What It Builds
Jackpot systems — the tier indicators, the slot/prize grid, and the win celebration overlays. Derived primarily from the Bumblebee board which has a fully built-out jackpot system.

### Jackpot Components (from Bumblebee)

#### jp-state — Jackpot Tier Indicator
A component set with 3 variants showing the current jackpot state:
- **Property 1=mini** — Smallest jackpot tier. Compact badge.
- **Property 1=major** — Medium tier. Larger badge with more elaborate styling.
- **Property 1=mega** — Largest jackpot. Most prominent, often animated/glowing.

Visual pattern: Each tier is a badge/emblem showing the tier name ("MINI", "MAJOR", "MEGA") with increasing visual prominence (size, effects, color intensity).

#### jp-win — Jackpot Win Celebration
A component set with 3 variants for the win screen overlay:
- **Property 1=jp-mini** — Mini jackpot win display
- **Property 1=jp-major** — Major jackpot win display
- **Property 1=jp-mega** — Mega jackpot win display

Visual pattern: Large centered celebration graphic with the won amount displayed prominently below. Gift boxes/treasure imagery. Each tier has increasing visual spectacle.

### Jackpot Screen Layout (from Bumblebee reference)

```
+------------------------------------------+
|           [jp-state badges row]           |
|  [MINI]      [MAJOR]       [MEGA]        |
+------------------------------------------+
|                                           |
|          PRIZE GRID (5 x 3)              |
|  +-----+-----+-----+-----+-----+        |
|  | sym | sym | sym | sym | sym |         |
|  +-----+-----+-----+-----+-----+        |
|  | sym | sym | sym | sym | sym |         |
|  +-----+-----+-----+-----+-----+        |
|  | sym | sym | sym | sym | sym |         |
|  +-----+-----+-----+-----+-----+        |
|                                           |
|            [SPIN / BET BUTTON]            |
+------------------------------------------+
```

- **Grid dimensions**: 5 columns x 3 rows of symbol cells
- **Cell size**: ~186 x 194 px each (from metadata: 186.38 x 193.88)
- **Grid total**: ~924 x 582 px
- **Symbols**: Theme-specific game symbols fill each cell (flowers in Bumblebee, could be anything)

### Win Overlay Layout

```
+------------------------------------------+
|  ░░░░ DARKENED BACKDROP ░░░░░░░░░░░░░░░░ |
|  ░░                                  ░░░ |
|  ░░     [jp-win component]           ░░░ |
|  ░░     showing tier + artwork       ░░░ |
|  ░░                                  ░░░ |
|  ░░        $ 335.23                  ░░░ |
|  ░░     (large win amount text)      ░░░ |
|  ░░                                  ░░░ |
|  ░░       [COLLECT BUTTON]           ░░░ |
|  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ |
+------------------------------------------+
```

### Construction Steps

1. **Jackpot indicators row**: Create horizontal frame, import jp-state variants (mini, major, mega), arrange with spacing
2. **Prize grid**: Create 5x3 grid frame using nested auto-layout rows, each cell ~186x194
3. **Win overlay**: Dark backdrop + jp-win instance + win amount text + Button CTA
4. **Wire together**: Compose into full screen with background, indicators at top, grid in center, button at bottom

### DS Components Used
- jp-state (local component in Bumblebee file — NOT in shared DS. Must be recreated per game or copied. Variant property: `Property 1` with values `mini`, `major`, `mega`)
- jp-win (local component in Bumblebee file — NOT in shared DS. Must be recreated per game or copied. Variant property: `Property 1` with values `jp-mini`, `jp-major`, `jp-mega`)
- Button (`37473b6da3943a3c37d3af6037a147271a5ab30b`)

> **Important**: jp-state and jp-win are **local components** defined only in the Bumblebee file, not in the Cruhslab shared design system library. For new game boards that need jackpot tiers, you must create equivalent component sets with the same variant structure (3 tiers: mini/major/mega) using theme-appropriate artwork.

---

## Skill 8: game-board-header

### Name
`game-board-header`

### Description (trigger text)
Build the game header and navigation bar for a mobile game board in Figma. Use when the user asks to "create the game header", "build the top nav bar", "design the navigation", "make the header with balance and settings", or any request for the persistent top bar that shows across all game screens. Includes logo, player balance, and utility buttons.

### What It Builds
The persistent top bar present on nearly every game screen.

### Layout Pattern

```
+---------------------------------------------------+
| [Logo] | [Menu ☰] | [$1,250.00] | [🔊] [⚙️]     |
+---------------------------------------------------+
```

### Variants

#### A. Main Game Header
- Logo (left) — game-specific
- Hamburger/menu icon (leads to menu screens)
- Balance display (center or right)
- Sound toggle button (Button icon)
- Settings button (Button icon)

#### B. Sub-Screen Header (Menu pages)
- Back arrow (left) — navigates back
- Screen title (center) — "Leaderboard", "My Bets", etc.
- Optional action button (right) — dots menu, filter

### Construction Steps

1. **Import Header component** from DS (runtime lookup)
2. **Override logo slot** with game-specific logo
3. **Override balance text** with placeholder amount
4. **Import Button icon / 32px** for utility buttons (sound, settings)
5. For sub-screen headers: override title text, swap left icon to back arrow

### DS Components Used
- Header (`4d3c237393adbeba5c135a536a1c6943b3ab8ade`)
- Button icon / 32px (`00503238aa9d7d4840c39aaf2b584132a9c88bd0`)
- Button icon / 40 px (`82664236e76f81598383e8e8db70ae079e8c4239`)
- Common icons (`748acb726a9508cc2cff135522e0ff73db826b62`) — menu, sound, settings icons

---

## Skill 9: game-board-assets

### Name
`game-board-assets`

### Description (trigger text)
Organize and place theme-specific game assets in a Figma game board. Use when the user asks to "set up game assets", "organize the asset kit", "create the game symbols", "place themed elements", "build the game's visual kit", or any request for organizing the unique visual elements of a specific game (characters, symbols, items, backgrounds). This skill provides the framework for how theme assets are structured and placed.

### What It Builds
The theme-specific asset organization. Every game board has unique visual elements. This skill defines how to organize them, not what they look like.

### Asset Categories (from reference boards)

#### 1. Game Symbols / Items
The interactive or collectible elements in the game.

| Category | Avia Aces Examples | Bumblebee Examples | Pattern |
|----------|-------------------|-------------------|---------|
| Primary symbols | Airplane variants | Flowers (6 colors: red, orange, baby blue, blue, pink, purple) | 4-8 symbols per game, each as its own image/component |
| Character | Airplane (single) | Bees (3 expressions/poses) | 1-3 characters, used in game area and celebrations |
| Special items | — | Net (catching tool), Flower bouquet | Optional special gameplay items |

#### 2. Backgrounds
Full-screen background images for different contexts:

| Context | What It Shows | Dimensions |
|---------|--------------|------------|
| Game background | Main gameplay scene | 375x812 (mobile) or 1440x1024 (desktop) |
| Menu background | Darker/blurred variant | Same as game |
| Start page background | Logo-optimized, more dramatic | Same |
| Desktop preview | Wide format for desktop/marketing | 2880x2048 |

#### 3. Logo Variants
| Variant | Usage | Notes |
|---------|-------|-------|
| Full logo | Splash screen, start page | Large, detailed, with effects |
| Small logo | Header, in-game | Compact, readable at small sizes |
| Preview logo | App store, marketing | With tagline or extra elements |

#### 4. Win/Celebration Assets
| Asset | Usage |
|-------|-------|
| Big Win graphic | Large win celebration overlay |
| Jackpot tier badges | Mini/Major/Mega indicators |
| Prize/gift imagery | Reward boxes, treasure |

### Asset Kit Page Structure
When building a new game board, organize assets on a dedicated page:

```
Page: "Asset Kit" or "Kit Content"
├── Logos/
│   ├── Full logo
│   ├── Small logo
│   └── Preview logo
├── Symbols/
│   ├── Symbol 1 (+ variants: normal, highlighted, dimmed)
│   ├── Symbol 2
│   └── ...
├── Characters/
│   ├── Character 1 (+ poses/expressions)
│   └── ...
├── Backgrounds/
│   ├── Game BG
│   ├── Menu BG
│   └── Desktop BG
├── Effects/
│   ├── Big Win
│   └── Jackpot badges
└── Misc/
    └── Special items
```

### Naming Convention
From the reference boards, assets follow this pattern:
- Backgrounds: `startpage_bg`, `preview_startpage_desktop`
- Flowers: `Untitled-1_0006_flower_red`, `flower_purple_polleneted`
- Logos: `bamblebee_logo_preview`, `bamblebee_bigwin_preview`

**Recommended convention for new games**:
- `{game-name}_bg_{context}` — e.g., `dragon_bg_game`, `dragon_bg_menu`
- `{game-name}_symbol_{name}` — e.g., `dragon_symbol_fire`, `dragon_symbol_gem`
- `{game-name}_character_{name}_{pose}` — e.g., `dragon_character_dragon_flying`
- `{game-name}_logo_{variant}` — e.g., `dragon_logo_full`, `dragon_logo_small`

---

## Cross-Skill Patterns

### Color & Theme System

Both reference boards use a dark theme with bright accents. The pattern:

| Token | Avia Aces | Bumblebee | Purpose |
|-------|-----------|-----------|---------|
| Background primary | Deep navy `~#1a1a3e` | Dark slate `~#2d2d4a` | Page/canvas background behind game |
| Surface | Semi-transparent dark `rgba(0,0,10,0.6)` | Semi-transparent dark | Betting panel, popups, table backgrounds |
| Text primary | White `#ffffff` | White `#ffffff` | All primary text |
| Text secondary | Light blue/gray `~#8888cc` | Light gray `~#aaaacc` | Labels, secondary info |
| Accent primary | Gold/Yellow `~#ffcc00` | Orange `~#ff8800` | Bet buttons, CTAs, highlights |
| Accent secondary | Cyan/Light blue `~#00ccff` | Green `~#44cc44` | Win indicators, selected states |
| Error/Loss | Red `~#ff4444` | Red `~#ff4444` | Loss indicators, error states |
| Success/Win | Green `~#44ff44` | Green `~#44ff44` | Win indicators |

> **Note**: These hex values are approximations from screenshots. Always check for design system variables first via `search_design_system` with queries like "color", "background", "primary", "accent".

### Typography Pattern

Both boards use similar type hierarchy:
- **Game logo**: Custom/themed font (unique per game)
- **Screen titles**: Bold sans-serif, ~20-24px
- **Body text**: Regular sans-serif, ~14-16px
- **Table data**: Monospace or tabular numbers, ~12-14px
- **Button labels**: Bold uppercase, ~14-16px
- **Balance/amounts**: Bold tabular figures, ~16-20px

### Spacing Constants

| Context | Value | Usage |
|---------|-------|-------|
| Screen padding | 16px | Left/right padding on mobile screens |
| Section gap | 12-16px | Between major sections (header, content, controls) |
| Component gap (tight) | 4-8px | Between related elements (icon + label) |
| Component gap (normal) | 8-12px | Between sibling components in a row |
| Table row height | ~44-48px | Standard row height in tables |
| Header height | ~56-64px | Top navigation bar |
| Betting panel height | ~120-160px | Bottom betting controls section |

### Mobile Screen Sizes

| Platform | Width x Height |
|----------|---------------|
| Mobile portrait (standard) | 375 x 812 |
| Mobile portrait (large) | 390 x 844 |
| Desktop landscape | 1440 x 1024 |
| Desktop marketing | 2880 x 2048 |

---

## Triggering Strategy

### How Each Skill Should Trigger

The skills are designed to be composable. A typical "build me a new game board" request should trigger **multiple skills in sequence**:

1. **game-board-assets** — First, organize the theme assets
2. **game-board-header** — Build the reusable header
3. **game-board-main** — Build the primary game screen (which calls game-board-betting internally)
4. **game-board-splash** — Build the loading/intro screen
5. **game-board-menu** — Build the secondary screens (which calls game-board-table internally)
6. **game-board-popup** — Build common popups
7. **game-board-jackpot** — Build jackpot system (if applicable)

### Trigger Phrases by Skill

| Skill | Primary Triggers | Secondary Triggers |
|-------|-----------------|-------------------|
| game-board-main | "game board", "main game screen", "gameplay view" | "crash game", "aviator", "slot screen", "game layout" |
| game-board-menu | "menu screen", "leaderboard", "my bets", "settings" | "game rules", "provably fair", "info screen" |
| game-board-splash | "loading screen", "splash", "intro", "start screen" | "welcome screen", "brand screen", "press to start" |
| game-board-popup | "popup", "modal", "dialog", "overlay" | "confirmation", "alert", "win popup", "cashout confirm" |
| game-board-betting | "betting controls", "bet panel", "wager section" | "bet slider", "bet input", "place bet UI" |
| game-board-table | "leaderboard table", "bet history", "results table" | "ranking", "scores", "transaction log" |
| game-board-jackpot | "jackpot", "big win", "prize grid", "slot grid" | "mini/major/mega", "win celebration", "reward tiers" |
| game-board-header | "game header", "top nav", "navigation bar" | "balance display", "header with settings" |
| game-board-assets | "asset kit", "game symbols", "theme elements" | "organize assets", "visual kit", "game artwork" |

### Skill Interaction Map

```
game-board-main
├── calls: game-board-header (for the top bar)
├── calls: game-board-betting (for bottom controls)
└── calls: game-board-assets (for theme content in game area)

game-board-menu
├── calls: game-board-header (sub-screen header variant)
├── calls: game-board-table (for leaderboard/bet history content)
└── standalone for: game rules, provably fair, settings

game-board-popup
└── standalone (overlays on top of any screen)

game-board-jackpot
├── calls: game-board-header (for top bar)
├── calls: game-board-assets (for symbol grid content)
└── calls: game-board-popup (for win celebration overlay)

game-board-splash
└── standalone (first screen, no dependencies)
```

---

## Implementation Priority

| Priority | Skill | Rationale |
|----------|-------|-----------|
| 1 | game-board-main | The central screen; most value, most complexity |
| 2 | game-board-betting | Core interaction; used by every game |
| 3 | game-board-header | Shared by all screens |
| 4 | game-board-menu | 5+ screen types in one skill |
| 5 | game-board-table | Reusable across menu screens |
| 6 | game-board-popup | Common overlay pattern |
| 7 | game-board-splash | Simple but essential |
| 8 | game-board-jackpot | Game-type-specific (not all games have jackpots) |
| 9 | game-board-assets | Framework/organizational (least code, most guidance) |

---

## Appendix: Full Component Key Reference

Quick-copy table of all **25 confirmed component keys** from the Cruhslab design system:

```
# Buttons & Actions
Button:               37473b6da3943a3c37d3af6037a147271a5ab30b
Button icon:          780abbe9084c51f4631734c5152d7d454de442be
Button icon / 40 px:  82664236e76f81598383e8e8db70ae079e8c4239
Button icon / 32px:   00503238aa9d7d4840c39aaf2b584132a9c88bd0
Bet button:           c396f2317b315f9a524f6c1d05db4e6d750b6f4f

# Betting & Input Controls
Bet slider:           5664c3b9b3fd396dc8bb2d8d3b54535fff845da0
Bet stack:            30f14fd215fb15ca0117192a3bc8f847f01d6843
Unput S (Input S):    47bfa3765a6f5b528c834680592126cb442490d0
Unput L (Input L):    25f2647b73f6f9ea7360740ff9a611d179b700f9
keyboaard:            fcaceed0327ffe6b58374bf4f7e40b778d7e9403

# Navigation & Tabs
Tab / 32px:           b12f4fa3b88d1b6af3c0d7f55647489ce3722198
Tab / 40px:           e8fba16a4dbcfcdef679d4b82f4c7f05109192c4
Tab line:             b926bc6084c42194af7e2477809bb45f41d0ab94
Tab line fill:        40dc9fc988e446ba214c660aebbc05f226b1bc26
Header:               4d3c237393adbeba5c135a536a1c6943b3ab8ade

# Containers & Overlays
Popup:                b22b514eea035af33c163df5cbd71652a6f2d249
Alert:                3ffe570922a484bb2e013ce0a89aa24853a463aa
Table:                f5600da5f1240401a150078f2f6225723787b71b
Row:                  448aaa34c7ac9ee31a9cd038ac570b0a0289224e

# Form & Settings
Settings input:       dc4c943d901d0dd9e533952ffb215f8e6bed7db7
Swither (Toggle):     1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e
Togl (Toggle alt):    2539bd82d99386fd31e945f535f60b5e6340ae9a
Switch cells:         882c98e20f8962e6f3ff94aaa5b4ea2016dca806
Drop (Dropdown):      0c94282b842f65e9c1e4b54869246f24f4141260

# Utility
Common (Icons):       748acb726a9508cc2cff135522e0ff73db826b62
Progress:             2085354bcffbe48f934ff972c81c3788d367aae5
```

Library key (for `includeLibraryKeys` filtering):
```
lk-65a310e82d99e2574d53aa7f8ceda223a68c78cbe4bcd11b38f3da66c9f251f4c2fb206576dc99aa89e3fe3c87a1bad1701710bc3d64886ccb38b5bd022be1b5
```

Variable collection key:
```
640727dc98dd3b96f3e037b7fd683c7cb5b5bbf8
```
