---
name: game-board-splash
description: "Build loading and splash screens for a mobile game board in Figma — logo, loading bar, press-to-start. Use for 'splash screen', 'loading screen', 'game intro', 'start screen', 'press to start'. Self-sufficient."
---

# Game Board Splash Screen

Build a full-screen loading/splash screen with a centered logo area, an animated-style loading bar, and optional "PRESS TO START" CTA. Two variants: Loading (with progress bar) and Start (with CTA button).

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Visual Structure

### Variant A: Loading

```
+---[375x812]----------------------------------+
|                                              |
|                                              |
|                                              |
|            +--[200x200]--+                   |
|            |   LOGO      |                   |
|            |  Placeholder |                   |
|            +--------------+                   |
|                                              |
|           +---[280x12]----+                  |
|           | [====     ]   |  Loading bar     |
|           +----------------+                  |
|                                              |
|              Loading 75%       14px text      |
|                                              |
|                                              |
+----------------------------------------------+
```

### Variant B: Press to Start

```
+---[375x812]----------------------------------+
|                                              |
|                                              |
|                                              |
|            +--[200x200]--+                   |
|            |   LOGO      |                   |
|            |  Placeholder |                   |
|            +--------------+                   |
|                                              |
|        [====PRESS TO START====]  56px CTA    |
|                                              |
|                                              |
+----------------------------------------------+
```

## Colors (Inline)

| Token | Figma 0-1 | Hex |
|-------|-----------|-----|
| Page background | `{ r: 0.094, g: 0.059, b: 0.502 }` | #180f80 |
| White | `{ r: 1, g: 1, b: 1 }` | #ffffff |
| Text secondary (indigo/300) | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Bar background (white/10) | `{ r: 1, g: 1, b: 1, a: 0.1 }` | — |
| Bar fill gradient from | `{ r: 0.082, g: 0.439, b: 0.937 }` | #1570ef |
| Bar fill gradient to | `{ r: 0.267, g: 0.298, b: 0.906 }` | #444ce7 |
| Bar glow | `{ r: 0.502, g: 0.596, b: 0.976 }` | #8098f9 |
| Button gradient from | `{ r: 0.082, g: 0.439, b: 0.937 }` | #1570ef |
| Button gradient to | `{ r: 0.267, g: 0.298, b: 0.906 }` | #444ce7 |
| Button border | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |

## Font

**"Janda Manatee Solid Cyrillic"**, Regular. Fallback: "Inter" Regular.

## Loading Bar (280x12, inline recipe)

```js
function createLoadingBar(progress) {
  // progress: 0.0 to 1.0
  const barWidth = 280;
  const barHeight = 12;

  const barBg = figma.createFrame();
  barBg.name = "Loading Bar";
  barBg.resize(barWidth, barHeight);
  barBg.cornerRadius = 6;
  barBg.clipsContent = true;
  barBg.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.1 }];

  // Fill bar
  const fill = figma.createRectangle();
  fill.name = "Fill";
  fill.resize(barWidth * progress, barHeight);
  fill.cornerRadius = 6;
  fill.fills = [{
    type: 'GRADIENT_LINEAR',
    gradientStops: [
      { position: 0, color: { r: 0.082, g: 0.439, b: 0.937, a: 1 } },
      { position: 1, color: { r: 0.267, g: 0.298, b: 0.906, a: 1 } }
    ],
    gradientTransform: [[1, 0, 0], [0, 1, 0]]
  }];
  fill.effects = [
    { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 0.6 }, offset: { x: 0, y: 0 }, radius: 12, visible: true }
  ];
  barBg.appendChild(fill);
  fill.x = 0; fill.y = 0;

  return barBg;
}
```

## CTA Button (280x56, inline recipe)

```js
function createStartButton() {
  const btn = figma.createFrame();
  btn.name = "Button CTA";
  btn.layoutMode = "HORIZONTAL";
  btn.primaryAxisAlignItems = "CENTER";
  btn.counterAxisAlignItems = "CENTER";
  btn.resize(280, 56);
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
  label.characters = "PRESS TO START";
  label.fontSize = 20;
  label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
  label.textCase = "UPPER";
  btn.appendChild(label);

  return btn;
}
```

## Full Splash Screen Construction (Variant A: Loading)

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const PAGE_BG = { r: 0.094, g: 0.059, b: 0.502 };
const WHITE = { r: 1, g: 1, b: 1 };
const SECONDARY = { r: 0.643, g: 0.737, b: 0.992 };

// ── Screen wrapper ──
const screen = figma.createFrame();
screen.name = "Splash / Loading";
screen.layoutMode = "VERTICAL";
screen.primaryAxisAlignItems = "CENTER";
screen.counterAxisAlignItems = "CENTER";
screen.resize(375, 812);
screen.itemSpacing = 24;
screen.clipsContent = true;
screen.fills = [{ type: 'SOLID', color: PAGE_BG }];

// ── Top spacer (pushes content to ~center) ──
const topSpacer = figma.createFrame();
topSpacer.name = "spacer-top";
topSpacer.fills = [];
screen.appendChild(topSpacer);
topSpacer.layoutSizingHorizontal = "FILL";
topSpacer.layoutSizingVertical = "FILL";

// ── Logo placeholder ──
const logo = figma.createFrame();
logo.name = "Logo Placeholder";
logo.resize(200, 200);
logo.cornerRadius = 24;
logo.fills = [{ type: 'SOLID', color: WHITE, opacity: 0.06 }];
screen.appendChild(logo);

// ── Loading bar ──
const bar = createLoadingBar(0.75);
screen.appendChild(bar);

// ── Progress text ──
const progressText = figma.createText();
progressText.characters = "Loading 75%";
progressText.fontSize = 14;
progressText.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
progressText.fills = [{ type: 'SOLID', color: SECONDARY }];
progressText.textAlignHorizontal = "CENTER";
screen.appendChild(progressText);

// ── Bottom spacer ──
const bottomSpacer = figma.createFrame();
bottomSpacer.name = "spacer-bottom";
bottomSpacer.fills = [];
screen.appendChild(bottomSpacer);
bottomSpacer.layoutSizingHorizontal = "FILL";
bottomSpacer.layoutSizingVertical = "FILL";

return { screenId: screen.id };
```

## Full Splash Screen Construction (Variant B: Press to Start)

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const PAGE_BG = { r: 0.094, g: 0.059, b: 0.502 };
const WHITE = { r: 1, g: 1, b: 1 };

// ── Screen wrapper ──
const screen = figma.createFrame();
screen.name = "Splash / Start";
screen.layoutMode = "VERTICAL";
screen.primaryAxisAlignItems = "CENTER";
screen.counterAxisAlignItems = "CENTER";
screen.resize(375, 812);
screen.itemSpacing = 32;
screen.clipsContent = true;
screen.fills = [{ type: 'SOLID', color: PAGE_BG }];

// Top spacer
const topSpacer = figma.createFrame();
topSpacer.name = "spacer-top";
topSpacer.fills = [];
screen.appendChild(topSpacer);
topSpacer.layoutSizingHorizontal = "FILL";
topSpacer.layoutSizingVertical = "FILL";

// Logo placeholder
const logo = figma.createFrame();
logo.name = "Logo Placeholder";
logo.resize(200, 200);
logo.cornerRadius = 24;
logo.fills = [{ type: 'SOLID', color: WHITE, opacity: 0.06 }];
screen.appendChild(logo);

// CTA button
const startBtn = createStartButton();
screen.appendChild(startBtn);

// Bottom spacer
const bottomSpacer = figma.createFrame();
bottomSpacer.name = "spacer-bottom";
bottomSpacer.fills = [];
screen.appendChild(bottomSpacer);
bottomSpacer.layoutSizingHorizontal = "FILL";
bottomSpacer.layoutSizingVertical = "FILL";

return { screenId: screen.id };
```

## Assembly Notes

- Screen is 375x812 (standard mobile), page background fill #180f80.
- Content is vertically centered using two flex-grow spacers (top and bottom).
- Logo placeholder: 200x200, cornerRadius 24, semi-transparent fill. Replace with actual game logo artwork.
- Loading bar: 280x12, cornerRadius 6, white/10 background. Fill bar is gradient (blue/600 to indigo/600) with a glow shadow.
- Progress percentage is shown as indigo/300 text, 14px, centered below the bar.
- CTA button uses the full Palette A shadow stack from game-board-button.
- Choose Variant A (loading) for initial load screens, Variant B (press to start) for idle/attract screens.
