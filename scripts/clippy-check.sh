#!/usr/bin/env bash
set -e

NO_FAIL=false
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL=true
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="clippy-output.txt"

echo "### 🔍 Clippy Lint Check" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo clippy --all-targets --all-features -- -D warnings >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"

if grep -q "error" "$OUTPUT_FILE"; then
    echo "❌ Lint errors detected by Clippy." >> "$SUMMARY_FILE"
    $NO_FAIL || exit 1
else
    echo "✅ No Clippy warnings or errors." >> "$SUMMARY_FILE"
fi
