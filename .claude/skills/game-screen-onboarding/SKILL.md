---
name: game-screen-onboarding
description: Build an onboarding splash and tutorial flow for a game with mobile and desktop variants. Use when asked to "add onboarding", "create splash screen", or "build tutorial flow". Requires Figma MCP server.
metadata:
  mcp-server: figma
---

# Game Screen: Onboarding & Tutorial

Build splash screens and tutorial flows for game onboarding.

## When to use

- "add onboarding"
- "create splash screen"
- "build tutorial flow"
- "add loading screen"
- Any request for game intro/tutorial screens

## Splash screen (desktop 1024x768)

```text
+----------------------------------------------------------+
|                                                          |
|              [dark gradient background]                  |
|                                                          |
|                     GAME                                 |
|                     LOGO                                 |
|                                                          |
|                   [provider]                             |
|                  ----------                              |
|                 [loading bar]                            |
|                                                          |
+----------------------------------------------------------+
```

## Tutorial screen (desktop 1024x768)

```text
+----------------------------------------------------------+
|                   [game logo]                            |
|                   [provider]                             |
|                                                          |
| +----------------+ +----------------+ +----------------+ |
| | [illustration] | | [illustration] | | [illustration] | |
| |                | |                | |                | |
| | Step 1 text    | | Step 2 text    | | Step 3 text    | |
| | Pick a plane.  | | Press BOOST    | | Each boost is  | |
| | Faster plane   | | during the     | | your choice.   | |
| | means faster   | | flight to go   | | Once the plane | |
| | multiplier...  | | further...     | | lands, you     | |
| |                | |                | | get winnings   | |
| +----------------+ +----------------+ +----------------+ |
|                                                          |
|                  PRESS TO START                          |
+----------------------------------------------------------+
```

## Mobile variants (375x812)

Same content adapted for narrow screens:
- Splash: logo and loading bar centered vertically
- Tutorial: single-column or paginated cards

## Tutorial step pattern

| Step | Title | Description |
|------|-------|-------------|
| 1 | Pick a plane / Select character | Card illustration showing selection |
| 2 | Press boost / Interact | Gameplay illustration showing action |
| 3 | Cash out / Collect | Result illustration showing reward |

## Visual references

| What | File Key | Node ID |
|------|----------|---------|
| Onboarding section | `HbStpqwXkiU8WCBGJyWfum` | `933:5511` |
| Mobile splash | `HbStpqwXkiU8WCBGJyWfum` | `933:5512` |
| Web tutorial | `HbStpqwXkiU8WCBGJyWfum` | `933:5526` |
| Mobile tutorial | `HbStpqwXkiU8WCBGJyWfum` | `933:5540` |
| Web splash | `HbStpqwXkiU8WCBGJyWfum` | `933:5549` |

## Workflow

1. Load `figma-use` skill
2. Screenshot reference nodes (especially `933:5512` and `933:5526`)
3. Build splash screen: dark background, centered logo, provider logo, loading bar
4. Build tutorial screen: logo top, 3 step cards in a row, "PRESS TO START" CTA
5. Build mobile variants at 375x812
6. Screenshot each screen for QA
