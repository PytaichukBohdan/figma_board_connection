---
name: game-board
description: "Build complete mobile game board screens in Figma from scratch — splash, gameplay, menu, betting, popups, jackpots, and all supporting UI. Use this skill whenever the user asks to create a game board, build a game screen, design a crash/aviator game, make a slot game, create game UI, design a betting interface, build a leaderboard screen, or any request for mobile gambling/arcade game screens in Figma. This skill contains full construction recipes so every element can be built from primitives without importing external components. Also trigger for: 'new game', 'game theme', 'casino game', 'game layout', 'bet panel', 'jackpot screen', 'win celebration'."
---

# Game Board Builder

Build mobile game boards in Figma from scratch. This skill contains everything needed to construct complete game screens — exact dimensions, colors, typography, shadows, auto-layout settings — derived from the Avia Aces and Bumblebee reference boards.

**MANDATORY**: Load [figma-use](../figma-use/SKILL.md) before any `use_figma` call.

## How This Skill Works

Every component is described as a **construction recipe** — you build it from Figma primitives (frames, rectangles, text) rather than importing from a library. This makes the skill immune to DS key changes. If the Cruhslab DS *is* linked, you may optionally `search_design_system` and import by name, but the recipes below are the fallback truth.

## Reference Files

Load these as needed based on what you're building:

| File | When to Load | What It Contains |
|------|-------------|-----------------|
| [component-recipes.md](references/component-recipes.md) | Before building any UI element | Full construction specs for every reusable component: Button, Header, Row, Tab, Input, Switcher, Popup |
| [screen-patterns.md](references/screen-patterns.md) | Before composing a full screen | Layout blueprints for each screen type: Main Game, Menu, Splash, Leaderboard, Betting Panel, Jackpot |
| [theme-system.md](references/theme-system.md) | At the start of any build | Color palettes, typography, spacing, and how to swap themes between games |

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
- **Color palette** (use one of the two reference palettes or create a new one)
- **Background artwork** (will be provided by the user or created as placeholder)
- **Game symbols/assets** (characters, items specific to the game)

### 3. Build Incrementally
Work screen by screen, one `use_figma` call per major section:

1. **Create page wrapper** (375x812 mobile frame, VERTICAL auto-layout)
2. **Build Header** — load [component-recipes.md](references/component-recipes.md) → Header section
3. **Build Game Area** — theme-specific content (backgrounds, game elements)
4. **Build Betting Controls** — load component recipes → Input, Tab, Button, Switcher sections
5. **Validate** with `get_screenshot` after each section
6. **Repeat** for each screen type

### 4. Validate Everything
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

All text in both reference boards uses **"Janda Manatee Solid Cyrillic"** (Regular weight). This is a playful, rounded sans-serif. If not available in the target file, substitute with a similar rounded/playful font, or use "Inter" as a safe fallback.

Always load fonts before setting text:
```js
await figma.loadFontAsync({ family: "Janda Manatee Solid Cyrillic", style: "Regular" });
// Fallback:
// await figma.loadFontAsync({ family: "Inter", style: "Regular" });
```

## Error Recovery

If a `use_figma` call fails:
1. STOP — do not retry immediately
2. Read the error message
3. Common issues: font not loaded, FILL set before appendChild, color values > 1
4. Fix and retry — failed scripts are atomic (no partial changes)
