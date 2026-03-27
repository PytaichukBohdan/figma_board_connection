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

Search these by name via `search_design_system(query, fileKey)` where `fileKey` is the **target file** you are building in. Filter results by `libraryName: "Cruhslab - design system"`. Full component keys are in `specs/crashlab-game-skills.md`.

Components needed: **Header**, **Button**, **Bet button**, **Bet stack**, **Switcher**, **Tab / 32px**, **Input L**, **Keyboard**, **Popup**, **Drop**

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
