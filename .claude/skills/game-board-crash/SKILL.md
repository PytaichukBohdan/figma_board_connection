---
name: game-board-crash
description: Assemble a complete crash/aviator-style game board in Figma with mobile + desktop + onboarding sections. Use when asked to "build a crash game", "create an aviator-style game", or "new crash game board". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Board: Crash / Aviator

Build a full crash-style game board modeled after the **Avia Aces** reference (`HbStpqwXkiU8WCBGJyWfum`).

## When to use

- "build a crash game"
- "create an aviator-style game"
- "new crash game board"
- Any request for a multiplier/cash-out game with plane/rocket/vehicle theme

## Board structure

Create a page named **"DEV"** with 3 sections:

### Mobile section (375x812 frames)

| Frame name | Content |
|------------|---------|
| Default | Plane on runway, HUD header, bet controls at bottom |
| Menu | Settings overlay with toggle rows + navigation links |
| Type | Bet input with numeric keyboard visible |
| Start game | In-flight, multiplier running, cash-out available |
| Start game boost | In-flight with active boost button + progress bar |
| Leaderboard | Top X / Top Win tabs, period filters, data rows |
| Leaderboard | Alternate tab/filter state |
| My bets | Bet history grouped by date (Today, Yesterday) |
| Provably fair | Seed/hash fields, bet verification table |
| Game rule | Text content (RTP, calculating wins, rounds) |
| table | Paytable data |

### Desktop section (1024x768 frames)

| Frame name | Content |
|------------|---------|
| Desktop - 1 | Default with leaderboard sidebar open |
| Desktop - 2 | Menu overlay open |
| Desktop - 3 | Typing bet amount |
| Desktop - 4 | Game started, leaderboard collapsed |
| Desktop - 5 | In-flight, plane distant in sky |
| Leaderboard | Full-screen leaderboard |
| Leaderboard | Alternate state |
| My bets | Full-screen bet history |
| Provably fair | Full-screen provably fair |
| Game rules | Full-screen rules |

### Onboarding section

| Frame name | Size | Content |
|------------|------|---------|
| mOnboarding | 375x812 | Mobile splash screen |
| wOnboarding | 1024x768 | Web splash screen |
| mOnboarding | 375x812 | Mobile tutorial carousel |
| wOnboarding | 1024x768 | Web tutorial with "PRESS TO START" |

## Required workflow

**Step 1: Load prerequisites**

Load the `figma-use` skill before any `use_figma` call. This is mandatory.

**Step 2: Screenshot references**

Screenshot these nodes from the Avia Aces reference board to understand visual patterns:

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

**Step 3: Import DS components**

Search the CrashLab design system for these components and import them:

| Component | Component Key |
|-----------|--------------|
| Header | `4d3c237393adbeba5c135a536a1c6943b3ab8ade` |
| Button | `37473b6da3943a3c37d3af6037a147271a5ab30b` |
| Bet button | `c396f2317b315f9a524f6c1d05db4e6d750b6f4f` |
| Bet stack | `30f14fd215fb15ca0117192a3bc8f847f01d6843` |
| Switcher | `1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e` |
| Tab / 32px | `b12f4fa3b88d1b6af3c0d7f55647489ce3722198` |
| Input L | `25f2647b73f6f9ea7360740ff9a611d179b700f9` |
| Keyboard | `fcaceed0327ffe6b58374bf4f7e40b778d7e9403` |
| Popup | `b22b514eea035af33c163df5cbd71652a6f2d249` |
| Drop | `0c94282b842f65e9c1e4b54869246f24f4141260` |

**Step 4: Build section by section**

Build Mobile screens first, then Desktop, then Onboarding. Screenshot after each frame for QA.

## Composition rules

1. Every mobile screen starts with `Header` component at (0, 0), width 375, height 74
2. Content area sits below header at y=74, width 359, x=8 (8px side padding)
3. Bet controls panel anchored to bottom of mobile screens
4. Desktop screens: game viewport left (~70%), sidebar panel right (~30%)
5. Background components (`BG`, `mBG`) fill the entire frame behind all content
6. All text uses the game's custom font
7. Pass `skillNames="figma-use"` to every `use_figma` call
