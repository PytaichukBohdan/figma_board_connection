---
name: game-screen-info
description: Build text-heavy informational screens like game rules and provably fair verification. Use when asked to "add game rules screen", "create provably fair page", or "build info screen". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Screen: Info / Rules / Provably Fair

Build text-heavy informational screens for game rules and provably fair verification.

## When to use

- "add game rules screen"
- "create provably fair page"
- "build info screen"
- "add how to play"
- Any request for text-content game information screens

## Variant 1: Game Rules

```text
+-----------------------------------------------+
| Header (with X close)                          |
+-----------------------------------------------+
| GAME RULES                                     |  <- Title
+-----------------------------------------------+
| Cricket crush game rules                       |  <- Subtitle
|                                                |
| Return to Player                               |  <- Bold section title
| The overall theoretical return to               |
| the player is 97%.                             |
|                                                |
| Calculating wins                               |  <- Bold section title
| The longer the plane stays in the air,         |
| the bigger the win in the current round        |
| can become...                                  |
|                                                |
| Rounds                                         |  <- Bold section title
| After one round ends, the next round           |
| starts in 5 seconds...                         |
+-----------------------------------------------+
```

## Variant 2: Provably Fair

```text
+-----------------------------------------------+
| Header (with X close)                          |
+-----------------------------------------------+
| PROVABLY FAIR                                  |  <- Title
+-----------------------------------------------+
| Your next seed              RANDOM v           |  <- Label + Drop (DS)
| +------------------------------------------+  |
| | BFD3D731A0822B8C                    [copy]|  |  <- Input L (DS)
| +------------------------------------------+  |
| Server's next hash                             |
| +------------------------------------------+  |
| | F216E04BC108C45152DA...              [copy]|  |  <- Input L (DS)
| +------------------------------------------+  |
+-----------------------------------------------+
| SELECT BET TO CHECK                            |  <- Section title
| 14:31  [icon]  12  12.33X  123 231          >  |
| 14:31  [icon]  92  41.12X  101 012          >  |
| ...                                            |
+-----------------------------------------------+
```

## DS components

Search by name via `search_design_system(query, fileKey)` where `fileKey` is the **target file**. Filter by `libraryName: "Cruhslab - design system"`. Full keys in `specs/crashlab-game-skills.md`.

- **Header** — Top bar with X
- **Input L** — Seed/hash fields
- **Drop** — "RANDOM" dropdown

## Visual references

| What | File Key | Node ID |
|------|----------|---------|
| Game rules | `HbStpqwXkiU8WCBGJyWfum` | `271:1937` |
| Provably fair | `HbStpqwXkiU8WCBGJyWfum` | `145:737` |
| Provably fair alt | `HbStpqwXkiU8WCBGJyWfum` | `212:1515` |

## Workflow

1. Load `figma-use` skill
2. Screenshot reference nodes for the desired variant
3. Import Header, Input L, Drop from DS
4. For Game Rules: build scrollable text content with section titles
5. For Provably Fair: build seed fields + bet verification table
6. Screenshot result for QA
