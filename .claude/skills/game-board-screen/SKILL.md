---
name: game-board-screen
description: "Build the main game screen wrapper for a mobile game board in Figma — full 375x812 frame with header, game area, and betting panel slots. Use for 'game screen layout', 'main game frame', 'gameplay screen structure'. This is the top-level container that composes header + game area + betting panel. Self-sufficient."
---

# Game Board Screen

The top-level wrapper frame for a mobile game board. A 375x812 VERTICAL auto-layout frame with three zones: Header slot (fixed), Game area (flex-grow, transparent), and Betting panel slot (fixed). This is the container that composes all other game-board skills into a complete screen.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values and the font name below are EXAMPLES** from the Avia Aces (indigo/blue) reference board. When building for a different game, derive all theme variables from the game's identity. The screen *structure* (three-zone vertical layout, flex-grow game area, HUG betting panel, header dimensions) is the reusable pattern. The specific colors, font, gradient, and shadow colors should match the new game.

## Visual Structure

```
+---[375x812]-------------------------------------+
|  +-- Header Slot (FILL width, HUG height) ----+ |
|  | [Sound] [Online | Balance] [Close]    64px  | |
|  +---------------------------------------------+ |
|                                                  |
|  +-- Game Area (FILL width, FILL height) ------+ |
|  |                                              | |
|  |          (flex-grow, transparent)             | |
|  |       Background shows through here          | |
|  |                                              | |
|  |      Game-specific content goes here         | |
|  |      (crash graph, slot reels, etc.)         | |
|  |                                              | |
|  +----------------------------------------------+ |
|                                                  |
|  +-- Betting Panel Slot (FILL width, HUG) -----+ |
|  | +-- inner card (12px pad, r16, surface) ---+ | |
|  | | [-] $10.00 [+]     Input L               | | |
|  | | [1] [2] [5] [10]   Tabs                  | | |
|  | | --------           Divider               | | |
|  | | Auto play  [=O]    Switch                | | |
|  | | [======BET======]  CTA 56px              | | |
|  | +------------------------------------------+ | |
|  +----------------------------------------------+ |
+--------------------------------------------------+
```

## Screen Dimensions

| Target | Width | Height |
|--------|-------|--------|
| Mobile (default) | 375 | 812 |
| Desktop | 1440 | 1024 |

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
// Example values shown are from Avia Aces (indigo/blue aviation theme)
const FONT            = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example: { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const PAGE_BG         = /* derive */;  // Example: { r: 0.094, g: 0.059, b: 0.502 }
const SURFACE         = /* derive */;  // Example: { r: 0.122, g: 0.137, b: 0.357 }
const TEXT_PRIMARY    = /* derive */;  // Example: { r: 1, g: 1, b: 1 }
const TEXT_SECONDARY  = /* derive */;  // Example: { r: 0.643, g: 0.737, b: 0.992 }
const ACCENT_FROM     = /* derive */;  // Example: { r: 0.082, g: 0.439, b: 0.937 }
const ACCENT_TO       = /* derive */;  // Example: { r: 0.267, g: 0.298, b: 0.906 }
const ACCENT_BORDER   = /* derive */;  // Example: { r: 0.643, g: 0.737, b: 0.992 }
const ACCENT_GLOW     = /* derive */;  // Example: { r: 0.502, g: 0.596, b: 0.976 }
const DEEP_SHADOW     = /* derive */;  // Example: { r: 0.063, g: 0.165, b: 0.337 }
const INNER_HIGHLIGHT = /* derive */;  // Example: { r: 0.780, g: 0.843, b: 0.996 }
const INNER_SHADOW_C  = /* derive */;  // Example: { r: 0.208, g: 0.220, b: 0.804 }
const SHADOW_SOFT     = { r: 0.012, g: 0.016, b: 0.031 };  // near-black, usually universal
```

## Full Screen Construction (Mobile 375x812)

```js
await figma.loadFontAsync(FONT);

// ══════════════════════════════════════════
// 1. SCREEN WRAPPER
// ══════════════════════════════════════════
const screen = figma.createFrame();
screen.name = "Game Screen";
screen.layoutMode = "VERTICAL";
screen.resize(375, 812);
screen.clipsContent = true;
screen.fills = [{ type: 'SOLID', color: PAGE_BG }];
screen.itemSpacing = 0;

// ══════════════════════════════════════════
// 2. HEADER SLOT (64px, FILL width)
// ══════════════════════════════════════════
const header = figma.createFrame();
header.name = "Header";
header.layoutMode = "HORIZONTAL";
header.counterAxisAlignItems = "CENTER";
header.resize(375, 64);
header.paddingLeft = 8; header.paddingRight = 8;
header.paddingTop = 8; header.paddingBottom = 8;
header.itemSpacing = 8;
header.fills = [];
screen.appendChild(header);
header.layoutSizingHorizontal = "FILL";

// Sound button (48x48)
const soundBtn = figma.createFrame();
soundBtn.name = "Sound Button";
soundBtn.layoutMode = "HORIZONTAL";
soundBtn.primaryAxisAlignItems = "CENTER";
soundBtn.counterAxisAlignItems = "CENTER";
soundBtn.resize(48, 48);
soundBtn.cornerRadius = 12;
soundBtn.fills = [{ type: 'SOLID', color: SURFACE }];
header.appendChild(soundBtn);

// Info stack (flex-grow)
const stack = figma.createFrame();
stack.name = "Info Stack";
stack.layoutMode = "VERTICAL";
stack.cornerRadius = 12;
stack.fills = [{ type: 'SOLID', color: SURFACE }];
header.appendChild(stack);
stack.layoutSizingHorizontal = "FILL";

// Top row — online + last win
const topRow = figma.createFrame();
topRow.name = "top-row";
topRow.layoutMode = "HORIZONTAL";
topRow.primaryAxisAlignItems = "SPACE_BETWEEN";
topRow.counterAxisAlignItems = "CENTER";
topRow.paddingLeft = 8; topRow.paddingRight = 8;
topRow.paddingTop = 4; topRow.paddingBottom = 4;
topRow.fills = [];
topRow.strokes = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.1 } }];
topRow.strokeBottomWeight = 1;
topRow.strokeTopWeight = 0; topRow.strokeLeftWeight = 0; topRow.strokeRightWeight = 0;
stack.appendChild(topRow);
topRow.layoutSizingHorizontal = "FILL";

const onlineText = figma.createText();
onlineText.characters = "Online: 1920";
onlineText.fontSize = 14;
onlineText.fontName = FONT;
onlineText.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
onlineText.textCase = "UPPER";
topRow.appendChild(onlineText);

const lastWin = figma.createText();
lastWin.characters = "D***4 +200";
lastWin.fontSize = 14;
lastWin.fontName = FONT;
lastWin.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
topRow.appendChild(lastWin);

// Bottom row — balance
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
balanceLabel.fontName = FONT;
balanceLabel.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
balanceLabel.textCase = "UPPER";
bottomRow.appendChild(balanceLabel);

const balanceAmount = figma.createText();
balanceAmount.characters = "$ 1000";
balanceAmount.fontSize = 14;
balanceAmount.fontName = FONT;
balanceAmount.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
bottomRow.appendChild(balanceAmount);

// Close button (48x48)
const closeBtn = figma.createFrame();
closeBtn.name = "Close Button";
closeBtn.layoutMode = "HORIZONTAL";
closeBtn.primaryAxisAlignItems = "CENTER";
closeBtn.counterAxisAlignItems = "CENTER";
closeBtn.resize(48, 48);
closeBtn.cornerRadius = 12;
closeBtn.fills = [{ type: 'SOLID', color: SURFACE }];
header.appendChild(closeBtn);

// ══════════════════════════════════════════
// 3. GAME AREA (flex-grow, transparent)
// ══════════════════════════════════════════
const gameArea = figma.createFrame();
gameArea.name = "Game Area";
gameArea.fills = []; // transparent — page background shows through
screen.appendChild(gameArea);
gameArea.layoutSizingHorizontal = "FILL";
gameArea.layoutSizingVertical = "FILL";

// ══════════════════════════════════════════
// 4. BETTING PANEL SLOT (FILL width, HUG)
// ══════════════════════════════════════════
const bettingOuter = figma.createFrame();
bettingOuter.name = "Betting Panel";
bettingOuter.layoutMode = "VERTICAL";
bettingOuter.paddingLeft = 8; bettingOuter.paddingRight = 8;
bettingOuter.paddingTop = 8; bettingOuter.paddingBottom = 8;
bettingOuter.fills = [];
screen.appendChild(bettingOuter);
bettingOuter.layoutSizingHorizontal = "FILL";
bettingOuter.layoutSizingVertical = "HUG";

const bettingInner = figma.createFrame();
bettingInner.name = "Betting Card";
bettingInner.layoutMode = "VERTICAL";
bettingInner.cornerRadius = 16;
bettingInner.paddingLeft = 12; bettingInner.paddingRight = 12;
bettingInner.paddingTop = 12; bettingInner.paddingBottom = 12;
bettingInner.itemSpacing = 12;
bettingInner.fills = [{ type: 'SOLID', color: SURFACE }];
bettingOuter.appendChild(bettingInner);
bettingInner.layoutSizingHorizontal = "FILL";

// -- Input Large (48px) --
const inputRow = figma.createFrame();
inputRow.name = "Input Large";
inputRow.layoutMode = "HORIZONTAL";
inputRow.counterAxisAlignItems = "CENTER";
inputRow.resize(1, 48);
inputRow.paddingLeft = 8; inputRow.paddingRight = 8;
inputRow.paddingTop = 8; inputRow.paddingBottom = 8;
inputRow.itemSpacing = 8;
inputRow.cornerRadius = 12;
inputRow.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE
bettingInner.appendChild(inputRow);
inputRow.layoutSizingHorizontal = "FILL";

// Minus button 32x32
const minusBtn = figma.createFrame();
minusBtn.name = "Minus";
minusBtn.resize(32, 32);
minusBtn.cornerRadius = 8;
minusBtn.layoutMode = "HORIZONTAL";
minusBtn.primaryAxisAlignItems = "CENTER";
minusBtn.counterAxisAlignItems = "CENTER";
minusBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { ...ACCENT_FROM, a: 1 } },
    { position: 1, color: { ...ACCENT_TO, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
minusBtn.strokes = [{ type: 'SOLID', color: TEXT_SECONDARY }];
minusBtn.strokeWeight = 2;
inputRow.appendChild(minusBtn);

// Amount text
const amountText = figma.createText();
amountText.characters = "$ 10.00";
amountText.fontSize = 20;
amountText.fontName = FONT;
amountText.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
amountText.textAlignHorizontal = "CENTER";
inputRow.appendChild(amountText);
amountText.layoutSizingHorizontal = "FILL";

// Plus button 32x32
const plusBtn = figma.createFrame();
plusBtn.name = "Plus";
plusBtn.resize(32, 32);
plusBtn.cornerRadius = 8;
plusBtn.layoutMode = "HORIZONTAL";
plusBtn.primaryAxisAlignItems = "CENTER";
plusBtn.counterAxisAlignItems = "CENTER";
plusBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { ...ACCENT_FROM, a: 1 } },
    { position: 1, color: { ...ACCENT_TO, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
plusBtn.strokes = [{ type: 'SOLID', color: TEXT_SECONDARY }];
plusBtn.strokeWeight = 2;
inputRow.appendChild(plusBtn);

// -- Tab row --
const tabRow = figma.createFrame();
tabRow.name = "Quick Picks";
tabRow.layoutMode = "HORIZONTAL";
tabRow.itemSpacing = 8;
tabRow.fills = [];
bettingInner.appendChild(tabRow);
tabRow.layoutSizingHorizontal = "FILL";

["1", "2", "5", "10"].forEach(val => {
  const tab = figma.createFrame();
  tab.name = "Tab/" + val;
  tab.layoutMode = "HORIZONTAL";
  tab.primaryAxisAlignItems = "CENTER";
  tab.counterAxisAlignItems = "CENTER";
  tab.resize(1, 32);
  tab.cornerRadius = 12;
  tab.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE
  tab.paddingLeft = 12; tab.paddingRight = 12;
  tabRow.appendChild(tab);
  tab.layoutSizingHorizontal = "FILL";

  const lbl = figma.createText();
  lbl.characters = val;
  lbl.fontSize = 14;
  lbl.fontName = FONT;
  lbl.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
  lbl.textAlignHorizontal = "CENTER";
  tab.appendChild(lbl);
});

// -- Divider --
const divider = figma.createFrame();
divider.name = "Divider";
divider.resize(1, 1);
divider.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_DIVIDER
bettingInner.appendChild(divider);
divider.layoutSizingHorizontal = "FILL";

// -- Auto play switch row --
const switchRow = figma.createFrame();
switchRow.name = "Switch Cells";
switchRow.layoutMode = "HORIZONTAL";
switchRow.counterAxisAlignItems = "CENTER";
switchRow.itemSpacing = 12;
switchRow.fills = [];
bettingInner.appendChild(switchRow);
switchRow.layoutSizingHorizontal = "FILL";

const autoLabel = figma.createText();
autoLabel.characters = "Auto play";
autoLabel.fontSize = 16;
autoLabel.fontName = FONT;
autoLabel.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
switchRow.appendChild(autoLabel);
autoLabel.layoutSizingHorizontal = "FILL";

// Switcher 47x24
const sw = figma.createFrame();
sw.name = "Switcher/Off";
sw.layoutMode = "HORIZONTAL";
sw.counterAxisAlignItems = "CENTER";
sw.resize(47, 24);
sw.cornerRadius = 12;
sw.paddingLeft = 2; sw.paddingRight = 2;
sw.paddingTop = 2; sw.paddingBottom = 2;
sw.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE
sw.primaryAxisAlignItems = "MIN";
switchRow.appendChild(sw);

const knob = figma.createFrame();
knob.name = "Knob";
knob.resize(26, 20);
knob.cornerRadius = 10;
knob.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
sw.appendChild(knob);

const swSpacer = figma.createFrame();
swSpacer.name = "spacer"; swSpacer.fills = [];
sw.appendChild(swSpacer);
swSpacer.layoutSizingHorizontal = "FILL";
swSpacer.resize(1, 20);

// -- CTA Button (56px) --
const cta = figma.createFrame();
cta.name = "Button CTA";
cta.layoutMode = "HORIZONTAL";
cta.primaryAxisAlignItems = "CENTER";
cta.counterAxisAlignItems = "CENTER";
cta.resize(1, 56);
cta.cornerRadius = 16;
cta.clipsContent = true;
cta.strokeWeight = 2;
cta.strokes = [{ type: 'SOLID', color: ACCENT_BORDER }];
cta.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { ...ACCENT_FROM, a: 1 } },
    { position: 1, color: { ...ACCENT_TO, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
// Shadow stack — structure is reusable, colors from theme
cta.effects = [
  { type: 'DROP_SHADOW', color: { ...SHADOW_SOFT, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { ...DEEP_SHADOW, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { ...ACCENT_GLOW, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { ...INNER_HIGHLIGHT, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { ...INNER_SHADOW_C, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];
bettingInner.appendChild(cta);
cta.layoutSizingHorizontal = "FILL";

const ctaLabel = figma.createText();
ctaLabel.characters = "BET";
ctaLabel.fontSize = 20;
ctaLabel.fontName = FONT;
ctaLabel.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
ctaLabel.textCase = "UPPER";
cta.appendChild(ctaLabel);

return { screenId: screen.id };
```

## Desktop Variant (1440x1024)

For desktop, change these values in the construction above:

```js
screen.resize(1440, 1024);
// Header stays at FILL width, adapts automatically
// Game area stays FILL/FILL
// Betting panel: consider side-panel layout instead of bottom
//   bettingOuter.resize(400, 1); placed beside game area in HORIZONTAL layout
```

## Composition with Other Skills

This screen is designed to be built as a single `use_figma` call. However, you can also compose it from separate skills:

1. Build the wrapper (this skill)
2. Replace the Header slot content using **game-board-header** skill
3. Replace the Betting Panel content using **game-board-betting** skill
4. Add game-specific content to the Game Area

Each sub-skill produces a standalone node that can be appended into the appropriate slot.

## Assembly Notes

- The screen wrapper is 375x812, VERTICAL auto-layout, `clipsContent = true`.
- PAGE_BG is the fill on the wrapper itself.
- Header: 64px fixed height, FILL width, transparent fill. Contains sound button (48x48, SURFACE fill), info stack (flex-grow, SURFACE fill), close button (48x48, SURFACE fill).
- Game Area: FILL width, FILL height (flex-grow). Transparent fill so the page background shows through. This is where game-specific content (crash graph, slot reels, character animations) goes.
- Betting Panel: FILL width, HUG height. Outer frame has 8px padding, inner card has SURFACE fill, 16px corner radius, 12px padding.
- The CTA button uses the full button shadow stack with colors from the theme.
- For desktop, resize the wrapper to 1440x1024 and consider restructuring to a side-panel layout.
