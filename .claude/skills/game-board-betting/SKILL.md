---
name: game-board-betting
description: "Build the betting controls panel for a mobile game board in Figma — bet input with +/- buttons, quick-pick tabs, auto-play toggle, and bet CTA. Use for 'bet panel', 'betting controls', 'wager section', 'bet input'. Self-sufficient."
---

# Game Board Betting Panel

Build the bottom betting controls: an outer wrapper with an inner card containing the bet input (large, with +/- mini buttons), quick-pick tab row, auto-play toggle, and a full-width CTA button.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Visual Structure

```
+---[375px outer, 8px padding]-----------------------+
| +---[inner card, 12px padding, r16]---------------+ |
| |                                                  | |
| |  [-]        $ 10.00         [+]    48px Input L  | |
| |                                                  | |
| |  [ 1 ] [ 2 ] [ 5 ] [ 10 ]         32px Tabs     | |
| |                                                  | |
| |  ────────── divider ──────────     1px           | |
| |                                                  | |
| |  Auto play                [=O ]    Switch cell   | |
| |                                                  | |
| |  [============ BET ============]   56px CTA      | |
| |                                                  | |
| +--------------------------------------------------+ |
+------------------------------------------------------+
```

## Colors (Inline)

| Token | Figma 0-1 | Hex |
|-------|-----------|-----|
| Surface (indigo/950) | `{ r: 0.122, g: 0.137, b: 0.357 }` | #1f235b |
| White | `{ r: 1, g: 1, b: 1 }` | #ffffff |
| Text secondary (indigo/300) | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Surface subtle (white/6) | `{ r: 1, g: 1, b: 1, a: 0.06 }` | — |
| Surface border (white/20) | `{ r: 1, g: 1, b: 1, a: 0.2 }` | — |
| Toggle on (indigo/500) | `{ r: 0.380, g: 0.447, b: 0.953 }` | #6172f3 |
| Button gradient from | `{ r: 0.082, g: 0.439, b: 0.937 }` | #1570ef |
| Button gradient to | `{ r: 0.267, g: 0.298, b: 0.906 }` | #444ce7 |
| Button border | `{ r: 0.643, g: 0.737, b: 0.992 }` | #a4bcfd |
| Button glow | `{ r: 0.502, g: 0.596, b: 0.976 }` | #8098f9 |
| Button deep shadow | `{ r: 0.063, g: 0.165, b: 0.337 }` | #102a56 |

## Font

**"Janda Manatee Solid Cyrillic"**, Regular. Fallback: "Inter" Regular.

## Input Large (48px, inline recipe)

```
+---[FILL width]--[48px height]---+
| [-32x32]  $ 10.00    [+32x32]  |
+---------------------------------+
```

```js
// Input Large — 48px tall, FILL width, with +/- mini buttons
function createInputLarge(amountText) {
  const input = figma.createFrame();
  input.name = "Input Large";
  input.layoutMode = "HORIZONTAL";
  input.counterAxisAlignItems = "CENTER";
  input.resize(335, 48);
  input.paddingLeft = 8; input.paddingRight = 8;
  input.paddingTop = 8; input.paddingBottom = 8;
  input.itemSpacing = 8;
  input.cornerRadius = 12;
  input.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];

  // Minus button (32x32, gradient mini)
  const minus = createMiniButton("minus");
  input.appendChild(minus);

  // Amount text (centered, flex grow)
  const amount = figma.createText();
  amount.characters = amountText || "$ 10.00";
  amount.fontSize = 20;
  amount.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  amount.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
  amount.textAlignHorizontal = "CENTER";
  input.appendChild(amount);
  amount.layoutSizingHorizontal = "FILL";

  // Plus button (32x32, gradient mini)
  const plus = createMiniButton("plus");
  input.appendChild(plus);

  return input;
}
```

## Mini Button (32x32, inline recipe)

```js
function createMiniButton(type) {
  const btn = figma.createFrame();
  btn.name = type === "minus" ? "Minus" : "Plus";
  btn.resize(32, 32);
  btn.cornerRadius = 8;
  btn.layoutMode = "HORIZONTAL";
  btn.primaryAxisAlignItems = "CENTER";
  btn.counterAxisAlignItems = "CENTER";
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
    { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 1 }, offset: { x: 0, y: 0 }, radius: 22, visible: true },
    { type: 'INNER_SHADOW', color: { r: 0.780, g: 0.843, b: 0.996, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
    { type: 'INNER_SHADOW', color: { r: 0.208, g: 0.220, b: 0.804, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
  ];

  // Icon placeholder 20x20 (minus line or plus cross)
  const icon = figma.createFrame();
  icon.name = "Icon";
  icon.resize(20, 20);
  icon.fills = [];
  btn.appendChild(icon);

  return btn;
}
```

## Switcher (47x24, inline recipe)

```js
function createSwitcher(isOn) {
  const sw = figma.createFrame();
  sw.name = isOn ? "Switcher/On" : "Switcher/Off";
  sw.layoutMode = "HORIZONTAL";
  sw.counterAxisAlignItems = "CENTER";
  sw.resize(47, 24);
  sw.cornerRadius = 12;
  sw.paddingLeft = 2; sw.paddingRight = 2;
  sw.paddingTop = 2; sw.paddingBottom = 2;

  if (isOn) {
    sw.fills = [{ type: 'SOLID', color: { r: 0.380, g: 0.447, b: 0.953 } }];
    sw.primaryAxisAlignItems = "MAX";
  } else {
    sw.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];
    sw.primaryAxisAlignItems = "MIN";
  }

  if (isOn) {
    const spacer = figma.createFrame();
    spacer.name = "spacer"; spacer.fills = [];
    sw.appendChild(spacer);
    spacer.layoutSizingHorizontal = "FILL"; spacer.resize(1, 20);
  }

  const knob = figma.createFrame();
  knob.name = "Knob";
  knob.resize(26, 20);
  knob.cornerRadius = 10;
  knob.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
  sw.appendChild(knob);

  if (!isOn) {
    const spacer = figma.createFrame();
    spacer.name = "spacer"; spacer.fills = [];
    sw.appendChild(spacer);
    spacer.layoutSizingHorizontal = "FILL"; spacer.resize(1, 20);
  }

  return sw;
}
```

## Full Betting Panel Construction

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const SURFACE = { r: 0.122, g: 0.137, b: 0.357 };
const WHITE = { r: 1, g: 1, b: 1 };
const SECONDARY = { r: 0.643, g: 0.737, b: 0.992 };

// ── Outer wrapper (8px padding) ──
const outer = figma.createFrame();
outer.name = "Betting Panel";
outer.layoutMode = "VERTICAL";
outer.resize(375, 1);
outer.layoutSizingVertical = "HUG";
outer.paddingLeft = 8; outer.paddingRight = 8;
outer.paddingTop = 8; outer.paddingBottom = 8;
outer.fills = [];

// ── Inner card (12px padding, surface fill, cornerRadius 16) ──
const inner = figma.createFrame();
inner.name = "Betting Card";
inner.layoutMode = "VERTICAL";
inner.cornerRadius = 16;
inner.paddingLeft = 12; inner.paddingRight = 12;
inner.paddingTop = 12; inner.paddingBottom = 12;
inner.itemSpacing = 12;
inner.fills = [{ type: 'SOLID', color: SURFACE }];
outer.appendChild(inner);
inner.layoutSizingHorizontal = "FILL";

// ── Input Large ──
const inputL = createInputLarge("$ 10.00");
inner.appendChild(inputL);
inputL.layoutSizingHorizontal = "FILL";

// ── Tab row (quick picks: 1, 2, 5, 10) ──
const tabRow = figma.createFrame();
tabRow.name = "Quick Picks";
tabRow.layoutMode = "HORIZONTAL";
tabRow.itemSpacing = 8;
tabRow.fills = [];
inner.appendChild(tabRow);
tabRow.layoutSizingHorizontal = "FILL";

["1", "2", "5", "10"].forEach(val => {
  const tab = figma.createFrame();
  tab.name = "Tab/" + val;
  tab.layoutMode = "HORIZONTAL";
  tab.primaryAxisAlignItems = "CENTER";
  tab.counterAxisAlignItems = "CENTER";
  tab.resize(1, 32);
  tab.cornerRadius = 12;
  tab.fills = [{ type: 'SOLID', color: WHITE, opacity: 0.06 }];
  tab.paddingLeft = 12; tab.paddingRight = 12;
  tabRow.appendChild(tab);
  tab.layoutSizingHorizontal = "FILL";

  const lbl = figma.createText();
  lbl.characters = val;
  lbl.fontSize = 14;
  lbl.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  lbl.fills = [{ type: 'SOLID', color: WHITE }];
  lbl.textAlignHorizontal = "CENTER";
  tab.appendChild(lbl);
});

// ── Divider ──
const divider = figma.createFrame();
divider.name = "Divider";
divider.resize(1, 1);
divider.fills = [{ type: 'SOLID', color: WHITE, opacity: 0.06 }];
inner.appendChild(divider);
divider.layoutSizingHorizontal = "FILL";

// ── Switch cells row (Auto play + switcher) ──
const switchRow = figma.createFrame();
switchRow.name = "Switch Cells";
switchRow.layoutMode = "HORIZONTAL";
switchRow.counterAxisAlignItems = "CENTER";
switchRow.itemSpacing = 12;
switchRow.fills = [];
inner.appendChild(switchRow);
switchRow.layoutSizingHorizontal = "FILL";

const autoLabel = figma.createText();
autoLabel.characters = "Auto play";
autoLabel.fontSize = 16;
autoLabel.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
autoLabel.fills = [{ type: 'SOLID', color: SECONDARY }];
switchRow.appendChild(autoLabel);
autoLabel.layoutSizingHorizontal = "FILL";

const autoSwitcher = createSwitcher(false);
switchRow.appendChild(autoSwitcher);

// ── CTA Button (full width, 56px) ──
const cta = figma.createFrame();
cta.name = "Button CTA";
cta.layoutMode = "HORIZONTAL";
cta.primaryAxisAlignItems = "CENTER";
cta.counterAxisAlignItems = "CENTER";
cta.resize(1, 56);
cta.cornerRadius = 16;
cta.clipsContent = true;
cta.strokeWeight = 2;
cta.strokes = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
cta.fills = [{
  type: 'GRADIENT_LINEAR',
  gradientStops: [
    { position: 0, color: { r: 0.082, g: 0.439, b: 0.937, a: 1 } },
    { position: 1, color: { r: 0.267, g: 0.298, b: 0.906, a: 1 } }
  ],
  gradientTransform: [[0, 1, 0], [-1, 0, 1]]
}];
cta.effects = [
  { type: 'DROP_SHADOW', color: { r: 0.012, g: 0.016, b: 0.031, a: 0.3 }, offset: { x: 0, y: 4 }, radius: 3, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.063, g: 0.165, b: 0.337, a: 1 }, offset: { x: 0, y: 2 }, radius: 0, visible: true },
  { type: 'DROP_SHADOW', color: { r: 0.502, g: 0.596, b: 0.976, a: 1 }, offset: { x: 0, y: 0 }, radius: 30, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.780, g: 0.843, b: 0.996, a: 1 }, offset: { x: 0, y: 3 }, radius: 1, visible: true },
  { type: 'INNER_SHADOW', color: { r: 0.208, g: 0.220, b: 0.804, a: 1 }, offset: { x: 0, y: -3 }, radius: 1, visible: true },
];
inner.appendChild(cta);
cta.layoutSizingHorizontal = "FILL";

const ctaLabel = figma.createText();
ctaLabel.characters = "BET";
ctaLabel.fontSize = 20;
ctaLabel.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
ctaLabel.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
ctaLabel.textCase = "UPPER";
cta.appendChild(ctaLabel);

return { bettingPanelId: outer.id };
```

## Assembly Notes

- Outer wrapper is 375px wide with 8px padding on all sides, transparent fill (background shows through).
- Inner card is FILL width, surface-colored, cornerRadius 16.
- Input Large: 48px tall, FILL width, white/6 background, +/- mini buttons (32x32, gradient fill with full shadow stack).
- Quick-pick tabs: 4 equal-width tabs at 32px height, each FILL horizontal, white/6 background, 12px corner radius.
- Divider: 1px tall, FILL width, white/6.
- Switch cell row: "Auto play" label (flex grow) + switcher (47x24).
- CTA button: 56px tall, FILL width, gradient fill with the full button shadow stack (same as game-board-button Palette A).
