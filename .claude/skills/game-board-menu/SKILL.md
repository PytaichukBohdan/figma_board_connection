---
name: game-board-menu
description: "Build the game menu screen in Figma — settings rows with toggles, navigation rows with chevrons, in a glowing panel. Use for 'game menu', 'settings screen', 'game settings panel'. Self-sufficient."
---

# Game Board Menu

Build the full-screen game menu panel: a glowing card with toggle rows (Music, Game Sounds, UI Sounds), navigation rows (My Bets, Leaderboard, How to Play, Game Rules, Provably Fair), and a "Powered by" footer.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Visual Structure

```
+-----[359px]------------------------------+
|                  MENU              24px   |
|------------------------------------------|
| Settings                                 |
|  [icon]  Music                 [=O ] 16px|
|  [icon]  Game Sounds           [=O ] 16px|
|  [icon]  UI Sounds             [=O ] 16px|
|------ divider (white/6) ----------------|
| Navigation                               |
|  [icon]  My Bets                    [>]  |
|  [icon]  Leaderboard                [>]  |
|  [icon]  How to Play                [>]  |
|  [icon]  Game Rules                 [>]  |
|  [icon]  Provably Fair              [>]  |
|------------------------------------------|
|          Powered by [logo]               |
+-------------------------------------------+
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
| Toggle off knob | `{ r: 1, g: 1, b: 1 }` | — |
| Glow color (blue/600) | `{ r: 0.082, g: 0.439, b: 0.937 }` | #1570ef |
| Page background | `{ r: 0.094, g: 0.059, b: 0.502 }` | #180f80 |

## Font

All text: **"Janda Manatee Solid Cyrillic"**, Regular. Fallback: "Inter" Regular.

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
```

## Switcher Component (47x24, inline recipe)

```
ON state:     OFF state:
+-------[47]-+  +-------[47]-+
| ___  [==]  |  | [==]  ___  |
+-------------+  +-------------+
     24px             24px
```

```js
// Switcher — 47x24 pill with 26x20 knob
function createSwitcher(isOn) {
  const sw = figma.createFrame();
  sw.name = isOn ? "Switcher/On" : "Switcher/Off";
  sw.layoutMode = "HORIZONTAL";
  sw.counterAxisAlignItems = "CENTER";
  sw.resize(47, 24);
  sw.cornerRadius = 12; // pill shape
  sw.paddingLeft = 2; sw.paddingRight = 2;
  sw.paddingTop = 2; sw.paddingBottom = 2;

  if (isOn) {
    sw.fills = [{ type: 'SOLID', color: { r: 0.380, g: 0.447, b: 0.953 } }]; // indigo/500
    sw.primaryAxisAlignItems = "MAX"; // knob right
  } else {
    sw.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 }, opacity: 0.06 }];
    sw.primaryAxisAlignItems = "MIN"; // knob left
  }

  // Spacer to push knob
  if (isOn) {
    const spacer = figma.createFrame();
    spacer.name = "spacer";
    spacer.fills = [];
    sw.appendChild(spacer);
    spacer.layoutSizingHorizontal = "FILL";
    spacer.resize(1, 20);
  }

  // Knob — 26x20
  const knob = figma.createFrame();
  knob.name = "Knob";
  knob.resize(26, 20);
  knob.cornerRadius = 10; // fully rounded
  knob.fills = [{ type: 'SOLID', color: { r: 1, g: 1, b: 1 } }];
  sw.appendChild(knob);

  if (!isOn) {
    const spacer = figma.createFrame();
    spacer.name = "spacer";
    spacer.fills = [];
    sw.appendChild(spacer);
    spacer.layoutSizingHorizontal = "FILL";
    spacer.resize(1, 20);
  }

  return sw;
}
```

## Caret Right Icon (8x14, inline vector)

```js
function createCaretRight() {
  const caret = figma.createVector();
  caret.name = "CaretRight";
  caret.resize(8, 14);
  caret.vectorPaths = [{
    windingRule: "NONZERO",
    data: "M 1 0 L 7 7 L 1 14"
  }];
  caret.strokes = [{ type: 'SOLID', color: { r: 0.643, g: 0.737, b: 0.992 } }];
  caret.strokeWeight = 2;
  caret.strokeCap = "ROUND";
  caret.strokeJoin = "ROUND";
  caret.fills = [];
  return caret;
}
```

## Full Menu Panel Construction

```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });

const SURFACE = { r: 0.122, g: 0.137, b: 0.357 };
const WHITE = { r: 1, g: 1, b: 1 };
const SECONDARY = { r: 0.643, g: 0.737, b: 0.992 };
const SUBTLE = { r: 1, g: 1, b: 1 }; // used with opacity 0.06
const GLOW = { r: 0.082, g: 0.439, b: 0.937 };

// ── Panel wrapper ──
const panel = figma.createFrame();
panel.name = "Menu Panel";
panel.layoutMode = "VERTICAL";
panel.resize(359, 1); // width fixed, height HUG
panel.layoutSizingVertical = "HUG";
panel.cornerRadius = 16;
panel.paddingLeft = 16; panel.paddingRight = 16;
panel.paddingTop = 16; panel.paddingBottom = 16;
panel.itemSpacing = 0;
panel.fills = [{ type: 'SOLID', color: SURFACE }];
panel.effects = [
  { type: 'DROP_SHADOW', color: { ...GLOW, a: 0.4 }, offset: { x: 0, y: 0 }, radius: 36, visible: true }
];

// ── Title ──
const title = figma.createText();
title.characters = "MENU";
title.fontSize = 24;
title.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
title.fills = [{ type: 'SOLID', color: WHITE }];
title.textCase = "UPPER";
title.textAlignHorizontal = "CENTER";
panel.appendChild(title);
title.layoutSizingHorizontal = "FILL";

// ── Helper: Settings row (icon + label + switcher) ──
function createSettingsRow(labelText, isOn) {
  const row = figma.createFrame();
  row.name = "Row/" + labelText;
  row.layoutMode = "HORIZONTAL";
  row.counterAxisAlignItems = "CENTER";
  row.paddingLeft = 0; row.paddingRight = 0;
  row.paddingTop = 12; row.paddingBottom = 12;
  row.itemSpacing = 12;
  row.fills = [];
  // Bottom border
  row.strokes = [{ type: 'SOLID', color: { ...WHITE, a: 0.06 } }];
  row.strokeBottomWeight = 1;
  row.strokeTopWeight = 0; row.strokeLeftWeight = 0; row.strokeRightWeight = 0;

  // Icon placeholder 20x20
  const icon = figma.createFrame();
  icon.name = "Icon";
  icon.resize(20, 20);
  icon.cornerRadius = 4;
  icon.fills = [{ type: 'SOLID', color: { ...WHITE, a: 0.1 } }];
  row.appendChild(icon);

  // Label (flex grow)
  const lbl = figma.createText();
  lbl.characters = labelText;
  lbl.fontSize = 16;
  lbl.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  lbl.fills = [{ type: 'SOLID', color: WHITE }];
  row.appendChild(lbl);
  lbl.layoutSizingHorizontal = "FILL";

  // Switcher
  const sw = createSwitcher(isOn);
  row.appendChild(sw);

  return row;
}

// ── Helper: Navigation row (icon + label + caret) ──
function createNavRow(labelText) {
  const row = figma.createFrame();
  row.name = "Row/" + labelText;
  row.layoutMode = "HORIZONTAL";
  row.counterAxisAlignItems = "CENTER";
  row.paddingLeft = 0; row.paddingRight = 0;
  row.paddingTop = 12; row.paddingBottom = 12;
  row.itemSpacing = 12;
  row.fills = [];

  // Icon placeholder 20x20
  const icon = figma.createFrame();
  icon.name = "Icon";
  icon.resize(20, 20);
  icon.cornerRadius = 4;
  icon.fills = [{ type: 'SOLID', color: { ...WHITE, a: 0.1 } }];
  row.appendChild(icon);

  // Label (flex grow)
  const lbl = figma.createText();
  lbl.characters = labelText;
  lbl.fontSize = 16;
  lbl.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
  lbl.fills = [{ type: 'SOLID', color: WHITE }];
  row.appendChild(lbl);
  lbl.layoutSizingHorizontal = "FILL";

  // Caret right
  const caret = createCaretRight();
  row.appendChild(caret);

  return row;
}

// ── Settings section ──
const settingsSection = figma.createFrame();
settingsSection.name = "Settings";
settingsSection.layoutMode = "VERTICAL";
settingsSection.itemSpacing = 0;
settingsSection.paddingTop = 8; settingsSection.paddingBottom = 8;
settingsSection.fills = [];
panel.appendChild(settingsSection);
settingsSection.layoutSizingHorizontal = "FILL";

settingsSection.appendChild(createSettingsRow("Music", true));
settingsSection.appendChild(createSettingsRow("Game Sounds", true));
settingsSection.appendChild(createSettingsRow("UI Sounds", false));

// ── Divider line ──
const divider = figma.createFrame();
divider.name = "Divider";
divider.resize(327, 1);
divider.fills = [{ type: 'SOLID', color: SUBTLE, opacity: 0.06 }];
panel.appendChild(divider);
divider.layoutSizingHorizontal = "FILL";

// ── Navigation section ──
const navSection = figma.createFrame();
navSection.name = "Navigation";
navSection.layoutMode = "VERTICAL";
navSection.itemSpacing = 0;
navSection.paddingTop = 8; navSection.paddingBottom = 8;
navSection.fills = [];
panel.appendChild(navSection);
navSection.layoutSizingHorizontal = "FILL";

navSection.appendChild(createNavRow("My Bets"));
navSection.appendChild(createNavRow("Leaderboard"));
navSection.appendChild(createNavRow("How to Play"));
navSection.appendChild(createNavRow("Game Rules"));
navSection.appendChild(createNavRow("Provably Fair"));

// ── Footer ──
const footer = figma.createText();
footer.characters = "Powered by CrashLab";
footer.fontSize = 12;
footer.fontName = { family: "Janda Manatee Solid Cyrillic", style: "Regular" };
footer.fills = [{ type: 'SOLID', color: SECONDARY }];
footer.textAlignHorizontal = "CENTER";
panel.appendChild(footer);
footer.layoutSizingHorizontal = "FILL";

return { panelId: panel.id };
```

## Assembly Notes

- The panel is 359px wide (fitting inside a 375px mobile frame with 8px horizontal margin).
- The glow shadow uses blue/600 at 40% opacity, 36px radius, zero offset.
- Each settings row has a bottom border of white/6 (1px).
- The divider between settings and navigation is a 1px solid frame at white/6.
- Switcher ON state: indigo/500 background, knob pushed right via spacer.
- Switcher OFF state: white/6 background, knob pushed left.
- Caret right is a simple chevron vector, 8x14, stroked with indigo/300.
- Icon placeholders (20x20) are semi-transparent white frames; replace with actual SVG icons after construction.
