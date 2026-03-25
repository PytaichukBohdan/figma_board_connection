---
description: Build a complete design in Figma. Proactively triggered when user says "create in Figma", "build a screen", "design a page", "build a landing page", "create a dashboard".
model: opus
argument-hint: "[description] [figma-url]"
---

# /figma-create — Build Design in Figma

You are orchestrating a multi-phase, parallel agent workflow to create a complete design in a Figma file.

**Input:** A description of what to build and a Figma file URL (with fileKey).

## Phase 1 — Discover (PARALLEL)

Launch these two agents simultaneously:

1. **figma-scout agent:**
   - Explore the Figma file structure
   - Discover pages, frames, existing components
   - Map design system assets (components, variables, styles)
   - Return: file map + DS inventory

2. **figma-researcher agent:**
   - Broad search for all available DS components, variables, styles
   - Fetch external references if URLs provided in the description
   - Check local `briefs/` directory for existing design briefs
   - Return: comprehensive component/variable/style key catalog

Wait for both agents to complete before proceeding.

## Phase 2 — Plan (SEQUENTIAL)

Analyze both agent outputs and plan the screen layout:

1. Review the available DS assets (components, variables, styles with keys)
2. Break the requested design into logical sections:
   - Header/Navigation
   - Hero/Banner (if applicable)
   - Content sections (cards, lists, data, etc.)
   - Sidebar (if applicable)
   - Footer
3. For each section, define:
   - Section name
   - DS components to use (with keys)
   - DS variables to bind (with keys)
   - Content requirements
   - Layout structure (auto-layout direction, sizing)
4. Create a TaskCreate for each section with the full spec

## Phase 3 — Build Wrapper (SEQUENTIAL)

Load the `figma-use` skill, then create the page wrapper frame:
- Create a new page or use an existing one
- Create a wrapper frame (1440px wide, vertical auto-layout, HUG height)
- Position it to avoid overlapping existing content
- Return the wrapper frame ID

## Phase 4 — Build Sections (PARALLEL fan-out)

Launch one `team/figma-section-builder` agent per section, all in parallel:
- Each agent receives: wrapper frame ID, fileKey, section spec, component keys, variable keys
- Each agent builds its section, appends to wrapper, validates with screenshot
- Each agent reports completion via TaskUpdate

Wait for all section builders to complete.

## Phase 5 — Validate (PARALLEL fan-out)

Launch one `team/figma-section-reviewer` agent per completed section:
- Each reviewer screenshots its section
- Checks against the section spec
- Reports PASS/FAIL via TaskUpdate

Wait for all reviewers to complete.

## Phase 6 — Polish & Report (SEQUENTIAL)

1. Review all section reviewer results
2. For any FAIL findings, make targeted fixes via `use_figma`
3. Take a final full-frame screenshot: `get_screenshot(nodeId=wrapperId, fileKey)`
4. Report to user:
   - Summary of what was built
   - Full-frame screenshot
   - Section-by-section status
   - DS coverage stats
   - Any remaining issues or suggestions

## Error Handling

- If a section builder fails, retry once. If it fails again, build that section yourself directly.
- If DS components aren't found, fall back to creating custom frames with proper styling.
- Always validate — never report completion without a final screenshot.

## Key Rules

- Always scout before building
- Always validate after building
- Load `figma-use` skill before ANY `use_figma` call
- Pass `skillNames="figma-use"` to every `use_figma` call
- Use DS assets by key whenever available
- Build section-by-section, not all at once
- Parallel where possible, sequential where dependencies exist
