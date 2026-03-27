---
name: game-board-table
description: "Build data tables for game boards in Figma — leaderboard rankings, bet history, with tab filters and scrollable rows. Use for 'leaderboard', 'bet history table', 'game rankings', 'results table'. Self-sufficient."
---

# Game Board Table

Build data tables for leaderboard rankings and bet history. Includes a tab bar for filtering, a column header row, and scrollable data rows with status colors.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

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

## Colors (Inline)

| Token | Figma 0-1 | Hex |
|-------|-----------|-----|
| Surface (indigo/950) | `{ r: 0.122, g: 0.137, b: 0.357 }` | #1f235b |
| White | `{ r: 1, g: 1, b: 1 }` | #ffffff |
| Text secondary (indigo/300) | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Surface subtle (white/6) | `{ r: 1, g: 1, b: 1, a: 0.06 }` | — |
| Tab active bg | `{ r: 0.380, g: 0.447, b: 0.953 }` | #6172f3 |
| Win (green) | `{ r: 0.2, g: 0.8, b: 0.3 }` | #33cc4d |
| Loss (red) | `{ r: 0.9, g: 0.2, b: 0.2 }` | #e63333 |
| Row alt bg (white/3) | `{ r: 1, g: 1, b: 1, a: 0.03 }` | — |

## Font

**"Janda Manatee Solid Cyrillic"**, Regular. Fallback: "Inter" Regular.

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
  bar.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];

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
      tab.fills = [{ type: 'SOLID', color: { r: 0.380, g: 0.447, b: 0.953 } }];
    } else {
      tab.fills = [];
    }

    bar.appendChild(tab);
    tab.layoutSizingHorizontal = "FILL";

    const lbl = figma.createText();
    lbl.characters = tabName;
    lbl.fontSize = 12;
    lbl.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
    lbl.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
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
  row.strokes = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];
  row.strokeBottomWeight = 1;
  row.strokeTopWeight = 0; row.strokeLeftWeight = 0; row.strokeRightWeight = 0;

  columns.forEach(col => {
    const cell = figma.createText();
    cell.characters = col.label;
    cell.fontSize = 12;
    cell.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
    cell.fills = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
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
    row.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.03 }];
  } else {
    row.fills = [];
  }

  values.forEach((val, i) => {
    const col = columns[i];
    const cell = figma.createText();
    cell.characters = String(val);
    cell.fontSize = 14;
    cell.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
    cell.textAlignHorizontal = col.align || "LEFT";
    row.appendChild(cell);

    // Color logic: payout column uses win/loss colors
    if (col.label === "Payout" || col.label === "Status") {
      if (isWin) {
        cell.fills = [{ type: 'SOLID', color: { r: 0.2, g: 0.8, b: 0.3 } }]; // green
      } else {
        cell.fills = [{ type: 'SOLID', color: { r: 0.9, g: 0.2, b: 0.2 } }]; // red
      }
    } else {
      cell.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
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
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

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
- Tab bar: white/6 container with equal-width tabs. Active tab gets indigo/500 fill.
- Header row: 32px height, bottom border white/6, column labels in indigo/300 at 12px.
- Data rows: 48px height, alternating white/3 background, text at 14px.
- Payout/Status column uses conditional colors: green `{r:0.2,g:0.8,b:0.3}` for wins, red `{r:0.9,g:0.2,b:0.2}` for losses.
- All other text is white.
- Columns use fixed widths except "Player" which is FILL (flex grow).
