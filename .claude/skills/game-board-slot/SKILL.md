---
name: game-board-slot
description: Assemble a complete slot/bonus game asset kit board in Figma with organized symbols, jackpot flow, and component sets. Use when asked to "build a slot game kit", "create a bonus game board", or "new slot game assets". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Board: Slot / Bonus Kit

Build a full slot/bonus game asset kit modeled after the **Bumblebee (Bumble Road)** reference (`b8CiLoiovYYxbh3lg2T5dU`).

## When to use

- "build a slot game kit"
- "create a bonus game board"
- "new slot game assets"
- Any request for a symbol-based game with asset organization

## Board structure

Create a page named **"Kit Content"** with assets organized spatially:

```text
Row 1 (y~2200): Game logo + Big Win graphic + Character variants
Row 2 (y~4770): Full symbols with stems/bases in a frame (6 symbols)
Row 3 (y~7000): Compact symbols (no stems) + Special symbols
Row 4 (y~9800): Background assets
Row 5 (y~15700): Preview frames (start page, hex preview)

Jackpot screens (x~13700, y~8790):
  Frame: "jackpot" (start)    1440x1024
  Frame: "jackpot" (grid)     1440x1024
  Frame: "jackpot" (win)      1440x1024

Component sets (below jackpot):
  Frame: "jp-state"           ~3957x1189
  Frame: "jp-win"             ~4100x1511
```

## Required workflow

**Step 1: Load prerequisites**

Load the `figma-use` skill before any `use_figma` call.

**Step 2: Screenshot references**

| What | File Key | Node ID |
|------|----------|---------|
| Full kit overview | `b8CiLoiovYYxbh3lg2T5dU` | `0:1` |
| Game logo | `b8CiLoiovYYxbh3lg2T5dU` | `139:6` |
| Big Win graphic | `b8CiLoiovYYxbh3lg2T5dU` | `139:7` |
| Character (bee) | `b8CiLoiovYYxbh3lg2T5dU` | `61:7` |
| Symbol stems row | `b8CiLoiovYYxbh3lg2T5dU` | `93:823` |
| Background | `b8CiLoiovYYxbh3lg2T5dU` | `254:1799` |
| Start page preview | `b8CiLoiovYYxbh3lg2T5dU` | `254:1798` |
| Jackpot start | `b8CiLoiovYYxbh3lg2T5dU` | `289:1904` |
| Jackpot grid | `b8CiLoiovYYxbh3lg2T5dU` | `289:2002` |
| Jackpot win | `b8CiLoiovYYxbh3lg2T5dU` | `289:2052` |
| jp-state variants | `b8CiLoiovYYxbh3lg2T5dU` | `289:2126` |
| jp-win variants | `b8CiLoiovYYxbh3lg2T5dU` | `289:2127` |

**Step 3: Import DS components**

| Component | Component Key |
|-----------|--------------|
| Button | `37473b6da3943a3c37d3af6037a147271a5ab30b` |

**Step 4: Create local component sets**

**jp-state** (component set, Property 1):

| Variant | Description |
|---------|-------------|
| mini | Small green gift box with "MINI" text below |
| major | Medium teal gift box with "MAJOR" text below |
| mega | Large blue/red gift box with "MEGA" text below |

**jp-win** (component set, Property 1):

| Variant | Description |
|---------|-------------|
| jp-mini | Gift box with "JACKPOT MINI" title above |
| jp-major | Gift box with "JACKPOT MAJOR" title above |
| jp-mega | Gift box with "JACKPOT MEGA" title above |

**Step 5: Build jackpot screens**

Three 1440x1024 frames named "jackpot":
1. **Start** -- Background, title ("JACKPOT GAME"), 3 gift boxes clustered, Button ("TAP TO PLAY")
2. **Grid** -- jp-state indicators top, 5x3 hexagonal "?" cell grid, Button ("TAP TO OPEN")
3. **Win** -- Dark overlay, jp-win instance centered, prize amount text, Button ("TAP CONTINUE")

**Step 6: Organize asset rows**

Lay out symbols, characters, and backgrounds in organized rows with consistent spacing.

## Composition rules

1. Asset rows are loose rectangles on canvas, not wrapped in section frames
2. Symbol frames group related symbols with ~200-300px internal spacing
3. Jackpot screens placed side by side with ~40px gap
4. Component sets placed below jackpot screens
5. Each component variant is a separate symbol child inside the set frame
6. Button uses the DS component with different label text per screen
7. Pass `skillNames="figma-use"` to every `use_figma` call
