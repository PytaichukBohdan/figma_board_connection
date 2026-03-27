---
name: game-board-jackpot
description: "Build jackpot systems for game boards in Figma — tier badges (mini/major/mega), 5x3 prize grid, win celebration overlay. Use for 'jackpot screen', 'slot grid', 'prize grid', 'jackpot tiers', 'mini major mega badges'. Self-sufficient."
---

# Game Board Jackpot

Build jackpot tier badges, a 5x3 prize symbol grid, and a win celebration overlay. Designed for desktop (1440x1024) slot/jackpot game screens. Includes Bumblebee green palette for buttons.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Visual Structure

### Tier Badges (713x144)

```
+---[713px]---------------------------------------------+
|                                                        |  144px
|       +-[104x109]-+  +-[149x123]-+  +-[134x144]-+    |
|       |   MINI    |  |   MAJOR   |  |   MEGA    |    |
|       |  $12.50   |  |  $250.00  |  | $1,500.00 |    |
|       +-----------+  +-----------+  +-----------+    |
|       x:142,y:34     x:279,y:21     x:462,y:0        |
+-------------------------------------------------------+
```

### Prize Grid (5x3)

```
+---[5 columns]----------------------------------+
| [186x194] [182x194] [186x194] [182x194] [186x194] |  row 1
| [186x194] [182x194] [186x194] [182x194] [186x194] |  row 2
| [186x194] [182x194] [186x194] [182x194] [186x194] |  row 3
+----------------------------------------------------+
```

### Win Overlay

```
+---[1440x1024 backdrop, 85%]--------------------+
|                                                |
|         +--[200x200]--+                        |
|         | Win Artwork  |                        |
|         +--------------+                        |
|                                                |
|            $ 335.23              88px white     |
|             YOU WON!             16px secondary |
|                                                |
|      [========= COLLECT =========]  104px      |
|                                                |
+------------------------------------------------+
```

## Colors (Inline)

| Token | Figma 0-1 | Hex |
|-------|-----------|-----|
| Surface (indigo/950) | `{ r: 0.122, g: 0.137, b: 0.357 }` | #1f235b |
| White | `{ r: 1, g: 1, b: 1 }` | #ffffff |
| Text secondary (indigo/300) | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Page background | `{ r: 0.094, g: 0.059, b: 0.502 }` | #180f80 |
| Backdrop black | `{ r: 0, g: 0, b: 0, a: 0.85 }` | — |
| Grid cell dark | `{ r: 0.122, g: 0.137, b: 0.357 }` | #1f235b |
| Grid cell border (white/10) | `{ r: 1, g: 1, b: 1, a: 0.1 }` | — |
| Badge gold | `{ r: 1, g: 0.843, b: 0 }` | #ffd700 |
| Badge silver | `{ r: 0.753, g: 0.753, b: 0.753 }` | #c0c0c0 |
| Badge bronze | `{ r: 0.804, g: 0.498, b: 0.196 }` | #cd7f32 |

### Bumblebee Green Palette (for CTA buttons)

| Token | Figma 0-1 | Hex |
|-------|-----------|-----|
| Gradient from (green-light/500) | `{ r: 0.400, g: 0.776, b: 0.110 }` | #66c61c |
| Gradient to (green/600) | `{ r: 0.035, g: 0.573, b: 0.314 }` | #099250 |
| Border (green-light/950) | `{ r: 0.082, g: 0.161, b: 0.039 }` | #15290a |
| Glow (green/400) | `{ r: 0.235, g: 0.796, b: 0.498 }` | #3ccb7f |
| Deep shadow | `{ r: 0.082, g: 0.161, b: 0.039 }` | #15290a |
| Inner highlight | `{ r: 0.816, g: 0.973, b: 0.671 }` | #d0f8ab |
| Inner shadow | `{ r: 0.196, g: 0.384, b: 0.071 }` | #326212 |

## Font

**"Janda Manatee Solid Cyrillic"**, Regular. Fallback: "Inter" Regular.

## Tier Badge Construction (absolute positioning)

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const WHITE = { r: 1, g: 1, b: 1 };
const SECONDARY = { r: 0.643, g: 0.737, b: 0.992 };
const GOLD = { r: 1, g: 0.843, b: 0 };
const SILVER = { r: 0.753, g: 0.753, b: 0.753 };
const BRONZE = { r: 0.804, g: 0.498, b: 0.196 };

// ── Tier badges wrapper (absolute positioning, no auto-layout) ──
const badgeRow = figma.createFrame();
badgeRow.name = "Jackpot Tiers";
badgeRow.resize(713, 144);
badgeRow.fills = [];
badgeRow.layoutMode = "NONE"; // absolute positioning

function createBadge(name, amount, color, w, h, x, y) {
  const badge = figma.createFrame();
  badge.name = "Badge/" + name;
  badge.resize(w, h);
  badge.x = x; badge.y = y;
  badge.cornerRadius = 12;
  badge.layoutMode = "VERTICAL";
  badge.primaryAxisAlignItems = "CENTER";
  badge.counterAxisAlignItems = "CENTER";
  badge.itemSpacing = 4;
  badge.paddingTop = 8; badge.paddingBottom = 8;
  badge.paddingLeft = 8; badge.paddingRight = 8;
  badge.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }];
  badge.strokeWeight = 2;
  badge.strokes = [{ type: 'SOLID', color: color }];
  badge.effects = [
    { type: 'DROP_SHADOW', color: { ...color, a: 0.4 }, offset: { x: 0, y: 0 }, radius: 24, visible: true }
  ];

  const nameText = figma.createText();
  nameText.characters = name.toUpperCase();
  nameText.fontSize = 14;
  nameText.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  nameText.fills = [{ type: 'SOLID', color: color }];
  nameText.textCase = "UPPER";
  nameText.textAlignHorizontal = "CENTER";
  badge.appendChild(nameText);

  const amountText = figma.createText();
  amountText.characters = amount;
  amountText.fontSize = 20;
  amountText.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  amountText.fills = [{ type: 'SOLID', color: WHITE }];
  amountText.textAlignHorizontal = "CENTER";
  badge.appendChild(amountText);

  badgeRow.appendChild(badge);
  return badge;
}

// Mini: 104x109 at x:142, y:34 — bronze
createBadge("Mini", "$12.50", BRONZE, 104, 109, 142, 34);

// Major: 149x123 at x:279, y:21 — silver
createBadge("Major", "$250.00", SILVER, 149, 123, 279, 21);

// Mega: 134x144 at x:462, y:0 — gold
createBadge("Mega", "$1,500.00", GOLD, 134, 144, 462, 0);

return { badgeRowId: badgeRow.id };
```

## Prize Grid Construction (5x3)

```js
const SURFACE = { r: 0.122, g: 0.137, b: 0.357 };
const WHITE = { r: 1, g: 1, b: 1 };

// ── Grid wrapper (vertical stack of 3 rows) ──
const grid = figma.createFrame();
grid.name = "Prize Grid";
grid.layoutMode = "VERTICAL";
grid.itemSpacing = 0;
grid.fills = [];
grid.layoutSizingVertical = "HUG";

function createGridRow(rowIndex) {
  const row = figma.createFrame();
  row.name = "Grid Row " + (rowIndex + 1);
  row.layoutMode = "HORIZONTAL";
  row.itemSpacing = 0;
  row.fills = [];

  for (let col = 0; col < 5; col++) {
    // Alternating cell widths: 186, 182, 186, 182, 186
    const cellW = col % 2 === 0 ? 186 : 182;
    const cellH = 194;

    const cell = figma.createFrame();
    cell.name = "Cell " + rowIndex + "-" + col;
    cell.resize(cellW, cellH);
    cell.layoutMode = "VERTICAL";
    cell.primaryAxisAlignItems = "CENTER";
    cell.counterAxisAlignItems = "CENTER";
    cell.fills = [{ type: 'SOLID', color: SURFACE }];
    cell.strokeWeight = 1;
    cell.strokes = [{ type: 'SOLID', color: { ...WHITE, a: 0.1 } }];

    // Symbol placeholder (64x64)
    const symbol = figma.createFrame();
    symbol.name = "Symbol";
    symbol.resize(64, 64);
    symbol.cornerRadius = 8;
    symbol.fills = [{ type: 'SOLID', color: { ...WHITE, a: 0.06 } }];
    cell.appendChild(symbol);

    row.appendChild(cell);
  }

  return row;
}

// Build 3 rows
for (let r = 0; r < 3; r++) {
  const row = createGridRow(r);
  grid.appendChild(row);
}

return { gridId: grid.id };
```

## Win Overlay Construction (Desktop 1440x1024)

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const WHITE = { r: 1, g: 1, b: 1 };
const SECONDARY = { r: 0.643, g: 0.737, b: 0.992 };

// ── Backdrop ──
const backdrop = figma.createFrame();
backdrop.name = "Win Overlay";
backdrop.resize(1440, 1024);
backdrop.layoutMode = "VERTICAL";
backdrop.primaryAxisAlignItems = "CENTER";
backdrop.counterAxisAlignItems = "CENTER";
backdrop.itemSpacing = 16;
backdrop.fills = [{ type: 'SOLID', color: { r: 0, g: 0, b: 0 }, opacity: 0.85 }];
backdrop.clipsContent = true;

// Top spacer
const topSpacer = figma.createFrame();
topSpacer.name = "spacer"; topSpacer.fills = [];
backdrop.appendChild(topSpacer);
topSpacer.layoutSizingHorizontal = "FILL";
topSpacer.layoutSizingVertical = "FILL";

// Win artwork placeholder (200x200)
const artwork = figma.createFrame();
artwork.name = "Win Artwork";
artwork.resize(200, 200);
artwork.cornerRadius = 100;
artwork.fills = [{ type: 'SOLID', color: { ...WHITE, a: 0.06 } }];
backdrop.appendChild(artwork);

// Win amount (88px)
const amount = figma.createText();
amount.characters = "$ 335.23";
amount.fontSize = 88;
amount.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
amount.fills = [{ type: 'SOLID', color: WHITE }];
amount.textAlignHorizontal = "CENTER";
amount.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.082, g: 0.439, b: 0.937, a: 0.5 }, offset: { x: 0, y: 4 }, radius: 24, visible: true }
];
backdrop.appendChild(amount);

// "YOU WON!" subtitle
const subtitle = figma.createText();
subtitle.characters = "YOU WON!";
subtitle.fontSize = 16;
subtitle.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
subtitle.fills = [{ type: 'SOLID', color: SECONDARY }];
subtitle.textCase = "UPPER";
subtitle.textAlignHorizontal = "CENTER";
backdrop.appendChild(subtitle);

// Spacer
const midSpacer = figma.createFrame();
midSpacer.name = "spacer"; midSpacer.fills = [];
backdrop.appendChild(midSpacer);
midSpacer.layoutSizingHorizontal = "FILL";
midSpacer.resize(1, 24);

// Collect button (337.5x104, Bumblebee green)
const collectBtn = figma.createFrame();
collectBtn.name = "Button Collect";
collectBtn.layoutMode = "HORIZONTAL";
collectBtn.primaryAxisAlignItems = "CENTER";
collectBtn.counterAxisAlignItems = "CENTER";
collectBtn.resize(337.5, 104);
collectBtn.cornerRadius = 12;
collectBtn.clipsContent = true;
collectBtn.strokeWeight = 2;
collectBtn.strokes = [{ type: 'SOLID', color: { r: 0.082, g: 0.161, b: 0.039 } }];
collectBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { r: 0.400, g: 0.776, b: 0.110, a: 1 } },
    { position: 1, color: { r: 0.035, g: 0.573, b: 0.314, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
collectBtn.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.012, g: 0.016, b: 0.031, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.082, g: 0.161, b: 0.039, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.235, g: 0.796, b: 0.498, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.816, g: 0.973, b: 0.671, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.196, g: 0.384, b: 0.071, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];
backdrop.appendChild(collectBtn);

const collectLabel = figma.createText();
collectLabel.characters = "COLLECT";
collectLabel.fontSize = 32;
collectLabel.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
collectLabel.fills = [{ type: 'SOLID', color: WHITE }];
collectLabel.textCase = "UPPER";
collectBtn.appendChild(collectLabel);

// Bottom spacer
const bottomSpacer = figma.createFrame();
bottomSpacer.name = "spacer"; bottomSpacer.fills = [];
backdrop.appendChild(bottomSpacer);
bottomSpacer.layoutSizingHorizontal = "FILL";
bottomSpacer.layoutSizingVertical = "FILL";

return { overlayId: backdrop.id };
```

## Assembly Notes

- **Tier badges** use absolute positioning (no auto-layout on the wrapper). Each badge has a colored stroke and matching glow shadow. Mini = bronze, Major = silver, Mega = gold. The badges overlap vertically to create a cascading crown effect.
- **Prize grid** is a 5x3 matrix. Cell widths alternate between 186px and 182px (odd/even columns). Each cell is 194px tall, surface-filled, with a white/10 border. Symbol placeholders (64x64) sit centered inside each cell.
- **Win overlay** uses desktop dimensions (1440x1024). The collect button uses the Bumblebee green palette (337.5x104) with 32px font. Win amount is 88px white text with a blue glow shadow.
- Badge amounts are sample data; replace with actual jackpot pool values.
- Symbol placeholders in the grid should be replaced with actual game artwork (fruit, gems, characters, etc.).
