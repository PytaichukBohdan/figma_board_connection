---
name: game-board-table
description: "Build data tables for game boards in Figma — leaderboard rankings, bet history, with tab filters and scrollable rows. Use for 'leaderboard', 'bet history table', 'game rankings', 'results table'. Self-sufficient."
---

# Game Board Table

Build data tables for leaderboard rankings and bet history. Includes a tab bar for filtering, a column header row, and scrollable data rows with status colors.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values and the font name below are EXAMPLES** from the Avia Aces (indigo/blue) reference board. When building for a different game, derive all theme variables from the game's identity. The table *structure* (column layout, row heights, tab bar pattern, alternating row treatment) is the reusable pattern. The specific colors and font should match the new game. Win/loss status colors (green/red) are conventional and usually work across themes, but can be adjusted to match the game's palette.

## Visual Structure

```
+---[FILL width]------------------------------------+
| [All Bets] [My Bets] [Top]           Tab bar 32px |
+----------------------------------------------------|
|  #   Player    Bet     Multi   Payout   Header 32px|
+----------------------------------------------------|
|  1   A***n     $50     2.4x    $120.00     48px row|
|  2   B***k     $25     1.8x    $45.00      48px row|
|  3   C***e     $100    0.0x    -$100.00    48px row|
|  4   D***r     $75     3.1x    $232.50     48px row|
|  ...                                               |
+----------------------------------------------------+
```

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
// Example values shown are from Avia Aces (indigo/blue aviation theme)
const FONT           = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example: { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const SURFACE        = /* derive */;  // Example: { r: 0.122, g: 0.137, b: 0.357 }
const TEXT_PRIMARY   = /* derive */;  // Example: { r: 1, g: 1, b: 1 }
const TEXT_SECONDARY = /* derive */;  // Example: { r: 0.643, g: 0.737, b: 0.992 }
const TOGGLE_ON_BG   = /* derive */;  // Example: { r: 0.380, g: 0.447, b: 0.953 } — for active tab
// Status colors (conventional, but adjustable):
const WIN_COLOR      = { r: 0.2, g: 0.8, b: 0.3 };   // green for wins
const LOSS_COLOR     = { r: 0.9, g: 0.2, b: 0.2 };   // red for losses
// SURFACE_SUBTLE:   { ...TEXT_PRIMARY, a: 0.06 }
// ROW_ALT_BG:       { ...TEXT_PRIMARY, a: 0.03 }
```

## Column Definitions

### Leaderboard Table
| Column | Width | Align |
|--------|-------|-------|
| Rank (#) | 32px fixed | CENTER |
| Player | FILL | LEFT |
| Bet | 64px fixed | RIGHT |
| Multiplier | 56px fixed | RIGHT |
| Payout | 80px fixed | RIGHT |

### My Bets Table
| Column | Width | Align |
|--------|-------|-------|
| Time | 64px fixed | LEFT |
| Bet | FILL | LEFT |
| Multiplier | 56px fixed | RIGHT |
| Payout | 80px fixed | RIGHT |
| Status | 56px fixed | CENTER |

## Tab Bar (32px height, inline recipe)

```js
function createTabBar(tabs, activeIndex) {
  const bar = figma.createFrame();
  bar.name = "Tab Bar";
  bar.layoutMode = "HORIZONTAL";
  bar.itemSpacing = 4;
  bar.paddingLeft = 4; bar.paddingRight = 4;
  bar.paddingTop = 4; bar.paddingBottom = 4;
  bar.cornerRadius = 12;
  bar.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE

  tabs.forEach((tabName, i) => {
    const tab = figma.createFrame();
    tab.name = "Tab/" + tabName;
    tab.layoutMode = "HORIZONTAL";
    tab.primaryAxisAlignItems = "CENTER";
    tab.counterAxisAlignItems = "CENTER";
    tab.resize(1, 32);
    tab.cornerRadius = 10;
    tab.paddingLeft = 12; tab.paddingRight = 12;

    if (i === activeIndex) {
      tab.fills = [{ type: 'SOLID', color: TOGGLE_ON_BG }]; // active tab color
    } else {
      tab.fills = [];
    }

    bar.appendChild(tab);
    tab.layoutSizingHorizontal = "FILL";

    const lbl = figma.createText();
    lbl.characters = tabName;
    lbl.fontSize = 12;
    lbl.fontName = FONT;
    lbl.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
    lbl.textAlignHorizontal = "CENTER";
    tab.appendChild(lbl);
  });

  return bar;
}
```

## Header Row (32px, inline recipe)

```js
function createHeaderRow(columns) {
  const row = figma.createFrame();
  row.name = "Header Row";
  row.layoutMode = "HORIZONTAL";
  row.counterAxisAlignItems = "CENTER";
  row.resize(1, 32);
  row.paddingLeft = 8; row.paddingRight = 8;
  row.itemSpacing = 4;
  row.fills = [];
  row.strokes = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_DIVIDER
  row.strokeBottomWeight = 1;
  row.strokeTopWeight = 0; row.strokeLeftWeight = 0; row.strokeRightWeight = 0;

  columns.forEach(col => {
    const cell = figma.createText();
    cell.characters = col.label;
    cell.fontSize = 12;
    cell.fontName = FONT;
    cell.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
    cell.textAlignHorizontal = col.align || "LEFT";
    row.appendChild(cell);

    if (col.width === "FILL") {
      cell.layoutSizingHorizontal = "FILL";
    } else {
      cell.resize(col.width, cell.height);
    }
  });

  return row;
}
```

## Data Row (48px, inline recipe)

```js
function createDataRow(values, columns, isAlt, isWin) {
  const row = figma.createFrame();
  row.name = "Data Row";
  row.layoutMode = "HORIZONTAL";
  row.counterAxisAlignItems = "CENTER";
  row.resize(1, 48);
  row.paddingLeft = 8; row.paddingRight = 8;
  row.itemSpacing = 4;

  // Alternating background
  if (isAlt) {
    row.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.03 }]; // ROW_ALT_BG
  } else {
    row.fills = [];
  }

  values.forEach((val, i) => {
    const col = columns[i];
    const cell = figma.createText();
    cell.characters = String(val);
    cell.fontSize = 14;
    cell.fontName = FONT;
    cell.textAlignHorizontal = col.align || "LEFT";
    row.appendChild(cell);

    // Color logic: payout column uses win/loss colors
    if (col.label === "Payout" || col.label === "Status") {
      if (isWin) {
        cell.fills = [{ type: 'SOLID', color: WIN_COLOR }];
      } else {
        cell.fills = [{ type: 'SOLID', color: LOSS_COLOR }];
      }
    } else {
      cell.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
    }

    if (col.width === "FILL") {
      cell.layoutSizingHorizontal = "FILL";
    } else {
      cell.resize(col.width, cell.height);
    }
  });

  return row;
}
```

## Full Leaderboard Table Construction

```js
await figma.loadFontAsync(FONT);

// ── Table wrapper ──
const table = figma.createFrame();
table.name = "Leaderboard Table";
table.layoutMode = "VERTICAL";
table.resize(359, 1);
table.layoutSizingVertical = "HUG";
table.itemSpacing = 0;
table.fills = [];

// ── Tab bar ──
const tabs = createTabBar(["All Bets", "My Bets", "Top"], 0);
table.appendChild(tabs);
tabs.layoutSizingHorizontal = "FILL";

// ── Column definitions ──
const columns = [
  { label: "#",          width: 32,    align: "CENTER" },
  { label: "Player",     width: "FILL", align: "LEFT" },
  { label: "Bet",        width: 64,    align: "RIGHT" },
  { label: "Multi",      width: 56,    align: "RIGHT" },
  { label: "Payout",     width: 80,    align: "RIGHT" },
];

// ── Header row ──
const header = createHeaderRow(columns);
table.appendChild(header);
header.layoutSizingHorizontal = "FILL";

// ── Sample data rows ──
const sampleData = [
  { values: ["1", "A***n",  "$50",  "2.4x", "$120.00"],  win: true },
  { values: ["2", "B***k",  "$25",  "1.8x", "$45.00"],   win: true },
  { values: ["3", "C***e",  "$100", "0.0x", "-$100.00"], win: false },
  { values: ["4", "D***r",  "$75",  "3.1x", "$232.50"],  win: true },
  { values: ["5", "E***a",  "$10",  "0.0x", "-$10.00"],  win: false },
  { values: ["6", "F***y",  "$200", "1.2x", "$240.00"],  win: true },
  { values: ["7", "G***s",  "$30",  "4.5x", "$135.00"],  win: true },
  { values: ["8", "H***z",  "$15",  "0.0x", "-$15.00"],  win: false },
];

sampleData.forEach((row, i) => {
  const dataRow = createDataRow(row.values, columns, i % 2 === 1, row.win);
  table.appendChild(dataRow);
  dataRow.layoutSizingHorizontal = "FILL";
});

return { tableId: table.id };
```

## Assembly Notes

- Table is 359px wide (fits inside a 375px mobile frame with 8px horizontal margin).
- Tab bar: SURFACE_SUBTLE container with equal-width tabs. Active tab gets TOGGLE_ON_BG fill.
- Header row: 32px height, bottom border SURFACE_DIVIDER, column labels in TEXT_SECONDARY at 12px.
- Data rows: 48px height, alternating ROW_ALT_BG background, text at 14px.
- Payout/Status column uses conditional colors: WIN_COLOR for wins, LOSS_COLOR for losses.
- All other text is TEXT_PRIMARY.
- Columns use fixed widths except "Player" which is FILL (flex grow).
