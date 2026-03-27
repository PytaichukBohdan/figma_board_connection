---
name: game-board-button
description: "Build game-style CTA buttons in Figma from scratch — gradient fills, glow shadows, 3D depth effects. Use when creating a 'game button', 'bet button', 'CTA with glow', 'start button', '3D button', or any stylized action button for a mobile game UI. Two built-in palettes: indigo/blue (Avia Aces) and green/nature (Bumblebee). No DS imports needed."
---

# Game Board Button

Build premium game-style CTA buttons with gradient fills, glow shadows, and 3D inner depth. Fully parameterized — derive all colors from the game's theme.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values below are EXAMPLES** from the Avia Aces (indigo/blue) and Bumblebee (green/nature) reference boards. When building for a different game, replace every theme variable with colors derived from the game's identity. The button *structure* (dimensions, padding, shadow offsets/radii, gradient direction, border weight) is the reusable pattern. The specific color fills should match the new game.

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
//
// Example A (Avia Aces — indigo/blue aviation theme):
//   ACCENT_FROM     = { r: 0.082, g: 0.439, b: 0.937 }   // blue/600
//   ACCENT_TO       = { r: 0.267, g: 0.298, b: 0.906 }   // indigo/600
//   ACCENT_BORDER   = { r: 0.643, g: 0.737, b: 0.992 }   // indigo/300
//   ACCENT_GLOW     = { r: 0.502, g: 0.596, b: 0.976 }   // indigo/400
//   DEEP_SHADOW     = { r: 0.063, g: 0.165, b: 0.337 }   // blue/950
//   INNER_HIGHLIGHT = { r: 0.780, g: 0.843, b: 0.996 }   // indigo/200
//   INNER_SHADOW_C  = { r: 0.208, g: 0.220, b: 0.804 }   // indigo/700
//   TEXT_SHADOW     = #062c41
//
// Example B (Bumblebee — green/nature theme):
//   ACCENT_FROM     = { r: 0.400, g: 0.776, b: 0.110 }   // green-light/500
//   ACCENT_TO       = { r: 0.035, g: 0.573, b: 0.314 }   // green/600
//   ACCENT_BORDER   = { r: 0.082, g: 0.161, b: 0.039 }   // green-light/950
//   ACCENT_GLOW     = { r: 0.235, g: 0.796, b: 0.498 }   // green/400
//   DEEP_SHADOW     = { r: 0.082, g: 0.161, b: 0.039 }   // green-light/950
//   INNER_HIGHLIGHT = { r: 0.816, g: 0.973, b: 0.671 }   // green-light/200
//   INNER_SHADOW_C  = { r: 0.196, g: 0.384, b: 0.071 }   // green-light/800
//   TEXT_SHADOW     = #15290a

const FONT            = { family: "YOUR_GAME_FONT", style: "Regular" };
const ACCENT_FROM     = /* derive from game theme */;
const ACCENT_TO       = /* derive from game theme */;
const ACCENT_BORDER   = /* derive from game theme */;
const ACCENT_GLOW     = /* derive from game theme */;
const DEEP_SHADOW     = /* derive from game theme */;
const INNER_HIGHLIGHT = /* derive from game theme */;
const INNER_SHADOW_C  = /* derive from game theme */;
const SHADOW_SOFT     = { r: 0.012, g: 0.016, b: 0.031 };  // near-black, usually universal
const TEXT_PRIMARY    = { r: 1, g: 1, b: 1 };               // usually white for dark themes
const SURFACE         = /* derive from game theme */;        // for icon button backgrounds
```

## Standard Button (339x56)

```js
await figma.loadFontAsync(FONT);

const btn = figma.createFrame();
btn.name = "Button";
btn.layoutMode = "HORIZONTAL";
btn.primaryAxisAlignItems = "CENTER";
btn.counterAxisAlignItems = "CENTER";
btn.resize(339, 56);
btn.paddingLeft = 24; btn.paddingRight = 24;
btn.paddingTop = 16; btn.paddingBottom = 16;
btn.itemSpacing = 12;
btn.cornerRadius = 16;
btn.clipsContent = true;
btn.strokeWeight = 2;
btn.strokes = [{ type: 'SOLID', color: ACCENT_BORDER }];
btn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { ...ACCENT_FROM, a: 1 } },
    { position: 1, color: { ...ACCENT_TO, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
// Shadow stack — structure is reusable, colors come from theme
btn.effects = [
  { type: 'DROP_SHADOW', color: { ...SHADOW_SOFT, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { ...DEEP_SHADOW, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { ...ACCENT_GLOW, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { ...INNER_HIGHLIGHT, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { ...INNER_SHADOW_C, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];

const label = figma.createText();
label.characters = "START";
label.fontSize = 20;
label.fontName = FONT;
label.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
label.textCase = "UPPER";
btn.appendChild(label);

return { buttonId: btn.id };
```

## Large Button (337.5x104)

Same structure with these changes:

- `btn.resize(337.5, 104)` / `cornerRadius = 12`
- `label.fontSize = 32`
- All colors come from the same theme variables — just swap for your palette
- Glow radius stays 30

## Icon Button (48x48, square)

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
iconBtn.fills = [{ type: 'SOLID', color: SURFACE }];

// Place 24x24 icon frame inside
const iconPlaceholder = figma.createFrame();
iconPlaceholder.name = "Icon";
iconPlaceholder.resize(24, 24);
iconPlaceholder.fills = [];
iconBtn.appendChild(iconPlaceholder);

return { iconBtnId: iconBtn.id };
```

## Mini Button (32x32, +/- controls)

```js
const miniBtn = figma.createFrame();
miniBtn.name = "Mini Button";
miniBtn.resize(32, 32);
miniBtn.cornerRadius = 8;
miniBtn.layoutMode = "HORIZONTAL";
miniBtn.primaryAxisAlignItems = "CENTER";
miniBtn.counterAxisAlignItems = "CENTER";
miniBtn.clipsContent = true;
miniBtn.strokeWeight = 2;
miniBtn.strokes = [{ type: 'SOLID', color: ACCENT_BORDER }];
miniBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { ...ACCENT_FROM, a: 1 } },
    { position: 1, color: { ...ACCENT_TO, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
// Shadow stack — same structure, colors from theme
miniBtn.effects = [
  { type: 'DROP_SHADOW', color: { ...SHADOW_SOFT, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { ...DEEP_SHADOW, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { ...ACCENT_GLOW, a: 1 }, offset: { x: 0, y: 0 }, radius: 22, visible: true },
  { type: 'INNER_SHADOW', color: { ...INNER_HIGHLIGHT, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { ...INNER_SHADOW_C, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];

// Place 20x20 icon frame inside (Minus or Plus)
return { miniBtnId: miniBtn.id };
```

## Font

Use the game's brand font. The reference boards used **"Janda Manatee Solid Cyrillic"** Regular — a playful rounded sans-serif suited for casual games. Choose a font that matches your game's personality. Fallback: "Inter" Regular. All button text is uppercase, white.
