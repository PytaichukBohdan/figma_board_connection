#!/usr/bin/env bash
# Gemini Image Generation Script
# Generates images using Google's Gemini API via REST
# Dependencies: curl, base64 (no jq required)

set -euo pipefail

# --- Defaults ---
MODEL=""
API_KEY=""
PROMPT=""
OUTPUT=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# --- Parse arguments ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p) PROMPT="$2"; shift 2 ;;
    -o) OUTPUT="$2"; shift 2 ;;
    -m) MODEL="$2"; shift 2 ;;
    -k) API_KEY="$2"; shift 2 ;;
    *) echo "{\"error\": \"Unknown argument: $1\"}" >&2; exit 1 ;;
  esac
done

# --- Validate required args ---
if [[ -z "$PROMPT" ]]; then
  echo "{\"error\": \"API_ERROR\", \"message\": \"Prompt is required. Use -p 'your prompt'\"}" >&2
  exit 1
fi

if [[ -z "$OUTPUT" ]]; then
  echo "{\"error\": \"API_ERROR\", \"message\": \"Output path is required. Use -o 'filename.png'\"}" >&2
  exit 1
fi

# --- Resolve API key ---
# Priority: CLI flag > env var > local config file
if [[ -z "$API_KEY" ]]; then
  if [[ -n "${GEMINI_API_KEY:-}" ]]; then
    API_KEY="$GEMINI_API_KEY"
  elif [[ -f "$PROJECT_ROOT/.claude/gemini-image-gen.local.md" ]]; then
    API_KEY=$(grep -oP 'api_key:\s*\K\S+' "$PROJECT_ROOT/.claude/gemini-image-gen.local.md" 2>/dev/null || true)
  fi
fi

if [[ -z "$API_KEY" || "$API_KEY" == "your-key-here" ]]; then
  echo "{\"error\": \"API_KEY_MISSING\", \"message\": \"No Gemini API key found. Set GEMINI_API_KEY env var or create .claude/gemini-image-gen.local.md\"}" >&2
  exit 1
fi

# --- Resolve model ---
if [[ -z "$MODEL" ]]; then
  if [[ -f "$PROJECT_ROOT/.claude/gemini-image-gen.local.md" ]]; then
    MODEL=$(grep -oP 'model:\s*\K\S+' "$PROJECT_ROOT/.claude/gemini-image-gen.local.md" 2>/dev/null || true)
  fi
  MODEL="${MODEL:-gemini-3-pro-image-preview}"
fi

# --- Detect base64 decode command ---
if base64 --decode </dev/null >/dev/null 2>&1; then
  B64_DECODE="base64 --decode"
elif base64 -d </dev/null >/dev/null 2>&1; then
  B64_DECODE="base64 -d"
elif base64 -D </dev/null >/dev/null 2>&1; then
  B64_DECODE="base64 -D"
else
  echo "{\"error\": \"DECODE_ERROR\", \"message\": \"No compatible base64 decode command found\"}" >&2
  exit 1
fi

# --- Escape prompt for JSON ---
ESCAPED_PROMPT=$(printf '%s' "$PROMPT" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\n/\\n/g; s/\t/\\t/g; s/\r/\\r/g')

# --- Build request body ---
REQUEST_BODY=$(cat <<JSONEOF
{
  "contents": [
    {
      "parts": [
        {
          "text": "${ESCAPED_PROMPT}"
        }
      ]
    }
  ],
  "generationConfig": {
    "responseModalities": ["image", "text"]
  }
}
JSONEOF
)

# --- Call Gemini API ---
API_URL="https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent?key=${API_KEY}"

RESPONSE=$(curl -s -w "\n%{http_code}" \
  -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d "$REQUEST_BODY" 2>&1) || {
  echo "{\"error\": \"NETWORK_ERROR\", \"message\": \"Failed to reach Gemini API. Check your internet connection.\"}" >&2
  exit 1
}

# --- Extract HTTP status code ---
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" -ne 200 ]]; then
  ERROR_MSG=$(echo "$BODY" | grep -o '"message"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"message"[[:space:]]*:[[:space:]]*"//; s/"$//')
  echo "{\"error\": \"API_ERROR\", \"http_code\": $HTTP_CODE, \"message\": \"${ERROR_MSG:-Gemini API returned HTTP $HTTP_CODE}\"}" >&2
  exit 1
fi

# --- Extract base64 image data ---
# Look for inlineData with image mimeType
IMAGE_DATA=$(echo "$BODY" | grep -o '"data"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"data"[[:space:]]*:[[:space:]]*"//; s/"$//')

if [[ -z "$IMAGE_DATA" ]]; then
  echo "{\"error\": \"DECODE_ERROR\", \"message\": \"No image data found in API response. The model may have returned text only.\"}" >&2
  exit 1
fi

# --- Decode and save image ---
mkdir -p "$(dirname "$OUTPUT")"
echo "$IMAGE_DATA" | $B64_DECODE > "$OUTPUT" 2>/dev/null || {
  echo "{\"error\": \"DECODE_ERROR\", \"message\": \"Failed to decode base64 image data\"}" >&2
  exit 1
}

# --- Verify output ---
if [[ ! -f "$OUTPUT" ]] || [[ ! -s "$OUTPUT" ]]; then
  echo "{\"error\": \"DECODE_ERROR\", \"message\": \"Output file is empty or was not created\"}" >&2
  exit 1
fi

FILE_SIZE=$(wc -c < "$OUTPUT" | tr -d ' ')

# --- Success output ---
echo "{\"success\": true, \"output_path\": \"$OUTPUT\", \"model\": \"$MODEL\", \"file_size\": $FILE_SIZE}"
