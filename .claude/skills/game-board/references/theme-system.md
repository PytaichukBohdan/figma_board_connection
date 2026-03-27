# Theme System

This file defines the **token structure** for game board themes. Two example palettes are included as references — when building a new game, create a new palette following the same token structure with game-appropriate values.

## Adapt to Context

> **The token NAMES below are the reusable part, not the hex values.** Every game needs a PAGE_BACKGROUND, SURFACE_PRIMARY, ACCENT_GRADIENT_FROM, etc. — but the actual colors should match the game's identity. A pirate game might use deep ocean blues and weathered golds. A neon arcade game might use black backgrounds with hot pink and electric blue accents.
>
> Use the two palettes below as **structural templates** showing what a complete theme looks like. Then fill in game-appropriate values for your specific project.

## Token Structure (Required for Every Theme)

Every game board theme needs these tokens defined. The structure is what matters — the values change per game.

```
PAGE_BACKGROUND         — Overall canvas/page fill color
SURFACE_PRIMARY         — Panel and card backgrounds
SURFACE_SUBTLE          — Very subtle background tints (usually near-transparent white or black)
SURFACE_INPUT           — Input field backgrounds
SURFACE_BORDER          — Input/panel borders
SURFACE_DIVIDER         — Section divider lines

TEXT_PRIMARY            — Main body text (usually white for dark themes)
TEXT_SECONDARY          — Supporting/accent text
TEXT_MUTED              — Disabled or de-emphasized text

ACCENT_GRADIENT_FROM    — Button/CTA gradient start
ACCENT_GRADIENT_TO      — Button/CTA gradient end
ACCENT_BORDER           — Accent-colored borders (buttons, active states)
ACCENT_GLOW             — Glow shadow color for interactive elements

DEEP_SHADOW             — Hard edge shadow under buttons/elevated elements
INNER_HIGHLIGHT         — Top inner shadow for 3D depth effect
INNER_SHADOW            — Bottom inner shadow for 3D depth effect

TOGGLE_ON_BG            — Toggle switch "on" background
TOGGLE_ON_KNOB          — Toggle switch "on" knob color
TOGGLE_OFF_BG           — Toggle switch "off" background
TOGGLE_OFF_KNOB         — Toggle switch "off" knob color

PANEL_GLOW              — Outer glow on floating panels (menu, popups)
```

---

## Example Palette A: Avia Aces (Dark Indigo/Blue)

Aviation theme. Deep navy base, blue/indigo accents, glow effects.

### Colors (0-1 range for Figma Plugin API)

```
PAGE_BACKGROUND:        #180f80  -> { r: 0.094, g: 0.059, b: 0.502 }

SURFACE_PRIMARY:        #1f235b  -> { r: 0.122, g: 0.137, b: 0.357 }  (indigo/950)
SURFACE_SUBTLE:         rgba(255,255,255,0.06)                        (white/6)
SURFACE_INPUT:          rgba(255,255,255,0.05)                        (white/5)
SURFACE_BORDER:         rgba(255,255,255,0.2)                         (white/20)
SURFACE_DIVIDER:        rgba(255,255,255,0.06)                        (white/6)

TEXT_PRIMARY:            #ffffff  -> { r: 1, g: 1, b: 1 }              (white/100)
TEXT_SECONDARY:          #a4bcfd  -> { r: 0.643, g: 0.737, b: 0.992 } (indigo/300)
TEXT_MUTED:              rgba(255,255,255,0.4)                         (white/40)

ACCENT_GRADIENT_FROM:    #1570ef  -> { r: 0.082, g: 0.439, b: 0.937 } (blue/600)
ACCENT_GRADIENT_TO:      #444ce7  -> { r: 0.267, g: 0.298, b: 0.906 } (indigo/600)
ACCENT_BORDER:           #a4bcfd  -> { r: 0.643, g: 0.737, b: 0.992 } (indigo/300)
ACCENT_GLOW:             #8098f9  -> { r: 0.502, g: 0.596, b: 0.976 } (indigo/400)
ACCENT_DEEP_SHADOW:      #102a56  -> { r: 0.063, g: 0.165, b: 0.337 } (blue/950)

INNER_HIGHLIGHT:         #c7d7fe  -> { r: 0.780, g: 0.843, b: 0.996 } (indigo/200)
INNER_SHADOW:            #3538cd  -> { r: 0.208, g: 0.220, b: 0.804 } (indigo/700)

TOGGLE_ON_BG:            #6172f3  -> { r: 0.380, g: 0.447, b: 0.953 } (indigo/500)
TOGGLE_ON_KNOB:          #f5f8ff  -> { r: 0.961, g: 0.973, b: 1.000 } (indigo/25)
TOGGLE_OFF_BG:           rgba(255,255,255,0.06)                       (white/6)
TOGGLE_OFF_KNOB:         #ffffff                                       (white/100)

PANEL_GLOW:              0px 0px 36px #1570ef  (blue/600, on menu panels)
```

### Example Button Shadow Stack (Avia Aces)

The *structure* of the shadow stack is reusable. The *colors* should match your theme.

```
Outer:
  0px 4px 3px rgba(SHADOW_SOFT, 0.3)     -- soft drop shadow
  0px 2px 0px DEEP_SHADOW                 -- hard edge shadow
  0px 0px 30px ACCENT_GLOW                -- glow

Inner:
  inset 0px 3px 1px INNER_HIGHLIGHT       -- top highlight
  inset 0px -3px 1px INNER_SHADOW         -- bottom shadow

Text shadow:
  0px 1px 0px TEXT_SHADOW                 -- depth under text

Example values (Avia Aces):
  SHADOW_SOFT:     rgba(3,4,8)
  DEEP_SHADOW:     #102a56  (blue/950)
  ACCENT_GLOW:     #8098f9  (indigo/400)
  INNER_HIGHLIGHT: #c7d7fe  (indigo/200)
  INNER_SHADOW:    #3538cd  (indigo/700)
  TEXT_SHADOW:     #062c41  (blue-light/950)
```

---

## Example Palette B: Bumblebee (Green/Nature)

Bee/flower theme. Bright nature tones, green accents, warm shadows.

### Colors (0-1 range for Figma Plugin API)

```
PAGE_BACKGROUND:        #2d2d4a  -> { r: 0.176, g: 0.176, b: 0.290 }  (dark slate)

SURFACE_PRIMARY:        #15290a  -> { r: 0.082, g: 0.161, b: 0.039 }  (green-light/950)

TEXT_PRIMARY:            #ffffff  -> { r: 1, g: 1, b: 1 }              (white/100)

ACCENT_GRADIENT_FROM:    #66c61c  -> { r: 0.400, g: 0.776, b: 0.110 } (green-light/500)
ACCENT_GRADIENT_TO:      #099250  -> { r: 0.035, g: 0.573, b: 0.314 } (green/600)
ACCENT_BORDER:           #15290a  -> { r: 0.082, g: 0.161, b: 0.039 } (green-light/950)
ACCENT_GLOW:             #3ccb7f  -> { r: 0.235, g: 0.796, b: 0.498 } (green/400)

INNER_HIGHLIGHT:         #d0f8ab  -> { r: 0.816, g: 0.973, b: 0.671 } (green-light/200)
INNER_SHADOW:            #326212  -> { r: 0.196, g: 0.384, b: 0.071 } (green-light/800)
```

### Example Button Shadow Stack (Bumblebee)
```
Outer:
  0px 4px 3px rgba(SHADOW_SOFT, 0.3)     -- warm drop shadow
  0px 2px 0px DEEP_SHADOW                 -- hard edge
  0px 0px 30px ACCENT_GLOW                -- green glow

Inner:
  inset 0px 3px 1px INNER_HIGHLIGHT       -- top highlight
  inset 0px -3px 1px INNER_SHADOW         -- bottom shadow

Example values (Bumblebee):
  SHADOW_SOFT:     rgba(8,6,3)
  DEEP_SHADOW:     #15290a  (green-light/950)
  ACCENT_GLOW:     #3ccb7f  (green/400)
  INNER_HIGHLIGHT: #d0f8ab  (green-light/200)
  INNER_SHADOW:    #326212  (green-light/800)
  TEXT_SHADOW:     #15290a  (green-light/950)
```

---

## Typography

The reference boards use **"Janda Manatee Solid Cyrillic"** — a playful rounded font suited for casual games. **Choose a font that matches your game's personality.** The type *scale* below (sizes, tracking, case) is the reusable pattern; the font family should change per game.

| Role | Size | Weight | Tracking | Case | Color Token |
|------|------|--------|----------|------|-------------|
| Screen title | 24px | Regular | -0.96px | UPPERCASE | TEXT_PRIMARY |
| Body / row label | 16px | Regular | -0.64px | UPPERCASE | TEXT_PRIMARY |
| Small label | 14px | Regular | -0.56px | UPPERCASE | TEXT_PRIMARY or TEXT_SECONDARY |
| Tab label | 18px | Regular | -0.72px | UPPERCASE | TEXT_PRIMARY |
| Button label (main) | 20px | Regular | -- | UPPERCASE | TEXT_PRIMARY |
| Button label (large) | 32px | Regular | -- | UPPERCASE | TEXT_PRIMARY |
| Input amount | 22px | Regular | -0.88px | UPPERCASE | TEXT_PRIMARY |
| Win amount (huge) | 88px | Regular | -- | UPPERCASE | TEXT_PRIMARY |

**Line height**: Always `leading-[normal]` (auto line height in Figma: `{ unit: "AUTO" }`)

**Loading font in Plugin API**:
```js
// Use the game's brand font — examples shown as reference only
// Example (Avia Aces / Bumblebee): "Janda Manatee Solid Cyrillic"
const FONT = { family: "YOUR_GAME_FONT", style: "Regular" };
await figma.loadFontAsync(FONT);
```

---

## Spacing Constants

These structural values are consistent across themes. Adjust only if your game's design language requires different proportions.

| Token | Value | Usage |
|-------|-------|-------|
| Screen padding | 8px | Page-level padding around all content |
| Panel padding | 12px | Inside card/panel containers |
| Component gap (tight) | 8px | Between tabs, between icon and label |
| Component gap (normal) | 12px | Between major siblings in a row |
| Row height (standard) | 48px | Settings rows, navigation rows |
| Row padding | 12px horizontal, 12px vertical | Inside Row component |
| Tab height | 32px | Tab / 32px component |
| Header height | 48px per icon button, auto for stack | Full header ~64px |
| Button height (standard) | 56px | Primary CTA |
| Button height (large) | 104px | Jackpot/featured CTA |
| Input height (large) | ~48px | Input L with +/- buttons |
| Switcher size | 47x24px (off), 44x24px (some variants) | Toggle width x height |
| Switcher knob | 26x20px | Knob inside toggle |
| Border radius (small) | 8px | +/- buttons, small elements |
| Border radius (medium) | 12px | Tabs, header sections, buttons |
| Border radius (large) | 16px | Panels, main CTA buttons |
| Border radius (pill) | 9999px | Switcher/toggle |

---

## Screen Dimensions

| Format | Width x Height | Usage |
|--------|---------------|-------|
| Mobile portrait | 375 x 812 | Primary game screens |
| Mobile portrait (large) | 390 x 844 | Alternative mobile |
| Desktop landscape | 1440 x 1024 | Desktop game view, jackpot screens |
| Desktop marketing | 2880 x 2048 | Preview images |

---

## Creating a New Theme

To create a theme for a different game:

1. **Decide the mood** — What emotion does the game evoke? (excitement, mystery, luxury, fun)
2. **Pick a base color** — The dominant color that defines the game (dark blue for ocean, deep red for dragon, etc.)
3. **Build the palette** by filling in every token from the Token Structure section above:
   - **PAGE_BACKGROUND** — The overall canvas color (usually darkest)
   - **SURFACE_PRIMARY** — Panel/card backgrounds (slightly lighter than page)
   - **ACCENT_GRADIENT_FROM / TO** — Button gradient and interactive highlights (the game's signature color)
   - **ACCENT_BORDER** — Button and input borders (usually a lighter shade of the accent)
   - **ACCENT_GLOW** — Glow shadow color (medium-bright version of accent)
   - **INNER_HIGHLIGHT / INNER_SHADOW** — 3D button depth colors (light and dark versions of accent)
4. **Choose a font** that matches the game's personality
5. **Replace background artwork** — Full-bleed background images
6. **Design a game logo** — Unique per game
7. **Create game symbols** — Characters, items, etc.

The structural layout, component dimensions, and spacing stay the same across all themes. The colors, fonts, and artwork make each game unique.
