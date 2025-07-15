#!/usr/bin/env bash
set -e

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="bloat-output.txt"

echo "### 📦 Binary Size Analysis (cargo bloat)" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo bloat --release --crates >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"
