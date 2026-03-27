---
name: game-screen-hud
description: Build the standard game HUD with header bar, character/plane selection cards, bet controls, and action button. Supports mobile (375px) and desktop (1024px+) variants. Use when asked to "add game HUD", "build bet controls", or "create game header and controls". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Screen: HUD & Bet Controls

Build the standard game heads-up display with header, selection cards, and bet controls.

## When to use

- "add game HUD"
- "build bet controls"
- "create game header and controls"
- Any request for the main game interface chrome (header + controls)

## Anatomy -- Mobile (375px)

```text
+-----------------------------------------------+
| [sound] . ONLINE: 1920    D***4 +200      [=] |  <- Header (DS)
|         @ BALANCE:              $1000          |
+-----------------------------------------------+
| +----------+ +----------+ +----------+         |  <- Selection cards
| | [plane]  | | [plane]  | | [plane]  |         |
| | POWER    | | POWER    | | POWER    |         |
| | ======== | | ======== | | ======== |         |
| | STABILITY| | STABILITY| | STABILITY|         |
| | ======== | | ======== | | ======== |         |
| +----------+ +----------+ +----------+         |
|                                                |
|            [game viewport area]                |
|                                                |
| +--------------------------------------------+ |
| | [-]            $ 50                   [+]  | |  <- Bet stack (DS)
| +--------------------------------------------+ |
| |    1     |    2     |    5     |   10       | |  <- Bet button tabs
| +--------------------------------------------+ |
| | AUTO PLAY                            [off] | |  <- Switcher (DS)
| +--------------------------------------------+ |
| | ============== START ==================== | |  <- Button (DS)
| +--------------------------------------------+ |
+------------------------------------------------+
```

## Anatomy -- Desktop (1024px+)

```text
+----------------------------------------------------------+-----------+
| [sound]  . ONLINE: 1920    D***4 +200              [=]  |           |
|          @ BALANCE:              $1000                    |           |
+----------------------------------------------------------+ LEADER   |
|   +----------+ +----------+ +----------+                 | BOARD    |
|   | card 1   | | card 2   | | card 3   |                 |          |
|   +----------+ +----------+ +----------+                 | rows...  |
|                                                          |          |
|                [game viewport]                           |          |
|                                                          |          |
|         +------------------------------------+           +---------+
|         | [-]     $ 50                  [+]  |           |PROVABLY |
|         | 1  |  2  |  5  |  10               |           |FAIR   > |
|         | AUTO PLAY                   [off]  |           +---------+
|         | ========== START ==========        |
|         +------------------------------------+
+----------------------------------------------------------+-----------+
```

## DS components

Search by name via `search_design_system(query, fileKey)` where `fileKey` is the **target file**. Filter by `libraryName: "Cruhslab - design system"`. Full keys in `specs/crashlab-game-skills.md`.

- **Header** — Top bar
- **Button** — CTA ("START")
- **Bet button** — Quick-select (1, 2, 5, 10)
- **Bet stack** — Amount with +/-
- **Switcher** — Auto play toggle
- **Tab / 32px** — Bet multiplier tabs
- **Input L** — Bet amount field
- **Button icon / 40px** — +/- buttons

## Visual references

| What | File Key | Node ID |
|------|----------|---------|
| Mobile default | `HbStpqwXkiU8WCBGJyWfum` | `102:619` |
| Mobile with keyboard | `HbStpqwXkiU8WCBGJyWfum` | `102:735` |
| Desktop default | `HbStpqwXkiU8WCBGJyWfum` | `236:2110` |
| Desktop with sidebar | `HbStpqwXkiU8WCBGJyWfum` | `178:859` |

## Workflow

1. Load `figma-use` skill
2. Screenshot the reference nodes above
3. Search DS for components by name
4. Build header at top, selection cards below, viewport area in middle, bet controls at bottom
5. Screenshot result for QA
