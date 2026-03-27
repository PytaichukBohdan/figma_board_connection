---
name: game-board-splash
description: "Build loading and splash screens for a mobile game board in Figma — logo, loading bar, press-to-start. Use for 'splash screen', 'loading screen', 'game intro', 'start screen', 'press to start'. Self-sufficient."
---

# Game Board Splash Screen

Build a full-screen loading/splash screen with a centered logo area, an animated-style loading bar, and optional "PRESS TO START" CTA. Two variants: Loading (with progress bar) and Start (with CTA button).

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values and the font name below are EXAMPLES** from the Avia Aces (indigo/blue) reference board. When building for a different game, derive all theme variables from the game's identity. The splash screen *structure* (centered layout, spacer pattern, loading bar dimensions, CTA placement) is the reusable pattern. The specific colors, gradient, font, and background should match the new game.

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

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
// Example values shown are from Avia Aces (indigo/blue aviation theme)
const FONT            = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example: { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const PAGE_BG         = /* derive */;  // Example: { r: 0.094, g: 0.059, b: 0.502 }
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
  barBg.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.1 }]; // subtle bg

  // Fill bar — gradient from theme accent colors
  const fill = figma.createRectangle();
  fill.name = "Fill";
  fill.resize(barWidth * progress, barHeight);
  fill.cornerRadius = 6;
  fill.fills = [{
    type: 'GRADIENT_LINEAR',
    gradientStops: [
      { position: 0, color: { ...ACCENT_FROM, a: 1 } },
      { position: 1, color: { ...ACCENT_TO, a: 1 } }
    ],
    gradientTransform: [[1, 0, 0], [0, 1, 0]]
  }];
  fill.effects = [
    { type: 'DROP_SHADOW', color: { ...ACCENT_GLOW, a: 0.6 }, offset: { x: 0, y: 0 }, radius: 12, visible: true }
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
  btn.strokes = [{ type: 'SOLID', color: ACCENT_BORDER }];
  btn.fills = [{
    type: 'GRADIENT_LINEAR',
    gradientStops: [
      { position: 0, color: { ...ACCENT_FROM, a: 1 } },
      { position: 1, color: { ...ACCENT_TO, a: 1 } }
    ],
    gradientTransform: [[0, 1, 0], [-1, 0, 1]]
  }];
  // Shadow stack — structure is reusable, colors from theme
  btn.effects = [
    { type: 'DROP_SHADOW', color: { ...SHADOW_SOFT, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
    { type: 'DROP_SHADOW', color: { ...DEEP_SHADOW, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
    { type: 'DROP_SHADOW', color: { ...ACCENT_GLOW, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
    { type: 'INNER_SHADOW', color: { ...INNER_HIGHLIGHT, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
    { type: 'INNER_SHADOW', color: { ...INNER_SHADOW_C, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
  ];

  const label = figma.createText();
  label.characters = "PRESS TO START";
  label.fontSize = 20;
  label.fontName = FONT;
  label.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
  label.textCase = "UPPER";
  btn.appendChild(label);

  return btn;
}
```

## Full Splash Screen Construction (Variant A: Loading)

```js
await figma.loadFontAsync(FONT);

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
logo.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE
screen.appendChild(logo);

// ── Loading bar ──
const bar = createLoadingBar(0.75);
screen.appendChild(bar);

// ── Progress text ──
const progressText = figma.createText();
progressText.characters = "Loading 75%";
progressText.fontSize = 14;
progressText.fontName = FONT;
progressText.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
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
await figma.loadFontAsync(FONT);

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
logo.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE
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

- Screen is 375x812 (standard mobile), PAGE_BG fill.
- Content is vertically centered using two flex-grow spacers (top and bottom).
- Logo placeholder: 200x200, cornerRadius 24, semi-transparent fill. Replace with actual game logo artwork.
- Loading bar: 280x12, cornerRadius 6, subtle background. Fill bar uses accent gradient with a glow shadow.
- Progress percentage is shown as TEXT_SECONDARY text, 14px, centered below the bar.
- CTA button uses the full button shadow stack from theme.
- Choose Variant A (loading) for initial load screens, Variant B (press to start) for idle/attract screens.
