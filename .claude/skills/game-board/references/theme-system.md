# Theme System

Two reference palettes extracted from the Avia Aces and Bumblebee boards. Use one as-is or create a new palette following the same token structure.

## Palette A: Avia Aces (Dark Indigo/Blue)

Aviation theme. Deep navy base, blue/indigo accents, glow effects.

### Colors (0-1 range for Figma Plugin API)

```
PAGE_BACKGROUND:        #180f80  → { r: 0.094, g: 0.059, b: 0.502 }

SURFACE_PRIMARY:        #1f235b  → { r: 0.122, g: 0.137, b: 0.357 }  (indigo/950)
SURFACE_SUBTLE:         rgba(255,255,255,0.06)                        (white/6)
SURFACE_INPUT:          rgba(255,255,255,0.05)                        (white/5)
SURFACE_BORDER:         rgba(255,255,255,0.2)                         (white/20)
SURFACE_DIVIDER:        rgba(255,255,255,0.06)                        (white/6)

TEXT_PRIMARY:            #ffffff  → { r: 1, g: 1, b: 1 }              (white/100)
TEXT_SECONDARY:          #a4bcfd  → { r: 0.643, g: 0.737, b: 0.992 } (indigo/300)
TEXT_MUTED:              rgba(255,255,255,0.4)                         (white/40)

ACCENT_GRADIENT_FROM:    #1570ef  → { r: 0.082, g: 0.439, b: 0.937 } (blue/600)
ACCENT_GRADIENT_TO:      #444ce7  → { r: 0.267, g: 0.298, b: 0.906 } (indigo/600)
ACCENT_BORDER:           #a4bcfd  → { r: 0.643, g: 0.737, b: 0.992 } (indigo/300)
ACCENT_GLOW:             #8098f9  → { r: 0.502, g: 0.596, b: 0.976 } (indigo/400)
ACCENT_DEEP_SHADOW:      #102a56  → { r: 0.063, g: 0.165, b: 0.337 } (blue/950)

INNER_HIGHLIGHT:         #c7d7fe  → { r: 0.780, g: 0.843, b: 0.996 } (indigo/200)
INNER_SHADOW:            #3538cd  → { r: 0.208, g: 0.220, b: 0.804 } (indigo/700)

TOGGLE_ON_BG:            #6172f3  → { r: 0.380, g: 0.447, b: 0.953 } (indigo/500)
TOGGLE_ON_KNOB:          #f5f8ff  → { r: 0.961, g: 0.973, b: 1.000 } (indigo/25)
TOGGLE_OFF_BG:           rgba(255,255,255,0.06)                       (white/6)
TOGGLE_OFF_KNOB:         #ffffff                                       (white/100)

PANEL_GLOW:              0px 0px 36px #1570ef  (blue/600, on menu panels)
```

### Button Shadow Stack (Avia Aces)
```
Outer:
  0px 4px 3px rgba(3,4,8,0.3)         — soft drop shadow
  0px 2px 0px #102a56                  — hard edge shadow (blue/950)
  0px 0px 30px #8098f9                 — glow (indigo/400)

Inner:
  inset 0px 3px 1px #c7d7fe           — top highlight (indigo/200)
  inset 0px -3px 1px #3538cd          — bottom shadow (indigo/700)

Text shadow:
  0px 1px 0px #062c41                 — blue-light/950
```

---

## Palette B: Bumblebee (Green/Nature)

Bee/flower theme. Bright nature tones, green accents, warm shadows.

### Colors (0-1 range for Figma Plugin API)

```
PAGE_BACKGROUND:        #2d2d4a  → { r: 0.176, g: 0.176, b: 0.290 }  (dark slate)

SURFACE_PRIMARY:        #15290a  → { r: 0.082, g: 0.161, b: 0.039 }  (green-light/950)

TEXT_PRIMARY:            #ffffff  → { r: 1, g: 1, b: 1 }              (white/100)

ACCENT_GRADIENT_FROM:    #66c61c  → { r: 0.400, g: 0.776, b: 0.110 } (green-light/500)
ACCENT_GRADIENT_TO:      #099250  → { r: 0.035, g: 0.573, b: 0.314 } (green/600)
ACCENT_BORDER:           #15290a  → { r: 0.082, g: 0.161, b: 0.039 } (green-light/950)
ACCENT_GLOW:             #3ccb7f  → { r: 0.235, g: 0.796, b: 0.498 } (green/400)

INNER_HIGHLIGHT:         #d0f8ab  → { r: 0.816, g: 0.973, b: 0.671 } (green-light/200)
INNER_SHADOW:            #326212  → { r: 0.196, g: 0.384, b: 0.071 } (green-light/800)
```

### Button Shadow Stack (Bumblebee)
```
Outer:
  0px 4px 3px rgba(8,6,3,0.3)         — warm drop shadow
  0px 2px 0px #15290a                  — hard edge (green-light/950)
  0px 0px 30px #3ccb7f                 — green glow (green/400)

Inner:
  inset 0px 3px 1px #d0f8ab           — top highlight (green-light/200)
  inset 0px -3px 1px #326212          — bottom shadow (green-light/800)

Text shadow:
  0px 2px 0px #15290a                 — green-light/950
```

---

## Typography

All game boards use the same type system:

| Role | Font | Size | Weight | Tracking | Case | Color |
|------|------|------|--------|----------|------|-------|
| Screen title | Janda Manatee Solid Cyrillic | 24px | Regular | -0.96px | UPPERCASE | white/100 |
| Body / row label | Janda Manatee Solid Cyrillic | 16px | Regular | -0.64px | UPPERCASE | white/100 |
| Small label | Janda Manatee Solid Cyrillic | 14px | Regular | -0.56px | UPPERCASE | white/100 or indigo/300 |
| Tab label | Janda Manatee Solid Cyrillic | 18px | Regular | -0.72px | UPPERCASE | white |
| Button label (main) | Janda Manatee Solid Cyrillic | 20px | Regular | — | UPPERCASE | white |
| Button label (large) | Janda Manatee Solid Cyrillic | 32px | Regular | — | UPPERCASE | white |
| Input amount | Janda Manatee Solid Cyrillic | 22px | Regular | -0.88px | UPPERCASE | white |
| Win amount (huge) | Janda Manatee Solid Cyrillic | 88px | Regular | — | UPPERCASE | white |

**Line height**: Always `leading-[normal]` (auto line height in Figma: `{ unit: "AUTO" }`)

**Loading font in Plugin API**:
```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
```

---

## Spacing Constants

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
| Button height (standard) | 56px | Primary CTA (Avia Aces) |
| Button height (large) | 104px | Jackpot CTA (Bumblebee) |
| Input height (large) | ~48px | Unput L with +/- buttons |
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

To create a new theme for a different game, keep the same structure but swap these values:

1. **PAGE_BACKGROUND** — The overall canvas color
2. **SURFACE_PRIMARY** — Panel/card backgrounds
3. **ACCENT_GRADIENT_FROM / TO** — Button gradient and interactive highlights
4. **ACCENT_BORDER** — Button and input borders
5. **ACCENT_GLOW** — Glow shadow color
6. **INNER_HIGHLIGHT / INNER_SHADOW** — 3D button depth colors
7. **Background artwork** — Full-bleed background images
8. **Game logo** — Unique per game
9. **Game symbols** — Characters, items, etc.

The structural layout, component dimensions, typography, and spacing stay the same across all themes.
