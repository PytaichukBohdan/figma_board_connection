---
allowed-tools: Bash(*), Read
description: Generate an image using Google's Gemini API
---

# /generate-image

Generate an image using the Gemini API.

## Usage

```
/generate-image <prompt> [--model <model>] [--output <filename>]
```

## Instructions

Parse `$ARGUMENTS` for:
- **prompt**: Everything that isn't a flag (required)
- **--model**: Model override (optional, default: `gemini-3-pro-image-preview`)
- **--output**: Output filename (optional, auto-generated if omitted)

### Steps

1. **Parse arguments** from: $ARGUMENTS

2. **If no prompt provided**, ask the user what image they'd like to generate.

3. **If no output filename**, generate a descriptive kebab-case name from the prompt (e.g., "a sunset over mountains" → `sunset-over-mountains.png`). Always use `.png` extension.

4. **Run generation**:
   ```bash
   bash ${CLAUDE_PROJECT_ROOT}/scripts/generate-image.sh \
     -p "<prompt>" \
     -o "<output-filename>"
   ```
   Add `-m <model>` if a model was specified.

5. **On success**:
   - Read and display the generated image to the user
   - Report the file path, model used, and file size

6. **On error**:
   - If `API_KEY_MISSING`: Guide the user to set up their Gemini API key:
     ```
     export GEMINI_API_KEY="your-key-here"
     ```
     Or create `.claude/gemini-image-gen.local.md` with the key in YAML frontmatter.
   - If `API_ERROR`: Show the error and suggest prompt adjustments
   - If `NETWORK_ERROR`: Suggest checking internet connection
