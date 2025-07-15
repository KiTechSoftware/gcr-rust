#!/usr/bin/env bash
set -e

NO_FAIL_ARG=""
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL_ARG="--no-fail"
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/summary.txt}"

echo "## 🔐 Rust Security Checks" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "_This summary includes results from audit, deny, and unsafe code scans._" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "---" >> "$SUMMARY_FILE"

# Run individual tools
echo "### 📦 Dependency Vulnerability Scan (cargo audit)" >> "$SUMMARY_FILE"
audit-deps.sh $NO_FAIL_ARG

echo "---" >> "$SUMMARY_FILE"
echo "### 📋 Dependency Policy Check (cargo deny)" >> "$SUMMARY_FILE"
cargo-deny.sh $NO_FAIL_ARG

echo "---" >> "$SUMMARY_FILE"
echo "### 🧯 Unsafe Code Detection (cargo geiger)" >> "$SUMMARY_FILE"
unsafe-scan.sh $NO_FAIL_ARG

echo "---" >> "$SUMMARY_FILE"
echo "✅ All security checks completed." >> "$SUMMARY_FILE"
