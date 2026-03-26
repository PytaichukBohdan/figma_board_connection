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

| Component | Key | Placement |
|-----------|-----|-----------|
| Header | `4d3c237393adbeba5c135a536a1c6943b3ab8ade` | Top bar |
| Button | `37473b6da3943a3c37d3af6037a147271a5ab30b` | CTA ("START") |
| Bet button | `c396f2317b315f9a524f6c1d05db4e6d750b6f4f` | Quick-select (1, 2, 5, 10) |
| Bet stack | `30f14fd215fb15ca0117192a3bc8f847f01d6843` | Amount with +/- |
| Switcher | `1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e` | Auto play toggle |
| Tab / 32px | `b12f4fa3b88d1b6af3c0d7f55647489ce3722198` | Bet multiplier tabs |
| Input L | `25f2647b73f6f9ea7360740ff9a611d179b700f9` | Bet amount field |
| Button icon / 40px | `82664236e76f81598383e8e8db70ae079e8c4239` | +/- buttons |

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
