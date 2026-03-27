---
name: game-board-popup
description: "Build popup overlays and modals for game boards in Figma — alert dialogs, win celebrations, confirmations with dark backdrop. Use for 'game popup', 'modal dialog', 'win popup', 'alert overlay', 'cashout confirmation'. Self-sufficient."
---

# Game Board Popup

Build popup overlays with a dark backdrop and centered card. Three variants: Alert (icon + title + message + OK), Confirmation (title + message + Cancel/Confirm), Win Celebration (amount + artwork + collect button).

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Visual Structure

### Alert Popup

```
+---[375x812 backdrop]---------------------------+
|            rgba(0,0,0,0.85)                    |
|                                                |
|     +---[327px card]---------------------+     |
|     |        [icon 48x48]                |     |
|     |                                    |     |
|     |        Connection Lost      24px   |     |
|     |                                    |     |
|     |   Please check your internet      |     |
|     |   connection and try again.  14px  |     |
|     |                                    |     |
|     |   [========= OK =========]  48px   |     |
|     +------------------------------------+     |
|                                                |
+------------------------------------------------+
```

### Confirmation Popup

```
+---[375x812 backdrop]---------------------------+
|            rgba(0,0,0,0.85)                    |
|                                                |
|     +---[327px card]---------------------+     |
|     |        Cash Out?            24px   |     |
|     |                                    |     |
|     |   Cash out at 2.4x for            |     |
|     |   $120.00 profit?           14px   |     |
|     |                                    |     |
|     |   [Cancel]    [Confirm]     48px   |     |
|     +------------------------------------+     |
|                                                |
+------------------------------------------------+
```

### Win Celebration

```
+---[375x812 backdrop]---------------------------+
|            rgba(0,0,0,0.85)                    |
|                                                |
|        +--[200x200]--+                         |
|        | Win Artwork  |                         |
|        | Placeholder  |                         |
|        +--------------+                         |
|                                                |
|           $ 335.23              88px white      |
|             YOU WON!            16px secondary  |
|                                                |
|     [=========COLLECT=========]  56px CTA      |
|                                                |
+------------------------------------------------+
```

## Colors (Inline)

| Token | Figma 0-1 | Hex |
|-------|-----------|-----|
| Backdrop | `{ r: 0, g: 0, b: 0, a: 0.85 }` | rgba(0,0,0,0.85) |
| Surface (indigo/950) | `{ r: 0.122, g: 0.137, b: 0.357 }` | #1f235b |
| White | `{ r: 1, g: 1, b: 1 }` | #ffffff |
| Text secondary (indigo/300) | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Glow (blue/600) | `{ r: 0.082, g: 0.439, b: 0.937 }` | #1570ef |
| Button gradient from | `{ r: 0.082, g: 0.439, b: 0.937 }` | #1570ef |
| Button gradient to | `{ r: 0.267, g: 0.298, b: 0.906 }` | #444ce7 |
| Button border | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Cancel button bg (white/6) | `{ r: 1, g: 1, b: 1, a: 0.06 }` | — |
| Cancel button border (white/20) | `{ r: 1, g: 1, b: 1, a: 0.2 }` | — |
| Win gold (for accent) | `{ r: 1, g: 0.843, b: 0 }` | #ffd700 |

## Font

**"Janda Manatee Solid Cyrillic"**, Regular. Fallback: "Inter" Regular.

## Backdrop (375x812, inline recipe)

```js
function createBackdrop() {
  const backdrop = figma.createFrame();
  backdrop.name = "Backdrop";
  backdrop.resize(375, 812);
  backdrop.layoutMode = "VERTICAL";
  backdrop.primaryAxisAlignItems = "CENTER";
  backdrop.counterAxisAlignItems = "CENTER";
  backdrop.fills = [{ type: 'SOLID', color: { r: 0, g: 0, b: 0 }, opacity: 0.85 }];
  backdrop.clipsContent = true;
  return backdrop;
}
```

## Card (327px wide, inline recipe)

```js
function createCard() {
  const card = figma.createFrame();
  card.name = "Popup Card";
  card.layoutMode = "VERTICAL";
  card.primaryAxisAlignItems = "CENTER";
  card.counterAxisAlignItems = "CENTER";
  card.resize(327, 1);
  card.layoutSizingVertical = "HUG";
  card.cornerRadius = 16;
  card.paddingLeft = 24; card.paddingRight = 24;
  card.paddingTop = 24; card.paddingBottom = 24;
  card.itemSpacing = 16;
  card.fills = [{ type: 'SOLID', color: { r: 0.122, g: 0.137, b: 0.357 } }];
  card.effects = [
    { type: 'DROP_SHADOW', color: { r: 0.082, g: 0.439, b: 0.937, a: 0.4 }, offset: { x: 0, y: 0 }, radius: 36, visible: true }
  ];
  return card;
}
```

## Primary Button (FILL width x 48px, inline recipe)

```js
function createPrimaryButton(text, height) {
  height = height || 48;
  const btn = figma.createFrame();
  btn.name = "Button Primary";
  btn.layoutMode = "HORIZONTAL";
  btn.primaryAxisAlignItems = "CENTER";
  btn.counterAxisAlignItems = "CENTER";
  btn.resize(1, height);
  btn.cornerRadius = 12;
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
  label.characters = text;
  label.fontSize = 16;
  label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
  label.textCase = "UPPER";
  btn.appendChild(label);

  return btn;
}
```

## Secondary Button (Cancel, FILL width x 48px, inline recipe)

```js
function createSecondaryButton(text) {
  const btn = figma.createFrame();
  btn.name = "Button Secondary";
  btn.layoutMode = "HORIZONTAL";
  btn.primaryAxisAlignItems = "CENTER";
  btn.counterAxisAlignItems = "CENTER";
  btn.resize(1, 48);
  btn.cornerRadius = 12;
  btn.strokeWeight = 1;
  btn.strokes = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.2 }];
  btn.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];

  const label = figma.createText();
  label.characters = text;
  label.fontSize = 16;
  label.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  label.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
  label.textCase = "UPPER";
  btn.appendChild(label);

  return btn;
}
```

## Alert Popup Construction

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const backdrop = createBackdrop();

// Spacer top (flex grow)
const topSpacer = figma.createFrame();
topSpacer.name = "spacer"; topSpacer.fills = [];
backdrop.appendChild(topSpacer);
topSpacer.layoutSizingHorizontal = "FILL";
topSpacer.layoutSizingVertical = "FILL";

// Card
const card = createCard();
backdrop.appendChild(card);

// Icon placeholder (48x48)
const icon = figma.createFrame();
icon.name = "Alert Icon";
icon.resize(48, 48);
icon.cornerRadius = 12;
icon.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.1 }];
card.appendChild(icon);

// Title
const title = figma.createText();
title.characters = "Connection Lost";
title.fontSize = 24;
title.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
title.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
title.textAlignHorizontal = "CENTER";
card.appendChild(title);
title.layoutSizingHorizontal = "FILL";

// Message
const message = figma.createText();
message.characters = "Please check your internet\nconnection and try again.";
message.fontSize = 14;
message.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
message.fills = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
message.textAlignHorizontal = "CENTER";
message.lineHeight = { unit: "PIXELS", value: 20 };
card.appendChild(message);
message.layoutSizingHorizontal = "FILL";

// OK button (full width)
const okBtn = createPrimaryButton("OK");
card.appendChild(okBtn);
okBtn.layoutSizingHorizontal = "FILL";

// Spacer bottom (flex grow)
const bottomSpacer = figma.createFrame();
bottomSpacer.name = "spacer"; bottomSpacer.fills = [];
backdrop.appendChild(bottomSpacer);
bottomSpacer.layoutSizingHorizontal = "FILL";
bottomSpacer.layoutSizingVertical = "FILL";

return { popupId: backdrop.id };
```

## Confirmation Popup Construction

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const backdrop = createBackdrop();

const topSpacer = figma.createFrame();
topSpacer.name = "spacer"; topSpacer.fills = [];
backdrop.appendChild(topSpacer);
topSpacer.layoutSizingHorizontal = "FILL";
topSpacer.layoutSizingVertical = "FILL";

const card = createCard();
backdrop.appendChild(card);

// Title
const title = figma.createText();
title.characters = "Cash Out?";
title.fontSize = 24;
title.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
title.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
title.textAlignHorizontal = "CENTER";
card.appendChild(title);
title.layoutSizingHorizontal = "FILL";

// Message
const message = figma.createText();
message.characters = "Cash out at 2.4x for\n$120.00 profit?";
message.fontSize = 14;
message.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
message.fills = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
message.textAlignHorizontal = "CENTER";
message.lineHeight = { unit: "PIXELS", value: 20 };
card.appendChild(message);
message.layoutSizingHorizontal = "FILL";

// Button row (Cancel + Confirm)
const btnRow = figma.createFrame();
btnRow.name = "Button Row";
btnRow.layoutMode = "HORIZONTAL";
btnRow.itemSpacing = 12;
btnRow.fills = [];
card.appendChild(btnRow);
btnRow.layoutSizingHorizontal = "FILL";

const cancelBtn = createSecondaryButton("Cancel");
btnRow.appendChild(cancelBtn);
cancelBtn.layoutSizingHorizontal = "FILL";

const confirmBtn = createPrimaryButton("Confirm");
btnRow.appendChild(confirmBtn);
confirmBtn.layoutSizingHorizontal = "FILL";

const bottomSpacer = figma.createFrame();
bottomSpacer.name = "spacer"; bottomSpacer.fills = [];
backdrop.appendChild(bottomSpacer);
bottomSpacer.layoutSizingHorizontal = "FILL";
bottomSpacer.layoutSizingVertical = "FILL";

return { popupId: backdrop.id };
```

## Win Celebration Construction

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const backdrop = createBackdrop();

const topSpacer = figma.createFrame();
topSpacer.name = "spacer"; topSpacer.fills = [];
backdrop.appendChild(topSpacer);
topSpacer.layoutSizingHorizontal = "FILL";
topSpacer.layoutSizingVertical = "FILL";

// Win artwork placeholder (200x200)
const artwork = figma.createFrame();
artwork.name = "Win Artwork";
artwork.resize(200, 200);
artwork.cornerRadius = 100; // circle
artwork.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];
backdrop.appendChild(artwork);

// Win amount — large 88px
const amount = figma.createText();
amount.characters = "$ 335.23";
amount.fontSize = 88;
amount.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
amount.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
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
subtitle.fills = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
subtitle.textCase = "UPPER";
subtitle.textAlignHorizontal = "CENTER";
backdrop.appendChild(subtitle);

// Spacer
const midSpacer = figma.createFrame();
midSpacer.name = "spacer"; midSpacer.fills = [];
backdrop.appendChild(midSpacer);
midSpacer.layoutSizingHorizontal = "FILL";
midSpacer.resize(1, 24);

// Collect button (280x56)
const collectBtn = createPrimaryButton("COLLECT", 56);
collectBtn.resize(280, 56);
collectBtn.cornerRadius = 16;
backdrop.appendChild(collectBtn);

const bottomSpacer = figma.createFrame();
bottomSpacer.name = "spacer"; bottomSpacer.fills = [];
backdrop.appendChild(bottomSpacer);
bottomSpacer.layoutSizingHorizontal = "FILL";
bottomSpacer.layoutSizingVertical = "FILL";

return { popupId: backdrop.id };
```

## Assembly Notes

- Backdrop is always 375x812, black at 85% opacity, with VERTICAL auto-layout centering content.
- Card: 327px wide, HUG height, cornerRadius 16, surface fill with blue glow shadow (36px radius).
- Alert: icon (48x48 placeholder) + title (24px white) + message (14px secondary, centered) + full-width primary button.
- Confirmation: title + message + horizontal button row (Cancel secondary + Confirm primary, each FILL width).
- Win Celebration: no card — elements float directly on the backdrop. Artwork (200x200 circle), amount (88px white with glow shadow), subtitle (16px secondary), then collect button (280x56).
- Secondary button: white/6 fill, white/20 stroke, white text.
- Primary button uses the full Palette A shadow stack.
