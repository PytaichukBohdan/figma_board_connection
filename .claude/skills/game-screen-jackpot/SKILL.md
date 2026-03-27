---
name: game-screen-jackpot
description: Build a 3-screen jackpot/bonus mini-game flow with start, grid, and win screens plus component sets. Use when asked to "add jackpot feature", "create bonus game", or "build jackpot flow". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Screen: Jackpot / Bonus Mini-Game

Build a 3-screen jackpot bonus game flow with local component sets.

## When to use

- "add jackpot feature"
- "create bonus game"
- "build jackpot flow"
- Any request for a pick-and-reveal bonus game with tiered prizes

## Screen flow (3 frames, each 1440x1024)

### Screen 1 -- Start

```text
+----------------------------------------------------------+
|                    [background image]                     |
|                                                          |
|                  JACKPOT                                  |
|                   GAME                                   |
|                                                          |
|           +------+  +--------+  +----+                   |
|           | gift |  |  GIFT  |  |gift|                   |
|           | sm   |  |  LRG   |  | sm |                   |
|           +------+  +--------+  +----+                   |
|                                                          |
|            [========= TAP TO PLAY =========]             |
+----------------------------------------------------------+
```

### Screen 2 -- Grid

```text
+----------------------------------------------------------+
|        [jp-mini]    [jp-major]    [jp-mega]               |
|                                                          |
|    +------+ +------+ +------+ +------+ +------+         |
|    |  ?   | |  ?   | |  ?   | |  ?   | |  ?   |         |
|    +------+ +------+ +------+ +------+ +------+         |
|    +------+ +------+ +------+ +------+ +------+         |
|    |  ?   | |  ?   | |  ?   | |  ?   | |  ?   |         |
|    +------+ +------+ +------+ +------+ +------+         |
|    +------+ +------+ +------+ +------+ +------+         |
|    |  ?   | |  ?   | |  ?   | |  ?   | |  ?   |         |
|    +------+ +------+ +------+ +------+ +------+         |
|                                                          |
|            [========= TAP TO OPEN =========]             |
+----------------------------------------------------------+
```

### Screen 3 -- Win

```text
+----------------------------------------------------------+
|              [dark overlay over grid]                    |
|                                                          |
|                  JACKPOT                                 |
|                   MEGA                                   |
|               +----------+                               |
|               |  opened  |                               |
|               | gift box |                               |
|               +----------+                               |
|                                                          |
|                $ 335.23                                  |
|                                                          |
|           [======== TAP CONTINUE ========]               |
+----------------------------------------------------------+
```

## Local component sets to create

**jp-state** (Property 1 = mini | major | mega):

| Variant | Visual |
|---------|--------|
| mini | Small green gift box, "MINI" text below |
| major | Medium teal/cyan gift box, "MAJOR" text below |
| mega | Large blue/red gift box, "MEGA" text below |

**jp-win** (Property 1 = jp-mini | jp-major | jp-mega):

| Variant | Visual |
|---------|--------|
| jp-mini | Gift box with "JACKPOT MINI" title above |
| jp-major | Gift box with "JACKPOT MAJOR" title above |
| jp-mega | Gift box with "JACKPOT MEGA" title above |

## DS components

Search by name via `search_design_system(query, fileKey)` where `fileKey` is the **target file**. Filter by `libraryName: "Cruhslab - design system"`. Full keys in `specs/crashlab-game-skills.md`.

- **Button** — CTA in all 3 screens

## Visual references

| What | File Key | Node ID |
|------|----------|---------|
| Jackpot start | `b8CiLoiovYYxbh3lg2T5dU` | `289:1904` |
| Jackpot grid | `b8CiLoiovYYxbh3lg2T5dU` | `289:2002` |
| Jackpot win | `b8CiLoiovYYxbh3lg2T5dU` | `289:2052` |
| jp-state variants | `b8CiLoiovYYxbh3lg2T5dU` | `289:2126` |
| jp-win variants | `b8CiLoiovYYxbh3lg2T5dU` | `289:2127` |

## Workflow

1. Load `figma-use` skill
2. Screenshot all 5 reference nodes above
3. Create the jp-state and jp-win component sets first
4. Build Screen 1 (start) with background, title, gift cluster, Button
5. Build Screen 2 (grid) with jp-state indicators, 5x3 hex grid, Button
6. Build Screen 3 (win) with dark overlay, jp-win instance, prize text, Button
7. Place screens side by side with ~40px gap
8. Screenshot each screen for QA
