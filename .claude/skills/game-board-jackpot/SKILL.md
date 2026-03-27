---
name: game-board-jackpot
description: "Build jackpot systems for game boards in Figma — tier badges (mini/major/mega), 5x3 prize grid, win celebration overlay. Use for 'jackpot screen', 'slot grid', 'prize grid', 'jackpot tiers', 'mini major mega badges'. Self-sufficient."
---

# Game Board Jackpot

Build jackpot tier badges, a 5x3 prize symbol grid, and a win celebration overlay. Designed for desktop (1440x1024) slot/jackpot game screens.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values and the font name below are EXAMPLES** from the Avia Aces (indigo/blue) and Bumblebee (green/nature) reference boards. When building for a different game, derive all theme variables from the game's identity. The jackpot *structure* (badge layout, grid dimensions, cell alternation pattern, overlay layout) is the reusable pattern. The specific colors, font, tier accent colors (gold/silver/bronze are conventional but adjustable), and CTA palette should match the new game.

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

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
// Example values shown are from Avia Aces / Bumblebee reference boards
const FONT            = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example: { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const SURFACE         = /* derive */;  // Example: { r: 0.122, g: 0.137, b: 0.357 }
const TEXT_PRIMARY    = /* derive */;  // Example: { r: 1, g: 1, b: 1 }
const TEXT_SECONDARY  = /* derive */;  // Example: { r: 0.643, g: 0.737, b: 0.992 }
const PAGE_BG         = /* derive */;  // Example: { r: 0.094, g: 0.059, b: 0.502 }

// Tier badge accent colors (conventional, but adjustable per game):
const TIER_GOLD       = { r: 1, g: 0.843, b: 0 };       // mega tier
const TIER_SILVER     = { r: 0.753, g: 0.753, b: 0.753 }; // major tier
const TIER_BRONZE     = { r: 0.804, g: 0.498, b: 0.196 }; // mini tier

// CTA button palette — can be different from main game buttons
// Example below uses Bumblebee green for the collect button:
const CTA_FROM        = /* derive */;  // Example: { r: 0.400, g: 0.776, b: 0.110 }
const CTA_TO          = /* derive */;  // Example: { r: 0.035, g: 0.573, b: 0.314 }
const CTA_BORDER      = /* derive */;  // Example: { r: 0.082, g: 0.161, b: 0.039 }
const CTA_GLOW        = /* derive */;  // Example: { r: 0.235, g: 0.796, b: 0.498 }
const CTA_DEEP_SHADOW = /* derive */;  // Example: { r: 0.082, g: 0.161, b: 0.039 }
const CTA_HIGHLIGHT   = /* derive */;  // Example: { r: 0.816, g: 0.973, b: 0.671 }
const CTA_INNER_SHAD  = /* derive */;  // Example: { r: 0.196, g: 0.384, b: 0.071 }
const SHADOW_SOFT     = { r: 0.012, g: 0.016, b: 0.031 };  // near-black, usually universal
const ACCENT_FROM     = /* derive */;  // for glow effects — Example: { r: 0.082, g: 0.439, b: 0.937 }
```

## Tier Badge Construction (absolute positioning)

```js
await figma.loadFontAsync(FONT);

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
  badge.fills = [{ type: 'SOLID', color: SURFACE }];
  badge.strokeWeight = 2;
  badge.strokes = [{ type: 'SOLID', color: color }];
  badge.effects = [
    { type: 'DROP_SHADOW', color: { ...color, a: 0.4 }, offset: { x: 0, y: 0 }, radius: 24, visible: true }
  ];

  const nameText = figma.createText();
  nameText.characters = name.toUpperCase();
  nameText.fontSize = 14;
  nameText.fontName = FONT;
  nameText.fills = [{ type: 'SOLID', color: color }];
  nameText.textCase = "UPPER";
  nameText.textAlignHorizontal = "CENTER";
  badge.appendChild(nameText);

  const amountText = figma.createText();
  amountText.characters = amount;
  amountText.fontSize = 20;
  amountText.fontName = FONT;
  amountText.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
  amountText.textAlignHorizontal = "CENTER";
  badge.appendChild(amountText);

  badgeRow.appendChild(badge);
  return badge;
}

// Mini: 104x109 at x:142, y:34 — bronze tier
createBadge("Mini", "$12.50", TIER_BRONZE, 104, 109, 142, 34);

// Major: 149x123 at x:279, y:21 — silver tier
createBadge("Major", "$250.00", TIER_SILVER, 149, 123, 279, 21);

// Mega: 134x144 at x:462, y:0 — gold tier
createBadge("Mega", "$1,500.00", TIER_GOLD, 134, 144, 462, 0);

return { badgeRowId: badgeRow.id };
```

## Prize Grid Construction (5x3)

```js
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
    cell.strokes = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.1 } }]; // subtle border

    // Symbol placeholder (64x64)
    const symbol = figma.createFrame();
    symbol.name = "Symbol";
    symbol.resize(64, 64);
    symbol.cornerRadius = 8;
    symbol.fills = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.06 } }]; // SURFACE_SUBTLE
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
await figma.loadFontAsync(FONT);

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
artwork.fills = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.06 } }]; // SURFACE_SUBTLE
backdrop.appendChild(artwork);

// Win amount (88px)
const amount = figma.createText();
amount.characters = "$ 335.23";
amount.fontSize = 88;
amount.fontName = FONT;
amount.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
amount.textAlignHorizontal = "CENTER";
amount.effects = [
  { type: 'DROP_SHADOW', color: { ...ACCENT_FROM, a: 0.5 }, offset: { x: 0, y: 4 }, radius: 24, visible: true }
]; // Glow using accent color
backdrop.appendChild(amount);

// "YOU WON!" subtitle
const subtitle = figma.createText();
subtitle.characters = "YOU WON!";
subtitle.fontSize = 16;
subtitle.fontName = FONT;
subtitle.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
subtitle.textCase = "UPPER";
subtitle.textAlignHorizontal = "CENTER";
backdrop.appendChild(subtitle);

// Spacer
const midSpacer = figma.createFrame();
midSpacer.name = "spacer"; midSpacer.fills = [];
backdrop.appendChild(midSpacer);
midSpacer.layoutSizingHorizontal = "FILL";
midSpacer.resize(1, 24);

// Collect button (337.5x104, using CTA palette)
const collectBtn = figma.createFrame();
collectBtn.name = "Button Collect";
collectBtn.layoutMode = "HORIZONTAL";
collectBtn.primaryAxisAlignItems = "CENTER";
collectBtn.counterAxisAlignItems = "CENTER";
collectBtn.resize(337.5, 104);
collectBtn.cornerRadius = 12;
collectBtn.clipsContent = true;
collectBtn.strokeWeight = 2;
collectBtn.strokes = [{ type: 'SOLID', color: CTA_BORDER }];
collectBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { ...CTA_FROM, a: 1 } },
    { position: 1, color: { ...CTA_TO, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
// Shadow stack — structure is reusable, colors from CTA palette
collectBtn.effects = [
  { type: 'DROP_SHADOW', color: { ...SHADOW_SOFT, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { ...CTA_DEEP_SHADOW, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { ...CTA_GLOW, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { ...CTA_HIGHLIGHT, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { ...CTA_INNER_SHAD, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];
backdrop.appendChild(collectBtn);

const collectLabel = figma.createText();
collectLabel.characters = "COLLECT";
collectLabel.fontSize = 32;
collectLabel.fontName = FONT;
collectLabel.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
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

- **Tier badges** use absolute positioning (no auto-layout on the wrapper). Each badge has a colored stroke and matching glow shadow. Mini = TIER_BRONZE, Major = TIER_SILVER, Mega = TIER_GOLD. These colors are conventional but can be changed per game theme. The badges overlap vertically to create a cascading crown effect.
- **Prize grid** is a 5x3 matrix. Cell widths alternate between 186px and 182px (odd/even columns). Each cell is 194px tall, SURFACE-filled, with a subtle border. Symbol placeholders (64x64) sit centered inside each cell.
- **Win overlay** uses desktop dimensions (1440x1024). The collect button uses a separate CTA palette (can differ from main game buttons). Win amount is 88px TEXT_PRIMARY text with an accent glow shadow.
- Badge amounts are sample data; replace with actual jackpot pool values.
- Symbol placeholders in the grid should be replaced with actual game artwork (fruit, gems, characters, etc.).
