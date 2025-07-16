#!/usr/bin/env bash
set -e

NO_FAIL=false
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL=true
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="fmt-output.txt"

echo "### 🧹 rustfmt Check" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo fmt --all -- --check >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"

if grep -q "Diff in" "$OUTPUT_FILE"; then
    echo "❌ Code is not properly formatted. Please run \`cargo fmt\`." >> "$SUMMARY_FILE"
    $NO_FAIL || exit 1
else
    echo "✅ Code formatting is correct." >> "$SUMMARY_FILE"
fi
