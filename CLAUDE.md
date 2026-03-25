# Figma Board Connection

## Figma Agent Team — Proactive Routing

When a user asks a Figma-related task, automatically assess scope and route:

### Small tasks (direct MCP tool call, no agents):
- "Take a screenshot" → `get_screenshot(nodeId, fileKey)`
- "Search for button components" → `search_design_system("button", fileKey)`
- "What variables exist?" → `get_variable_defs(nodeId, fileKey)`
- "Show me the file structure" → `get_metadata("0:1", fileKey)`
- "Create a new blank file" → `create_new_file(...)`
- "Create a diagram" → `generate_diagram(name, mermaid)`
- "Who am I?" → `whoami()`

### Medium tasks (1-3 agents in parallel):
- "What's in this Figma file?" → launch **figma-scout** agent
- "Find all components I can use" → launch **figma-researcher** agent
- "Create a simple component" → **figma-researcher** (find DS assets) + **figma-builder** (create)
- "Quick check this screen" → **figma-scout** + **figma-reviewer**
- "What design tokens are available?" → launch **figma-researcher** agent

### Large tasks (full command orchestration with parallel fan-out):
- "Create a dashboard/page/screen in Figma" → `/figma-create`
- "Build a landing page" → `/figma-create`
- "Design a checkout flow" → `/figma-create`
- "Audit my design file" → `/figma-audit`
- "Review my design for DS compliance" → `/figma-audit`
- "Check quality of my screens" → `/figma-audit`
- "I want to design a new [concept]" → `/figma-brainstorm`
- "Explore ideas for a dashboard" → `/figma-brainstorm`
- "Redesign the checkout flow" → `/figma-brainstorm` → `/figma-create`

### Routing Rules:
1. **Always scout before building** — `get_metadata` + `search_design_system` must run before any `use_figma` write
2. **Always validate after building** — `get_screenshot` must confirm every section built
3. **For multi-section screens**, use parallel `team/figma-section-builder` agents (one per section)
4. **Load `figma-use` skill before ANY `use_figma` call** — this is mandatory, not optional
5. **Pass `skillNames` parameter** to `use_figma` for logging (e.g., `skillNames="figma-use"`)
6. **Use DS assets by key** whenever `search_design_system` returns matching components/variables
7. **Save design briefs** to `briefs/` directory for reference across sessions

### Agent Team Reference:
| Agent | Purpose | Key Tools |
|-------|---------|-----------|
| `figma-scout` | File explorer, DS inventory | get_metadata, search_design_system, get_variable_defs, get_screenshot |
| `figma-researcher` | Pre-build research, DS catalog | search_design_system, get_variable_defs, WebFetch, WebSearch |
| `figma-builder` | Create/edit designs | use_figma, search_design_system, get_screenshot |
| `figma-reviewer` | QA validation (read-only) | get_screenshot, get_metadata, get_design_context |
| `team/figma-section-builder` | Build ONE section | use_figma, get_screenshot, TaskGet/TaskUpdate |
| `team/figma-section-reviewer` | Validate ONE section (read-only) | get_screenshot, get_metadata, TaskGet/TaskUpdate |
| `meta-agent` | Create new agents | Write, WebFetch |
| `docs-scraper` | Fetch documentation | WebFetch, Write |

### Commands Reference:
| Command | Trigger | What It Does |
|---------|---------|--------------|
| `/figma-create` | "create", "build", "design a page" | Multi-phase parallel build workflow |
| `/figma-audit` | "audit", "review", "check", "QA" | Multi-reviewer parallel audit |
| `/figma-brainstorm` | "brainstorm", "explore ideas", "I want to design" | Structured questioning → design brief |

### Design System Integration:
- The project has 8 Figma skills installed for reference patterns
- Key skill: `figma-use` — MUST be loaded before every `use_figma` call
- Key skill: `figma-generate-design` — workflow for full page generation
- Key skill: `audit-design-system` — patterns for DS compliance checking
- Key skill: `apply-design-system` — patterns for connecting DS components
- Key skill: `taste-frontend` — premium design quality principles (anti-AI-cliche)

### For Non-Technical Users:
This system is designed for designers, PMs, and creative directors. When interacting:
- Accept natural language descriptions ("make it look like Apple's website")
- Translate vague requests into specific DS-backed designs
- Show screenshots at every step for visual confirmation
- Explain technical decisions in design terms, not code terms
