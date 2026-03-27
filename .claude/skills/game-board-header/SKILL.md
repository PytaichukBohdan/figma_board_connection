---
name: game-board-header
description: "Build the game header/navigation bar for a mobile game board in Figma. Use when creating a 'game header', 'top nav for game', 'header with balance', 'game navigation bar', or the persistent bar showing logo, online count, balance, sound, and close. Self-sufficient — builds from primitives, no DS imports."
---

# Game Board Header

The persistent top bar on every game screen. Contains: [Sound Button] + [Info Stack] + [Close Button].

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values and the font name below are EXAMPLES** from the Avia Aces (indigo/blue) reference board. When building for a different game, derive SURFACE, TEXT_PRIMARY, TEXT_SECONDARY, and FONT from the game's theme. The header *structure* (dimensions, auto-layout, padding, spacing, stroke pattern) is the reusable pattern.

## Visual Structure

```
+---[375px]-----------------------------------------------+
| [Sound]  [Online: 1920  |  D***4 +200] [X Close] |  64px
|          [Balance:      |      $ 1000]            |
+----------------------------------------------------------+
```

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
// Example values shown are from Avia Aces (indigo/blue aviation theme)
const FONT      = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example: { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const SURFACE        = /* derive */;  // Example (Avia Aces): { r: 0.122, g: 0.137, b: 0.357 }
const TEXT_PRIMARY   = /* derive */;  // Example: { r: 1, g: 1, b: 1 } (white)
const TEXT_SECONDARY = /* derive */;  // Example (Avia Aces): { r: 0.643, g: 0.737, b: 0.992 }
// Divider: { ...TEXT_PRIMARY, a: 0.1 } — usually works universally
```

## Construction

```js
await figma.loadFontAsync(FONT);

// Header wrapper
const header = figma.createFrame();
header.name = "Header";
header.layoutMode = "HORIZONTAL";
header.counterAxisAlignItems = "CENTER";
header.resize(375, 64);
header.paddingLeft = 8; header.paddingRight = 8;
header.paddingTop = 8; header.paddingBottom = 8;
header.itemSpacing = 8;
header.fills = [];

// Left: Sound button (48x48)
const soundBtn = figma.createFrame();
soundBtn.name = "Sound Button";
soundBtn.layoutMode = "HORIZONTAL";
soundBtn.primaryAxisAlignItems = "CENTER";
soundBtn.counterAxisAlignItems = "CENTER";
soundBtn.resize(48, 48);
soundBtn.paddingLeft = 8; soundBtn.paddingRight = 8;
soundBtn.cornerRadius = 12;
soundBtn.fills = [{ type: 'SOLID', color: SURFACE }];
header.appendChild(soundBtn);
// Add speaker icon (24x24) inside soundBtn

// Center: Info stack (flex-grow)
const stack = figma.createFrame();
stack.name = "stack";
stack.layoutMode = "VERTICAL";
stack.cornerRadius = 12;
stack.fills = [{ type: 'SOLID', color: SURFACE }];
header.appendChild(stack);
stack.layoutSizingHorizontal = "FILL";

// Top row — online count + last win
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
onlineText.letterSpacing = { unit: "PIXELS", value: -0.56 };
onlineText.textCase = "UPPER";
topRow.appendChild(onlineText);

const lastWin = figma.createText();
lastWin.characters = "D***4 +200";
lastWin.fontSize = 14;
lastWin.fontName = FONT;
lastWin.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
lastWin.letterSpacing = { unit: "PIXELS", value: -0.56 };
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
balanceLabel.letterSpacing = { unit: "PIXELS", value: -0.56 };
balanceLabel.textCase = "UPPER";
bottomRow.appendChild(balanceLabel);

const balanceAmount = figma.createText();
balanceAmount.characters = "$ 1000";
balanceAmount.fontSize = 14;
balanceAmount.fontName = FONT;
balanceAmount.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
bottomRow.appendChild(balanceAmount);

// Right: Close button (48x48)
const closeBtn = figma.createFrame();
closeBtn.name = "Close Button";
closeBtn.layoutMode = "HORIZONTAL";
closeBtn.primaryAxisAlignItems = "CENTER";
closeBtn.counterAxisAlignItems = "CENTER";
closeBtn.resize(48, 48);
closeBtn.paddingLeft = 8; closeBtn.paddingRight = 8;
closeBtn.cornerRadius = 12;
closeBtn.fills = [{ type: 'SOLID', color: SURFACE }];
header.appendChild(closeBtn);
// Add X icon (24x24) inside closeBtn

return { headerId: header.id };
```

## Sub-Screen Header (for Leaderboard, My Bets, etc.)

```
+---[375px]----------------------------------+
| [< Back]     Screen Title      [...] |  48px
+---------------------------------------------+
```

Same structure but:
- Height: 48px
- Left: back arrow icon button (32x32)
- Center: title text (flex-grow, centered, 20px)
- Right: optional dots/filter button (32x32)
- Background: SURFACE solid fill
