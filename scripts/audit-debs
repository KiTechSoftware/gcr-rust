#!/usr/bin/env bash
set -e

NO_FAIL=false
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL=true
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"
OUTPUT_FILE="audit-output.txt"

echo "### 📦 Cargo Audit Summary" >> "$SUMMARY_FILE"

echo '```' >> "$OUTPUT_FILE"
cargo audit >> "$OUTPUT_FILE" 2>&1 || true
echo '```' >> "$OUTPUT_FILE"

cat "$OUTPUT_FILE" >> "$SUMMARY_FILE"

if grep -q "Crate: " "$OUTPUT_FILE"; then
    echo "❗ Vulnerabilities found." >> "$SUMMARY_FILE"
    $NO_FAIL || exit 1
else
    echo "✅ No known vulnerabilities detected." >> "$SUMMARY_FILE"
fi
