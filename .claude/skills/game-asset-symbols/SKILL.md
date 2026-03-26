---
name: game-asset-symbols
description: Organize game symbols into a structured, consistent asset grid with full and compact variants. Use when asked to "organize game symbols", "create symbol sheet", or "lay out game icons". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Assets: Symbol Grid

Organize game symbols into clean, structured asset rows.

## When to use

- "organize game symbols"
- "create symbol sheet"
- "lay out game icons"
- "arrange game assets"
- Any request to structure game symbols on a Figma canvas

## Layout pattern

```text
+------------------------------------------------------------------+
| Frame: "Symbol Row" (full variants with stems/bases)             |
| +-------+ +-------+ +-------+ +-------+ +-------+ +-------+    |
| | sym_1 | | sym_2 | | sym_3 | | sym_4 | | sym_5 | | sym_6 |    |
| | red   | |orange | | blue  | | d.blue| | pink  | |purple |    |
| |       | |       | |       | |       | |       | |       |    |
| | stem  | | stem  | | stem  | | stem  | | stem  | | stem  |    |
| +-------+ +-------+ +-------+ +-------+ +-------+ +-------+    |
+------------------------------------------------------------------+

(Below, loose on canvas)

+-------+ +-------+ +-------+ +-------+ +-------+ +-------+
| sym_1 | | sym_2 | | sym_3 | | sym_4 | | sym_5 | | sym_6 |  <- Compact
| (head | | (head | | (head | | (head | | (head | | (head |     (no stems)
| only) | | only) | | only) | | only) | | only) | | only) |
+-------+ +-------+ +-------+ +-------+ +-------+ +-------+

+---------+  +----------+
| Special | | Special  |                                     <- Bonus symbols
| sym A   | | sym B    |
+---------+  +----------+

+-----+ +-----+ +-----+
| chr | | chr | | chr |                                      <- Character poses
| sm  | | med | | lg  |
+-----+ +-----+ +-----+
```

## Naming convention

Use `{theme}_{index}_{color}` format:
- `flower_red`, `flower_orange`, `flower_baby_blue`, `flower_blue`, `flower_pink`, `flower_purple`
- Or `Untitled-1_{index}_{descriptor}`

## Sizing rules

- Full symbol row: wrapped in a containing frame, ~1900px height
- Compact symbols: ~1500-1900px height, placed as loose rectangles
- Internal spacing: 200-300px between symbols within a row
- Stems row aligned to shared baseline

## Visual references

| What | File Key | Node ID |
|------|----------|---------|
| Symbol stems row | `b8CiLoiovYYxbh3lg2T5dU` | `93:823` |
| Full kit overview | `b8CiLoiovYYxbh3lg2T5dU` | `0:1` |
| Character (bee) | `b8CiLoiovYYxbh3lg2T5dU` | `61:7` |
| Net (special) | `b8CiLoiovYYxbh3lg2T5dU` | `90:3` |
| Bouquet (special) | `b8CiLoiovYYxbh3lg2T5dU` | `90:9` |

## Workflow

1. Load `figma-use` skill
2. Screenshot reference nodes to understand spacing and sizing
3. Place full symbols in a containing frame with consistent gaps
4. Place compact variants below as loose elements
5. Add special symbols and character poses in separate rows
6. Screenshot final layout for QA
