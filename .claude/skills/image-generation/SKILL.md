---
name: gemini-image-generation
version: 1.0.0
description: Generate images using Google's Gemini API with smart prompt crafting that analyzes your frontend codebase for design context
triggers:
  - "generate an image"
  - "create a picture"
  - "make an illustration"
  - "draw something"
  - "create a visual"
  - "generate artwork"
  - "I need images for my website"
  - "add a hero image"
---

# Gemini Image Generation Skill

Generate high-quality images using Google's Gemini API directly from Claude Code, with intelligent prompt crafting that understands your project's design context.

## Prerequisites

Set up your Gemini API key using ONE of these methods:

1. **Environment variable** (recommended):
   ```bash
   export GEMINI_API_KEY="your-key-here"
   ```
   Or add to your `.env` file.

2. **Local config file** — create `.claude/gemini-image-gen.local.md`:
   ```yaml
   ---
   api_key: your-key-here
   model: gemini-3-pro-image-preview
   ---
   ```

Get a free API key at: https://aistudio.google.com/apikey

## Available Models

| Model | Best For | Notes |
|-------|----------|-------|
| `gemini-3-pro-image-preview` | Highest quality (default) | Best results, recommended |
| `gemini-2.5-flash-image` | Fast generation | Lower quality, faster |
| `gemini-3.1-flash-preview` | Latest features | Preview, may change |

## How This Skill Works

### Smart Prompt Crafting Decision

When triggered, assess the user's request:

**If the prompt is detailed and specific** (includes subject, style, colors, composition):
- Proceed directly to image generation
- Use the prompt as-is or with minor enhancements

**If the prompt is vague or context-dependent** (e.g., "generate a hero image", "I need an icon"):
- Launch the `image-prompt-crafter` sub-agent
- It will attempt to extract design context from a Figma board (via `get_design_context` or `get_screenshot`) if the user has provided one
- If no Figma board or design system is available, **ask the user** for a Figma board URL or design system reference to pull colors, typography, and style from
- Ask the user 2-3 targeted questions
- Craft an optimized prompt

**If triggered by placeholder detection** (found `src="placeholder"`, empty `src=""`, `TODO: image` in code):
- Always launch `image-prompt-crafter` to understand the context
- Analyze the surrounding component/page to determine what image is needed

### Generation

Run the generation script:

```bash
bash ${CLAUDE_PROJECT_ROOT}/scripts/generate-image.sh \
  -p "your detailed prompt here" \
  -o "output-filename.png" \
  -m "gemini-3-pro-image-preview"
```

Arguments:
- `-p` (required): The image generation prompt
- `-o` (required): Output file path (PNG)
- `-m` (optional): Model override
- `-k` (optional): API key override

### Output Handling

1. Generate a descriptive kebab-case filename if none provided (e.g., `sunset-mountain-landscape.png`)
2. Save to a sensible location (project assets folder if one exists, otherwise current directory)
3. Display the generated image to the user
4. Report file size and model used

## Configuration

Create `.claude/gemini-image-gen.local.md` for persistent settings:

```yaml
---
api_key: your-gemini-api-key
model: gemini-3-pro-image-preview
---
```

## Error Handling

| Error | Cause | Fix |
|-------|-------|-----|
| `API_KEY_MISSING` | No key found | Set `GEMINI_API_KEY` env var or config file |
| `API_ERROR` | Gemini rejected request | Check prompt for policy violations |
| `NETWORK_ERROR` | Can't reach API | Check internet connection |
| `DECODE_ERROR` | Response parsing failed | Try again or switch model |

## Tips for Better Results

- **Be specific about style**: "watercolor illustration" vs just "illustration"
- **Include exclusions**: "no text, no watermarks, no borders"
- **Mention use case**: "for a mobile app splash screen" helps with composition
- **Reference colors with hex codes**: "primary color #6366F1" for precise matching
- **Keep prompts under 200 words** for best results
- **Specify aspect ratio** if needed: "16:9 landscape", "1:1 square", "9:16 portrait"
