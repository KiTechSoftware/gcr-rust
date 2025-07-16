#!/usr/bin/env bash
set -e

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="coverage-output.txt"

echo "### 📊 Test Coverage Report (tarpaulin)" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo tarpaulin --ignore-tests >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"
