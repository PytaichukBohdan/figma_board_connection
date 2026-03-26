---
name: game-screen-menu
description: Build a game settings and navigation menu overlay with toggle rows and navigation links. Use when asked to "add game menu", "create settings screen", or "build menu overlay". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Screen: Menu / Settings Overlay

Build a settings and navigation menu that overlays the game screen.

## When to use

- "add game menu"
- "create settings screen"
- "build menu overlay"
- Any request for in-game settings with sound toggles and navigation

## Anatomy (mobile, 375x812)

```text
+-----------------------------------------------+
| Header (with X close button)                   |
+-----------------------------------------------+
| MENU                                           |  <- Title
+-----------------------------------------------+
| [music]       MUSIC                      [on]  |  <- Switcher toggle
| [speaker]     GAME SOUNDS                [on]  |
| [headphones]  UI SOUNDS                 [off]  |
+----- divider ------------------------------+
| [money]       MY BETS                       >   |  <- Nav row + chevron
| [trophy]      LEADERBOARD                  >   |
| [?]           HOW TO PLAY                  >   |
| [doc]         GAME RULES                   >   |
| [check]       PROVABLY FAIR                >   |
+-----------------------------------------------+
| Powered by [vortex logo]                       |  <- Footer
+-----------------------------------------------+
|         [bet controls visible below]           |
+-----------------------------------------------+
```

## Layout rules

- Settings group: 3 rows with icon + label + Switcher component
- Navigation group: 5 rows with icon + label + chevron (>)
- Groups separated by dividers
- Bet controls remain visible at bottom, underneath the menu panel
- Close button (X) replaces the hamburger icon in the header

## DS components

| Component | Key | Placement |
|-----------|-----|-----------|
| Header | `4d3c237393adbeba5c135a536a1c6943b3ab8ade` | Top bar with X |
| Switcher | `1f29c51eb8e5cd35dac5da6bfb9b64c6f280ad5e` | Music/Sounds toggles |

## Visual reference

| What | File Key | Node ID |
|------|----------|---------|
| Mobile menu | `HbStpqwXkiU8WCBGJyWfum` | `81:1340` |

## Workflow

1. Load `figma-use` skill
2. Screenshot reference node `81:1340`
3. Import Header and Switcher from DS
4. Build the overlay frame on top of the game screen
5. Add settings rows with toggles and navigation rows with chevrons
6. Screenshot result for QA
