---
name: game-board
description: "Build complete mobile game board screens in Figma from scratch — splash, gameplay, menu, betting, popups, jackpots, and all supporting UI. Use this skill whenever the user asks to create a game board, build a game screen, design a crash/aviator game, make a slot game, create game UI, design a betting interface, build a leaderboard screen, or any request for mobile gambling/arcade game screens in Figma. This skill contains full construction recipes so every element can be built from primitives without importing external components. Also trigger for: 'new game', 'game theme', 'casino game', 'game layout', 'bet panel', 'jackpot screen', 'win celebration'."
---

# Game Board Builder

Build mobile game boards in Figma from scratch. This skill contains everything needed to construct complete game screens — exact dimensions, layout patterns, typography scales, shadows, auto-layout settings — using a parameterized theme system.

**MANDATORY**: Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.

## Adapt to Context

> **All color values, fonts, and theme-specific tokens in this skill and its reference files are EXAMPLES** drawn from the Avia Aces (indigo/blue aviation theme) and Bumblebee (green/nature theme) reference boards. When building for a new game, **derive these values from the user's theme, brand, or description**. A dragon game should use fiery reds and golds — not the indigo palette. A space game should use deep blacks and neon greens — not the Bumblebee greens.
>
> **What IS reusable across all games**: structural patterns (dimensions, layout modes, auto-layout settings, spacing, shadow *structure*, component hierarchy). **What should CHANGE per game**: color fills, gradient stops, font family, glow colors, shadow colors, background imagery.

## How This Skill Works

Every component is described as a **construction recipe** — you build it from Figma primitives (frames, rectangles, text) rather than importing from a library. This makes the skill immune to DS key changes. If the Cruhslab DS *is* linked, you may optionally `search_design_system` and import by name, but the recipes below are the fallback truth.

## Reference Files

Load these as needed based on what you're building:

| File | When to Load | What It Contains |
|------|-------------|-----------------|
| [component-recipes.md](references/component-recipes.md) | Before building any UI element | Full construction specs for every reusable component: Button, Header, Row, Tab, Input, Switcher, Popup |
| [screen-patterns.md](references/screen-patterns.md) | Before composing a full screen | Layout blueprints for each screen type: Main Game, Menu, Splash, Leaderboard, Betting Panel, Jackpot |
| [theme-system.md](references/theme-system.md) | At the start of any build | Color palettes, typography, spacing, and how to create a new theme for any game |

## Quick-Start Workflow

### 1. Understand the Request
Identify which screens the user needs. A "full game board" typically includes:
- Splash/loading screen
- Main gameplay screen (with betting controls)
- Menu screen (settings, links)
- 2-3 info screens (leaderboard, my bets, provably fair)
- Popups (alerts, win celebration, game rules)
- Optionally: jackpot system

### 2. Establish the Theme
Before building, define the theme with the user. Load [theme-system.md](references/theme-system.md) and determine:
- **Game name** and logo
- **Color palette** — derive from the game's identity (use the reference palettes as structural templates, but choose game-appropriate colors)
- **Font** — pick a font that matches the game's personality
- **Background artwork** (will be provided by the user or created as placeholder)
- **Game symbols/assets** (characters, items specific to the game)

### 3. Define Theme Variables
Before writing any `use_figma` code, define all theme variables at the top of your script:

```js
// ═══════════════════════════════════════════
// THEME VARIABLES — Derive from game context
// ═══════════════════════════════════════════
// Example values below are from Avia Aces (indigo/blue aviation theme).
// Replace with values appropriate for your game's identity.

const FONT = { family: "YOUR_GAME_FONT", style: "Regular" };
// Example (Avia Aces): { family: "Janda Manatee Solid Cyrillic", style: "Regular" }

const PAGE_BG          = { r: 0.094, g: 0.059, b: 0.502 };  // Example: deep indigo
const SURFACE          = { r: 0.122, g: 0.137, b: 0.357 };  // Example: dark indigo panel
const TEXT_PRIMARY     = { r: 1, g: 1, b: 1 };               // Usually white for dark themes
const TEXT_SECONDARY   = { r: 0.643, g: 0.737, b: 0.992 };  // Example: indigo/300
const ACCENT_FROM      = { r: 0.082, g: 0.439, b: 0.937 };  // Example: blue/600
const ACCENT_TO        = { r: 0.267, g: 0.298, b: 0.906 };  // Example: indigo/600
const ACCENT_BORDER    = { r: 0.643, g: 0.737, b: 0.992 };  // Example: indigo/300
const ACCENT_GLOW      = { r: 0.502, g: 0.596, b: 0.976 };  // Example: indigo/400
const DEEP_SHADOW      = { r: 0.063, g: 0.165, b: 0.337 };  // Example: blue/950
const INNER_HIGHLIGHT  = { r: 0.780, g: 0.843, b: 0.996 };  // Example: indigo/200
const INNER_SHADOW     = { r: 0.208, g: 0.220, b: 0.804 };  // Example: indigo/700

await figma.loadFontAsync(FONT);
```

### 4. Build Incrementally
Work screen by screen, one `use_figma` call per major section:

1. **Create page wrapper** (375x812 mobile frame, VERTICAL auto-layout)
2. **Build Header** — load [component-recipes.md](references/component-recipes.md) -> Header section
3. **Build Game Area** — theme-specific content (backgrounds, game elements)
4. **Build Betting Controls** — load component recipes -> Input, Tab, Button, Switcher sections
5. **Validate** with `get_screenshot` after each section
6. **Repeat** for each screen type

### 5. Validate Everything
After each section, screenshot it. Look for:
- Cropped/clipped text
- Overlapping elements
- Wrong colors (should match the theme palette)
- Missing content

## Screen Types at a Glance

| Screen | Complexity | Key Sections |
|--------|-----------|-------------|
| **Splash** | Simple | Background + logo + loading bar or CTA button |
| **Main Game** | Complex | Header + game area + betting controls (bottom) |
| **Menu** | Medium | Header + settings rows (toggles) + navigation rows (links) |
| **Leaderboard** | Medium | Header + tab bar + data table rows |
| **My Bets** | Medium | Header + tab bar + data table rows (with status colors) |
| **Provably Fair** | Simple | Header + rich text + input field + verify button |
| **Game Rules** | Simple | Header + rich text with illustrations |
| **Popup** | Simple | Dark backdrop + centered card + buttons |
| **Jackpot Grid** | Complex | Tier badges + 5x3 symbol grid + spin button |
| **Win Celebration** | Medium | Dark overlay + win graphic + amount text + collect button |

## DS-First Strategy (Optional)

If the file has the Cruhslab DS linked, try importing by name first:

```js
// Try to import from DS by searching
// If found, use the imported component
// If not found, fall back to the construction recipe
```

Search terms to try: "Button", "Header", "Row", "Tab", "Swither", "Unput", "Popup", "Alert", "Table", "keyboaard", "Progress", "Switch cells", "Drop", "Common"

The construction recipes in this skill match the DS components exactly, so the visual result is identical whether you import or build from scratch.

## Font

The reference boards use **"Janda Manatee Solid Cyrillic"** (Regular weight) — a playful, rounded sans-serif suited for casual games. **This is not a requirement.** Choose a font that matches the game's personality:

- Playful/casual game -> rounded, bold fonts (like Janda Manatee, Fredoka One, Luckiest Guy)
- Sci-fi/space game -> futuristic, geometric fonts (like Orbitron, Exo, Rajdhani)
- Fantasy/medieval game -> serif or decorative fonts (like MedievalSharp, Cinzel, Uncial Antiqua)
- Luxury/casino game -> elegant serif or display fonts (like Playfair Display, Cormorant)
- If unsure, use "Inter" as a safe, professional fallback

Always load your chosen font before setting text:
```js
// Use the game's brand font
const FONT = { family: "YOUR_GAME_FONT", style: "Regular" };
await figma.loadFontAsync(FONT);
// Fallback if font unavailable:
// await figma.loadFontAsync({ family: "Inter", style: "Regular" });
```

## Error Recovery

If a `use_figma` call fails:
1. STOP — do not retry immediately
2. Read the error message
3. Common issues: font not loaded, FILL set before appendChild, color values > 1
4. Fix and retry — failed scripts are atomic (no partial changes)
