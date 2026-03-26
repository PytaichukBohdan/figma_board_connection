---
name: game-screen-leaderboard
description: Build a leaderboard or bet history screen with tabbed filtering and data rows. Use when asked to "add leaderboard", "create leaderboard screen", or "build bet history". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Screen: Leaderboard & Bet History

Build data-driven screens for leaderboard rankings and bet history.

## When to use

- "add leaderboard"
- "create leaderboard screen"
- "build bet history"
- "add my bets screen"
- Any request for ranked player data or bet history display

## Anatomy -- Leaderboard (mobile, 375x812)

```text
+-----------------------------------------------+
| Header (with X close)                          |
+-----------------------------------------------+
| LEADERBOARD                                    |  <- Title
+-----------------------------------------------+
| [# LEADERBOARD]  [@ MY BETS]                  |  <- Primary tabs
+-----------------------------------------------+
| TOP X   TOP WIN                                |  <- Secondary filter
+-----------------------------------------------+
| [DAY]  |  WEEK  | MONTH  |  ALL               |  <- Tab/32px filters
+-----------------------------------------------+
| 14:31  [icon]  12   122.33X   1 231         >  |
| 14:31  [icon]  92   120.12X     411         >  |
| 14:31  [icon]  31   112.33X   123 231       >  |
| 14:31  [icon]  54   102.33X     912         >  |
| 14:31  [icon]  67    90.42X     421         >  |
| 14:31  [icon]  32    90.01X   4 411         >  |
+-----------------------------------------------+
```

## Anatomy -- My Bets variant

Same structure but rows grouped under date headers:

```text
| Today                                          |
| 14:31  [icon]  12   12.33X   123 231        >  |
| 14:31  [icon]  92   41.12X   101 012        >  |
|                                                |
| Yesterday                                      |
| 14:31  [icon]  31   12.33X    90 912        >  |
| ...                                            |
```

## Data row anatomy

```text
| time | character_icon | round_number | multiplier | win_amount | chevron |
```

## DS components

| Component | Key | Placement |
|-----------|-----|-----------|
| Header | `4d3c237393adbeba5c135a536a1c6943b3ab8ade` | Top bar with X close |
| Tab / 32px | `b12f4fa3b88d1b6af3c0d7f55647489ce3722198` | Period filters (DAY/WEEK/MONTH/ALL) |

## Visual references

| What | File Key | Node ID |
|------|----------|---------|
| Mobile leaderboard | `HbStpqwXkiU8WCBGJyWfum` | `146:1337` |
| Mobile leaderboard alt | `HbStpqwXkiU8WCBGJyWfum` | `146:1420` |
| Mobile my bets | `HbStpqwXkiU8WCBGJyWfum` | `271:2039` |
| Desktop leaderboard | `HbStpqwXkiU8WCBGJyWfum` | `271:2616` |

## Workflow

1. Load `figma-use` skill
2. Screenshot reference nodes
3. Import Header and Tab/32px from DS
4. Build frame with header, title, tabs, filter row, and 6+ data rows
5. For My Bets variant, add date group headers between row groups
6. Screenshot result for QA
