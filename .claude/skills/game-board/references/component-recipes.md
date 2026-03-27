# Component Construction Recipes

Every component below can be built entirely from Figma primitives. Each recipe gives the exact Plugin API properties to set. Colors reference theme tokens from [theme-system.md](theme-system.md) — substitute the appropriate palette.

> **Convention**: All examples use Palette A (Avia Aces / indigo) tokens. For Palette B (Bumblebee / green), swap the color values per theme-system.md.

---

## Table of Contents
1. [Button (Primary CTA)](#button-primary-cta)
2. [Button Icon (Square Icon Button)](#button-icon)
3. [Header](#header)
4. [Row (Navigation)](#row-navigation)
5. [Row (Settings with Toggle)](#row-settings)
6. [Switcher (Toggle)](#switcher)
7. [Tab / 32px](#tab-32px)
8. [Input Large (Unput L)](#input-large)
9. [Input Small (Unput S)](#input-small)
10. [Switch Cells (Label + Toggle Row)](#switch-cells)
11. [Menu Panel](#menu-panel)
12. [Popup / Modal](#popup-modal)
13. [Jackpot Grid Cell](#jackpot-grid-cell)
14. [Jackpot Tier Badge](#jackpot-tier-badge)

---

## Button (Primary CTA)

The main action button used for "Start", "Place Bet", "Confirm", etc.

### Palette A (Avia Aces) — Indigo/Blue

```js
// Build a primary CTA button
const btn = figma.createFrame();
btn.name = "Button";
btn.layoutMode = "HORIZONTAL";
btn.primaryAxisAlignItems = "CENTER";
btn.counterAxisAlignItems = "CENTER";
btn.resize(339, 56);  // Standard: 339x56. Large (Bumblebee): 337.5x104
btn.paddingLeft = 24; btn.paddingRight = 24;
btn.paddingTop = 16; btn.paddingBottom = 16;
btn.itemSpacing = 12;
btn.cornerRadius = 16;  // Standard: 16. Large: 12
btn.clipsContent = true;
btn.strokeWeight = 2;
btn.strokes = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }]; // indigo/300

// Background gradient (absolute-positioned inner frame)
const bgFill = figma.createFrame();
bgFill.name = "bg-gradient";
bgFill.resize(339, 56);
bgFill.constraints = { horizontal: "STRETCH", vertical: "STRETCH" };
bgFill.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { r: 0.082, g: 0.439, b: 0.937, a: 1 } },  // blue/600
    { position: 1, color: { r: 0.267, g: 0.298, b: 0.906, a: 1 } }   // indigo/600
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]  // top to bottom
}];
btn.appendChild(bgFill);
// Position bgFill absolutely behind content (layoutPositioning = "ABSOLUTE")

// Button text
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
const label = figma.createText();
label.characters = "START";
label.fontSize = 20;
label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
label.textCase = "UPPER";
btn.appendChild(label);

// Shadows (apply to btn frame)
btn.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.012, g: 0.016, b: 0.031, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.063, g: 0.165, b: 0.337, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.780, g: 0.843, b: 0.996, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.208, g: 0.220, b: 0.804, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];

return { buttonId: btn.id };
```

### Palette B (Bumblebee) — Green

Same structure, swap these values:
- **Size**: 337.5 x 104 (larger)
- **Corner radius**: 12
- **Stroke color**: `{ r: 0.082, g: 0.161, b: 0.039 }` (green-light/950)
- **Gradient from**: `{ r: 0.400, g: 0.776, b: 0.110 }` (green-light/500)
- **Gradient to**: `{ r: 0.035, g: 0.573, b: 0.314 }` (green/600)
- **Font size**: 32px
- **Outer shadows**: warm tones (see theme-system.md Palette B)
- **Glow**: `{ r: 0.235, g: 0.796, b: 0.498 }` at 30px (green/400)
- **Inner highlight**: `{ r: 0.816, g: 0.973, b: 0.671 }` (green-light/200)
- **Inner shadow**: `{ r: 0.196, g: 0.384, b: 0.071 }` (green-light/800)

---

## Button Icon

Square icon button (48x48). Used in Header for sound toggle and close/menu.

```js
const iconBtn = figma.createFrame();
iconBtn.name = "Button Icon";
iconBtn.layoutMode = "HORIZONTAL";
iconBtn.primaryAxisAlignItems = "CENTER";
iconBtn.counterAxisAlignItems = "CENTER";
iconBtn.resize(48, 48);
iconBtn.paddingLeft = 8; iconBtn.paddingRight = 8;
iconBtn.paddingTop = 8; iconBtn.paddingBottom = 8;
iconBtn.cornerRadius = 12;
iconBtn.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }]; // SURFACE_PRIMARY

// Icon placeholder (24x24 frame or imported SVG)
const iconFrame = figma.createFrame();
iconFrame.name = "Icon";
iconFrame.resize(24, 24);
iconFrame.fills = []; // Transparent — place SVG/vector inside
iconBtn.appendChild(iconFrame);

return { iconBtnId: iconBtn.id };
```

---

## Header

The persistent top bar. Contains: [Sound Button] + [Info Stack] + [Close Button].

```js
const header = figma.createFrame();
header.name = "Header";
header.layoutMode = "HORIZONTAL";
header.counterAxisAlignItems = "CENTER";
header.resize(375, 64);
header.paddingLeft = 8; header.paddingRight = 8;
header.paddingTop = 8; header.paddingBottom = 8;
header.itemSpacing = 8;
header.fills = []; // Transparent — sits over game background

// Left: Sound button (48x48, see Button Icon recipe)
// ... create iconBtn as above ...
header.appendChild(soundBtn);

// Center: Info stack (flex-grow)
const stack = figma.createFrame();
stack.name = "stack";
stack.layoutMode = "VERTICAL";
stack.cornerRadius = 12;
stack.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }]; // SURFACE_PRIMARY
header.appendChild(stack);
stack.layoutSizingHorizontal = "FILL"; // AFTER appendChild

// Top row: Online count + last action
const topRow = figma.createFrame();
topRow.name = "top-row";
topRow.layoutMode = "HORIZONTAL";
topRow.primaryAxisAlignItems = "SPACE_BETWEEN";
topRow.counterAxisAlignItems = "CENTER";
topRow.paddingLeft = 8; topRow.paddingRight = 8;
topRow.paddingTop = 4; topRow.paddingBottom = 4;
topRow.fills = [];
topRow.strokes = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.1 } }]; // subtle border-bottom
topRow.strokesIncludedInLayout = true;
// Only bottom stroke:
topRow.strokeBottomWeight = 1;
topRow.strokeTopWeight = 0; topRow.strokeLeftWeight = 0; topRow.strokeRightWeight = 0;
stack.appendChild(topRow);
topRow.layoutSizingHorizontal = "FILL";

// "Online: 1920" text
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
const onlineText = figma.createText();
onlineText.characters = "Online: 1920";
onlineText.fontSize = 14;
onlineText.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
onlineText.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
onlineText.letterSpacing = { unit: "PIXELS", value: -0.56 };
onlineText.textCase = "UPPER";
topRow.appendChild(onlineText);

// Bottom row: Balance
const bottomRow = figma.createFrame();
bottomRow.name = "bottom-row";
bottomRow.layoutMode = "HORIZONTAL";
bottomRow.primaryAxisAlignItems = "SPACE_BETWEEN";
bottomRow.counterAxisAlignItems = "CENTER";
bottomRow.paddingLeft = 8; bottomRow.paddingRight = 8;
bottomRow.paddingTop = 4; bottomRow.paddingBottom = 4;
bottomRow.fills = [];
stack.appendChild(bottomRow);
bottomRow.layoutSizingHorizontal = "FILL";

const balanceLabel = figma.createText();
balanceLabel.characters = "Balance:";
balanceLabel.fontSize = 14;
balanceLabel.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
balanceLabel.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
balanceLabel.letterSpacing = { unit: "PIXELS", value: -0.56 };
balanceLabel.textCase = "UPPER";
bottomRow.appendChild(balanceLabel);

const balanceAmount = figma.createText();
balanceAmount.characters = "$ 1000";
balanceAmount.fontSize = 14;
balanceAmount.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
balanceAmount.fills = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }]; // TEXT_SECONDARY
balanceAmount.letterSpacing = { unit: "PIXELS", value: -0.56 };
bottomRow.appendChild(balanceAmount);

// Right: Close button (48x48, see Button Icon recipe)
// ... create iconBtn as above with X icon ...
header.appendChild(closeBtn);

return { headerId: header.id };
```

---

## Row (Navigation)

A menu row with icon + label + chevron. Used for "My Bets", "Leaderboard", "Game Rules", etc.

```js
const row = figma.createFrame();
row.name = "Row";
row.layoutMode = "HORIZONTAL";
row.counterAxisAlignItems = "CENTER";
row.resize(343, 48);  // Full width minus panel padding
row.paddingLeft = 12; row.paddingRight = 12;
row.paddingTop = 12; row.paddingBottom = 12;
row.itemSpacing = 8;
row.fills = []; // Transparent

// Left icon (20x20 placeholder)
const icon = figma.createFrame();
icon.name = "Icon";
icon.resize(20, 20);
icon.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }]; // White placeholder
row.appendChild(icon);

// Label text (flex-grow)
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
const label = figma.createText();
label.characters = "Leaderboard";
label.fontSize = 16;
label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
label.letterSpacing = { unit: "PIXELS", value: -0.64 };
label.textCase = "UPPER";
row.appendChild(label);
label.layoutSizingHorizontal = "FILL";

// Right chevron (20x20 placeholder — use CaretRight vector or ">")
const chevron = figma.createFrame();
chevron.name = "CaretRight";
chevron.resize(20, 20);
chevron.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.4 } }]; // Muted
row.appendChild(chevron);

return { rowId: row.id };
```

---

## Row (Settings)

A settings row with icon + label + toggle switcher. Used for "Music", "Game Sounds", "UI Sounds".

Same as navigation row but replace chevron with Switcher (see below).

---

## Switcher

On/off toggle.

```js
const switcher = figma.createFrame();
switcher.name = "Swither";
switcher.layoutMode = "HORIZONTAL";
switcher.counterAxisAlignItems = "CENTER";
switcher.resize(47, 24);
switcher.paddingLeft = 2; switcher.paddingRight = 2;
switcher.paddingTop = 2; switcher.paddingBottom = 2;
switcher.cornerRadius = 9999;  // Pill shape

// OFF state:
switcher.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.06 } }]; // white/6

// Knob
const knob = figma.createEllipse();
knob.name = "knob";
knob.resize(26, 20);
knob.cornerRadius = 32;
knob.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }]; // white
knob.effects = [
  { type: 'DROP_SHADOW', color: { r: 0, g: 0, b: 0, a: 0.3 }, offset: { x: 0, y: 1 }, radius: 2, visible: true }
];
switcher.appendChild(knob);

// For ON state, change:
//   switcher.fills → indigo/500 { r: 0.380, g: 0.447, b: 0.953 }
//   knob.fills → indigo/25 { r: 0.961, g: 0.973, b: 1.000 }
//   knob shadow → 0px 0px 3px indigo/200
//   switcher.primaryAxisAlignItems = "MAX"  (knob to right)

return { switcherId: switcher.id };
```

---

## Tab / 32px

Small tab button for quick-pick amounts or view switching.

```js
const tab = figma.createFrame();
tab.name = "Tab / 32px";
tab.layoutMode = "HORIZONTAL";
tab.primaryAxisAlignItems = "CENTER";
tab.counterAxisAlignItems = "CENTER";
tab.resize(80, 32);  // Width varies with content
tab.paddingLeft = 12; tab.paddingRight = 12;
tab.paddingTop = 14; tab.paddingBottom = 14;
tab.cornerRadius = 12;
tab.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.06 } }]; // white/6 (inactive)

await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
const tabLabel = figma.createText();
tabLabel.characters = "5";
tabLabel.fontSize = 18;
tabLabel.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
tabLabel.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
tabLabel.letterSpacing = { unit: "PIXELS", value: -0.72 };
tabLabel.textCase = "UPPER";
tabLabel.textAlignHorizontal = "CENTER";
tab.appendChild(tabLabel);

// For ACTIVE state: change fills to accent color or add border
// tab.fills = [{ type: 'SOLID', color: { r: 0.380, g: 0.447, b: 0.953, a: 0.2 } }];

return { tabId: tab.id };
```

---

## Input Large (Unput L)

Bet amount input with minus/plus buttons.

```js
const input = figma.createFrame();
input.name = "Unput L";
input.layoutMode = "HORIZONTAL";
input.primaryAxisAlignItems = "SPACE_BETWEEN";
input.counterAxisAlignItems = "CENTER";
input.resize(335, 48);
input.paddingLeft = 8; input.paddingRight = 8;
input.paddingTop = 8; input.paddingBottom = 8;
input.cornerRadius = 12;
input.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.05 } }]; // white/5
input.strokes = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.2 } }]; // white/20
input.strokeWeight = 1;

// Minus button (32x32 mini CTA — same gradient/shadow as main Button but smaller)
const minusBtn = figma.createFrame();
minusBtn.name = "Button close";
minusBtn.resize(32, 32);
minusBtn.cornerRadius = 8;
minusBtn.layoutMode = "HORIZONTAL";
minusBtn.primaryAxisAlignItems = "CENTER";
minusBtn.counterAxisAlignItems = "CENTER";
minusBtn.clipsContent = true;
minusBtn.strokeWeight = 2;
minusBtn.strokes = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }]; // indigo/300
minusBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { r: 0.082, g: 0.439, b: 0.937, a: 1 } }, // blue/600
    { position: 1, color: { r: 0.267, g: 0.298, b: 0.906, a: 1 } }  // indigo/600
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
minusBtn.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.012, g: 0.016, b: 0.031, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.063, g: 0.165, b: 0.337, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 1 }, offset: { x: 0, y: 0 }, radius: 22, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.780, g: 0.843, b: 0.996, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.208, g: 0.220, b: 0.804, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];
// Add "−" text or line inside
input.appendChild(minusBtn);

// Amount text (centered, flex-grow)
const amountText = figma.createText();
amountText.characters = "$ 50";
amountText.fontSize = 22;
amountText.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
amountText.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
amountText.letterSpacing = { unit: "PIXELS", value: -0.88 };
amountText.textCase = "UPPER";
amountText.textAlignHorizontal = "CENTER";
input.appendChild(amountText);
amountText.layoutSizingHorizontal = "FILL";

// Plus button (32x32, same as minus but with "+" icon)
// ... clone minusBtn pattern ...
input.appendChild(plusBtn);

return { inputId: input.id };
```

---

## Input Small (Unput S)

Smaller input field without +/- buttons. Used for bet amounts in compact layouts.

Same as Input Large but:
- Smaller size (width varies, height ~36-40px)
- No +/- buttons
- Just a text field with the amount
- Same fills/strokes as Input Large

---

## Switch Cells

Label + Toggle row. Used for "Auto play" and similar binary settings.

```js
const switchRow = figma.createFrame();
switchRow.name = "Switch cells";
switchRow.layoutMode = "HORIZONTAL";
switchRow.counterAxisAlignItems = "CENTER";
switchRow.resize(335, 32);
switchRow.itemSpacing = 12;
switchRow.fills = [];

const label = figma.createText();
label.characters = "Auto play";
label.fontSize = 14;
label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
label.letterSpacing = { unit: "PIXELS", value: -0.56 };
label.textCase = "UPPER";
switchRow.appendChild(label);
label.layoutSizingHorizontal = "FILL";

// Add Switcher (see Switcher recipe above)
switchRow.appendChild(switcher);

return { switchRowId: switchRow.id };
```

---

## Menu Panel

The main menu container. Rounded card with two sections: settings (toggles) and navigation (links).

```js
const panel = figma.createFrame();
panel.name = "Menu Panel";
panel.layoutMode = "VERTICAL";
panel.resize(359, 400); // Height is HUG
panel.layoutSizingVertical = "HUG";
panel.cornerRadius = 16;
panel.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }]; // SURFACE_PRIMARY
panel.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.082, g: 0.439, b: 0.937, a: 1 }, offset: { x: 0, y: 0 }, radius: 36, visible: true }
]; // Panel glow

// Title row
const titleRow = figma.createFrame();
titleRow.layoutMode = "HORIZONTAL";
titleRow.paddingLeft = 12; titleRow.paddingTop = 12;
titleRow.fills = [];
panel.appendChild(titleRow);
titleRow.layoutSizingHorizontal = "FILL";

const title = figma.createText();
title.characters = "MENU";
title.fontSize = 24;
title.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
title.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
title.letterSpacing = { unit: "PIXELS", value: -0.96 };
title.textCase = "UPPER";
titleRow.appendChild(title);

// Settings section (rows with toggles, bordered bottom)
const settingsSection = figma.createFrame();
settingsSection.name = "settings";
settingsSection.layoutMode = "VERTICAL";
settingsSection.paddingLeft = 8; settingsSection.paddingRight = 8;
settingsSection.paddingTop = 8; settingsSection.paddingBottom = 8;
settingsSection.fills = [];
settingsSection.strokes = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1, a: 0.06 } }];
settingsSection.strokeBottomWeight = 1;
settingsSection.strokeTopWeight = 0; settingsSection.strokeLeftWeight = 0; settingsSection.strokeRightWeight = 0;
panel.appendChild(settingsSection);
settingsSection.layoutSizingHorizontal = "FILL";
// Add Row (Settings) instances: Music, Game Sounds, UI Sounds

// Navigation section (rows with chevrons)
const navSection = figma.createFrame();
navSection.name = "navigation";
navSection.layoutMode = "VERTICAL";
navSection.paddingLeft = 8; navSection.paddingRight = 8;
navSection.paddingTop = 8; navSection.paddingBottom = 8;
navSection.fills = [];
panel.appendChild(navSection);
navSection.layoutSizingHorizontal = "FILL";
// Add Row (Navigation) instances: My Bets, Leaderboard, How to Play, Game Rules, Provably Fair

return { panelId: panel.id };
```

Menu items observed in Avia Aces (with icon names):
1. Music — MusicNotes icon + Switcher
2. Game Sounds — Joystick icon + Switcher
3. UI Sounds — Headphones icon + Switcher
4. My Bets — ClockCountdown icon + CaretRight
5. Leaderboard — Trophy icon + CaretRight
6. How to Play — Question icon + CaretRight
7. Game Rules — FileText icon + CaretRight
8. Provably Fair — ShieldCheck icon + CaretRight

---

## Popup / Modal

Dark backdrop with centered content card.

```js
// Backdrop
const backdrop = figma.createFrame();
backdrop.name = "Popup Backdrop";
backdrop.resize(375, 812);
backdrop.fills = [{ type: 'SOLID', color: { r: 0, g: 0, b: 0, a: 0.85 } }];
backdrop.layoutMode = "VERTICAL";
backdrop.primaryAxisAlignItems = "CENTER";
backdrop.counterAxisAlignItems = "CENTER";

// Content card
const card = figma.createFrame();
card.name = "Popup Card";
card.layoutMode = "VERTICAL";
card.resize(327, 300); // Height is HUG
card.layoutSizingVertical = "HUG";
card.cornerRadius = 16;
card.paddingLeft = 16; card.paddingRight = 16;
card.paddingTop = 16; card.paddingBottom = 16;
card.itemSpacing = 12;
card.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }]; // SURFACE_PRIMARY
card.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.082, g: 0.439, b: 0.937, a: 1 }, offset: { x: 0, y: 0 }, radius: 36, visible: true }
];
backdrop.appendChild(card);

// Add: title text, body text, action buttons inside card

return { backdropId: backdrop.id, cardId: card.id };
```

For win celebration overlay specifically:
- Backdrop opacity: 0.85
- Win amount: 88px font size, white, text-shadow
- Center the jp-win artwork above the amount text
- "Collect" / "Continue" button at bottom

---

## Jackpot Grid Cell

A single cell in the 5x3 jackpot/slot grid.

```js
const cell = figma.createFrame();
cell.name = "Grid Cell";
cell.resize(186, 194);  // Alternates: 186x194 and 182x194
cell.cornerRadius = 4;
cell.fills = [{ type: 'SOLID', color: { r: 0.8, g: 0.65, b: 0.2, a: 0.3 } }]; // Gold/amber tint placeholder
cell.strokes = [{ type: 'SOLID', color: { r: 0.8, g: 0.65, b: 0.2, a: 0.5 } }];
cell.strokeWeight = 1;

// Symbol image goes inside as a child (absolute positioned, fills cell)
// Or a "?" text for unrevealed state
```

Grid assembly: 3 rows (HORIZONTAL, no gap) x 5 cells each, stacked vertically.
Total grid: ~924 x 582 px.

---

## Jackpot Tier Badge

The mini/major/mega indicators. These are game-specific (artwork varies), but the layout pattern is:

```js
const badge = figma.createFrame();
badge.name = "jp-state";
badge.resize(134, 144);  // mega size. mini: 104x109, major: 149x123
badge.fills = []; // Transparent — artwork fills it

// Prize box image (absolute positioned, fills most of the frame)
// Label image at bottom (tier name: "MINI", "MAJOR", "MEGA")

// These are typically raster assets unique to each game theme.
// The skill provides the SIZE and POSITION pattern, not the artwork.
```

Tier badge row layout:
- Frame: 713 x 144
- 3 badges positioned absolutely (not auto-layout):
  - mini: left 142, top 34.4, size 104x109
  - major: left 279, top 20.7, size 149x123
  - mega: left 462, top 0, size 134x144
