---
name: game-board-menu
description: "Build the game menu screen in Figma — settings rows with toggles, navigation rows with chevrons, in a glowing panel. Use for 'game menu', 'settings screen', 'game settings panel'. Self-sufficient."
---

# Game Board Menu

Build the full-screen game menu panel: a glowing card with toggle rows (Music, Game Sounds, UI Sounds), navigation rows (My Bets, Leaderboard, How to Play, Game Rules, Provably Fair), and a "Powered by" footer.

**Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.**

## Adapt to Context

> **All color values and the font name below are EXAMPLES** from the Avia Aces (indigo/blue) reference board. When building for a different game, derive all theme variables from the game's identity. The menu *structure* (panel layout, row patterns, switcher dimensions, section dividers) is the reusable pattern. The specific colors, font, and glow should match the new game.

## Visual Structure

```
+-----[359px]------------------------------+
|                  MENU              24px   |
|------------------------------------------|
| Settings                                 |
|  [icon]  Music                 [=O ] 16px|
|  [icon]  Game Sounds           [=O ] 16px|
|  [icon]  UI Sounds             [=O ] 16px|
|------ divider (SURFACE_DIVIDER) ---------|
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

## Theme Variables (define before use)

```js
// ═══ Theme variables — derive these from the game's context ═══
// Example values shown are from Avia Aces (indigo/blue aviation theme)
const FONT           = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example: { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const SURFACE        = /* derive */;  // Example: { r: 0.122, g: 0.137, b: 0.357 } (#1f235b)
const TEXT_PRIMARY   = /* derive */;  // Example: { r: 1, g: 1, b: 1 } (white)
const TEXT_SECONDARY = /* derive */;  // Example: { r: 0.643, g: 0.737, b: 0.992 } (#a4bcfd)
const TOGGLE_ON_BG   = /* derive */;  // Example: { r: 0.380, g: 0.447, b: 0.953 } (#6172f3)
const ACCENT_GLOW    = /* derive */;  // Example: { r: 0.082, g: 0.439, b: 0.937 } (#1570ef)
// SURFACE_SUBTLE:    { ...TEXT_PRIMARY, a: 0.06 }  — usually universal for dark themes
// SURFACE_DIVIDER:   { ...TEXT_PRIMARY, a: 0.06 }  — same
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
    sw.fills = [{ type: 'SOLID', color: TOGGLE_ON_BG }];
    sw.primaryAxisAlignItems = "MAX"; // knob right
  } else {
    sw.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_SUBTLE
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
  knob.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
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
  caret.strokes = [{ type: 'SOLID', color: TEXT_SECONDARY }];
  caret.strokeWeight = 2;
  caret.strokeCap = "ROUND";
  caret.strokeJoin = "ROUND";
  caret.fills = [];
  return caret;
}
```

## Full Menu Panel Construction

```js
await figma.loadFontAsync(FONT);

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
  { type: 'DROP_SHADOW', color: { ...ACCENT_GLOW, a: 0.4 }, offset: { x: 0, y: 0 }, radius: 36, visible: true }
];

// ── Title ──
const title = figma.createText();
title.characters = "MENU";
title.fontSize = 24;
title.fontName = FONT;
title.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
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
  row.strokes = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.06 } }]; // SURFACE_DIVIDER
  row.strokeBottomWeight = 1;
  row.strokeTopWeight = 0; row.strokeLeftWeight = 0; row.strokeRightWeight = 0;

  // Icon placeholder 20x20
  const icon = figma.createFrame();
  icon.name = "Icon";
  icon.resize(20, 20);
  icon.cornerRadius = 4;
  icon.fills = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.1 } }];
  row.appendChild(icon);

  // Label (flex grow)
  const lbl = figma.createText();
  lbl.characters = labelText;
  lbl.fontSize = 16;
  lbl.fontName = FONT;
  lbl.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
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
  icon.fills = [{ type: 'SOLID', color: { ...TEXT_PRIMARY, a: 0.1 } }];
  row.appendChild(icon);

  // Label (flex grow)
  const lbl = figma.createText();
  lbl.characters = labelText;
  lbl.fontSize = 16;
  lbl.fontName = FONT;
  lbl.fills = [{ type: 'SOLID', color: TEXT_PRIMARY }];
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
divider.fills = [{ type: 'SOLID', color: TEXT_PRIMARY, opacity: 0.06 }]; // SURFACE_DIVIDER
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
footer.fontName = FONT;
footer.fills = [{ type: 'SOLID', color: TEXT_SECONDARY }];
footer.textAlignHorizontal = "CENTER";
panel.appendChild(footer);
footer.layoutSizingHorizontal = "FILL";

return { panelId: panel.id };
```

## Assembly Notes

- The panel is 359px wide (fitting inside a 375px mobile frame with 8px horizontal margin).
- The glow shadow uses the ACCENT_GLOW color at 40% opacity, 36px radius, zero offset.
- Each settings row has a bottom border of SURFACE_DIVIDER (1px).
- The divider between settings and navigation is a 1px solid frame at SURFACE_DIVIDER.
- Switcher ON state: TOGGLE_ON_BG background, knob pushed right via spacer.
- Switcher OFF state: SURFACE_SUBTLE background, knob pushed left.
- Caret right is a simple chevron vector, 8x14, stroked with TEXT_SECONDARY.
- Icon placeholders (20x20) are semi-transparent frames; replace with actual SVG icons after construction.
