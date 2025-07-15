#!/usr/bin/env bash
set -e

NO_FAIL=false
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL=true
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="deny-output.txt"

echo "### 📋 Cargo Deny Policy Check" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo deny check >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"

if grep -q "error" "$OUTPUT_FILE"; then
    echo "❌ Policy violations detected by cargo-deny." >> "$SUMMARY_FILE"
    $NO_FAIL || exit 1
else
    echo "✅ All dependency policies passed." >> "$SUMMARY_FILE"
fi
