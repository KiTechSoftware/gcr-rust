#!/usr/bin/env bash
set -e

NO_FAIL=false
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL=true
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="geiger-output.txt"

echo "### 🔒 Unsafe Code Scan Summary" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo geiger --target x86_64-unknown-linux-gnu >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"

if grep -q "unsafe" "$OUTPUT_FILE"; then
    echo "⚠️ Unsafe code detected." >> "$SUMMARY_FILE"
    $NO_FAIL || exit 1
else
    echo "✅ No unsafe code found." >> "$SUMMARY_FILE"
fi
