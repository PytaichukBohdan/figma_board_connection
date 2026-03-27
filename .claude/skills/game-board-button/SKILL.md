---
name: game-board-button
description: "Build game-style CTA buttons in Figma from scratch — gradient fills, glow shadows, 3D depth effects. Use when creating a 'game button', 'bet button', 'CTA with glow', 'start button', '3D button', or any stylized action button for a mobile game UI. Two built-in palettes: indigo/blue (Avia Aces) and green/nature (Bumblebee). No DS imports needed."
---

# Game Board Button

Build premium game-style CTA buttons with gradient fills, glow shadows, and 3D inner depth. Two palettes included.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Palette A: Indigo/Blue (Avia Aces)

| Token | Hex | Figma 0-1 |
|-------|-----|-----------|
| Gradient from | #1570ef | `{ r: 0.082, g: 0.439, b: 0.937 }` |
| Gradient to | #444ce7 | `{ r: 0.267, g: 0.298, b: 0.906 }` |
| Border | #a4bcfd | `{ r: 0.643, g: 0.737, b: 0.992 }` |
| Glow | #8098f9 | `{ r: 0.502, g: 0.596, b: 0.976 }` |
| Deep shadow | #102a56 | `{ r: 0.063, g: 0.165, b: 0.337 }` |
| Inner highlight | #c7d7fe | `{ r: 0.780, g: 0.843, b: 0.996 }` |
| Inner shadow | #3538cd | `{ r: 0.208, g: 0.220, b: 0.804 }` |
| Text shadow | #062c41 | — |

## Palette B: Green (Bumblebee)

| Token | Hex | Figma 0-1 |
|-------|-----|-----------|
| Gradient from | #66c61c | `{ r: 0.400, g: 0.776, b: 0.110 }` |
| Gradient to | #099250 | `{ r: 0.035, g: 0.573, b: 0.314 }` |
| Border | #15290a | `{ r: 0.082, g: 0.161, b: 0.039 }` |
| Glow | #3ccb7f | `{ r: 0.235, g: 0.796, b: 0.498 }` |
| Deep shadow | #15290a | `{ r: 0.082, g: 0.161, b: 0.039 }` |
| Inner highlight | #d0f8ab | `{ r: 0.816, g: 0.973, b: 0.671 }` |
| Inner shadow | #326212 | `{ r: 0.196, g: 0.384, b: 0.071 }` |
| Text shadow | #15290a | — |

## Standard Button (Palette A, 339x56)

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

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
btn.strokes = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
btn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { r: 0.082, g: 0.439, b: 0.937, a: 1 } },
    { position: 1, color: { r: 0.267, g: 0.298, b: 0.906, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
btn.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.012, g: 0.016, b: 0.031, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.063, g: 0.165, b: 0.337, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.780, g: 0.843, b: 0.996, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.208, g: 0.220, b: 0.804, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];

const label = figma.createText();
label.characters = "START";
label.fontSize = 20;
label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
label.textCase = "UPPER";
btn.appendChild(label);

return { buttonId: btn.id };
```

## Large Button (Palette B, 337.5x104)

Same structure with these changes:

- `btn.resize(337.5, 104)` / `cornerRadius = 12`
- Stroke: `{ r: 0.082, g: 0.161, b: 0.039 }` (green-light/950)
- Gradient: green-light/500 → green/600
- `label.fontSize = 32`
- Swap all shadow colors to Palette B values
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
iconBtn.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }];

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
miniBtn.strokes = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
miniBtn.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { r: 0.082, g: 0.439, b: 0.937, a: 1 } },
    { position: 1, color: { r: 0.267, g: 0.298, b: 0.906, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
miniBtn.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.012, g: 0.016, b: 0.031, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.063, g: 0.165, b: 0.337, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 1 }, offset: { x: 0, y: 0 }, radius: 22, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.780, g: 0.843, b: 0.996, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.208, g: 0.220, b: 0.804, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];

// Place 20x20 icon frame inside (Minus or Plus)
return { miniBtnId: miniBtn.id };
```

## Font

All buttons use **"Janda Manatee Solid Cyrillic"** Regular, uppercase, white. Fallback: "Inter" Regular.
