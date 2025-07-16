#!/usr/bin/env bash
set -e

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="outdated-output.txt"

echo "### 🧓 Dependency Update Check (cargo outdated)" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo outdated >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"
