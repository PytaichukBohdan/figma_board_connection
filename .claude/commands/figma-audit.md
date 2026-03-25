---
description: Audit a Figma design for DS compliance, visual consistency, and token coverage. Proactively triggered when user says "review my design", "check my Figma", "audit design system", "QA this screen".
model: opus
argument-hint: "[figma-url]"
---

# /figma-audit — Audit Figma Design

You are orchestrating a multi-phase audit workflow to thoroughly review a Figma design for quality, design system compliance, and visual consistency.

**Input:** A Figma file URL (with fileKey) and optionally a specific frame nodeId.

## Phase 1 — Scout (SEQUENTIAL)

Launch the **figma-scout** agent:
- `get_metadata("0:1", fileKey)` — full file structure
- `get_variable_defs("0:1", fileKey)` — local variables
- `search_design_system` — available DS assets
- Return: file structure map, DS inventory, frame list

Wait for scout to complete. Use its output to identify all frames to audit.

## Phase 2 — Audit (PARALLEL fan-out)

Launch three **figma-reviewer** agents in parallel, each with a different focus:

### Reviewer 1: DS Compliance
- For each frame in the design:
  - `get_metadata(frameId, fileKey)` — find all INSTANCE nodes
  - `search_design_system` — compare used components vs available DS components
  - `get_screenshot(frameId, fileKey)` — visual check for detached components
- Report: detached components, local overrides, components not from DS, duplicate local components

### Reviewer 2: Visual Consistency
- For each frame in the design:
  - `get_screenshot(frameId, fileKey)` — visual pattern analysis
  - `get_metadata(frameId, fileKey)` — spacing, sizing, alignment data
- Report: inconsistent spacing, typography mismatches, color inconsistencies, alignment issues, broken layouts

### Reviewer 3: Token Coverage
- `get_variable_defs("0:1", fileKey)` — local variables
- `search_design_system("color", fileKey, includeVariables=true)`
- `search_design_system("spacing", fileKey, includeVariables=true)`
- `search_design_system("radius", fileKey, includeVariables=true)`
- `get_metadata` on key frames to identify hardcoded values
- Report: hardcoded hex colors, hardcoded spacing, hardcoded radii, unbound tokens

Wait for all three reviewers to complete.

## Phase 3 — Aggregate Report (SEQUENTIAL)

Combine all reviewer findings into a single comprehensive report:

1. **Deduplicate** findings across reviewers
2. **Severity ranking:** Critical > High > Medium > Low
3. **Calculate scores:**
   - DS Component Coverage: X% (instances from DS / total instances)
   - Token Binding Coverage: X% (bound variables / total variable-eligible properties)
   - Visual Consistency Score: X% (consistent patterns / total patterns checked)
   - Overall Health Score: weighted average
4. **Prioritize recommendations** — most impactful fixes first

## Final Report Format

```
## Figma Design Audit Report

**File:** [fileName] ([fileKey])
**Date:** [date]
**Frames Audited:** [count]

### Health Scores
| Category | Score | Grade |
|----------|-------|-------|
| DS Component Coverage | X% | A/B/C/D/F |
| Token Binding Coverage | X% | A/B/C/D/F |
| Visual Consistency | X% | A/B/C/D/F |
| **Overall Health** | **X%** | **A/B/C/D/F** |

### Critical Findings
| # | Category | Finding | Location | Fix |
|---|----------|---------|----------|-----|
| ... | ... | ... | ... | ... |

### High Findings
| # | Category | Finding | Location | Fix |
|---|----------|---------|----------|-----|
| ... | ... | ... | ... | ... |

### Medium Findings
[table]

### Low Findings
[table]

### Screenshots
[Per-frame screenshots with annotated findings]

### Recommendations (Prioritized)
1. [Most impactful fix first]
2. ...

### Next Steps
- Run `/figma-create` to rebuild sections with proper DS compliance
- Update design system tokens if gaps are found
- Re-audit after fixes to verify improvement
```

## Key Rules

- Always scout before auditing
- Use parallel reviewers for speed
- Never modify the design during audit — read-only
- Include screenshots with every finding
- Provide actionable, specific recommendations
- Score objectively based on measurable criteria
