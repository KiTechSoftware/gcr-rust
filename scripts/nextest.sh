#!/usr/bin/env bash
set -e

NO_FAIL=false
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL=true
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="nextest-output.txt"

echo "### 🧪 Rust Tests (cargo nextest)" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo nextest run >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"

if grep -q "fail" "$OUTPUT_FILE"; then
    echo "❌ Some tests failed." >> "$SUMMARY_FILE"
    $NO_FAIL || exit 1
else
    echo "✅ All tests passed." >> "$SUMMARY_FILE"
fi
