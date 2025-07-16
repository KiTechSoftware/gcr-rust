#!/usr/bin/env bash
set -e

NO_FAIL_ARG=""
if [[ "$1" == "--no-fail" ]]; then
    NO_FAIL_ARG="--no-fail"
fi

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-/tmp/ci-summary.md}"
ARTIFACT_FILE="ci-summary.md"

# Clean previous output
: > "$SUMMARY_FILE"
: > "$ARTIFACT_FILE"

CI_STATUS=0

section_header() {
    echo "### $1" >> "$SUMMARY_FILE"
    echo "### $1" >> "$ARTIFACT_FILE"
}

append_output() {
    echo '```' >> "$SUMMARY_FILE"
    echo '```' >> "$ARTIFACT_FILE"
    cat "$1" >> "$SUMMARY_FILE"
    cat "$1" >> "$ARTIFACT_FILE"
    echo '```' >> "$SUMMARY_FILE"
    echo '```' >> "$ARTIFACT_FILE"
}

divider() {
    echo "---" >> "$SUMMARY_FILE"
    echo "---" >> "$ARTIFACT_FILE"
}

# Start summary
echo "## 🔧 Full CI Check Report" >> "$SUMMARY_FILE"
echo "## 🔧 Full CI Check Report" >> "$ARTIFACT_FILE"
echo "_Includes security, linting, tests, and formatting checks._" >> "$SUMMARY_FILE"
echo "_Includes security, linting, tests, and formatting checks._" >> "$ARTIFACT_FILE"
divider

# Run tools
run_step() {
    local label="$1"
    local script="$2"
    section_header "$label"
    if ! $script $NO_FAIL_ARG; then
        CI_STATUS=1
    fi
    divider
}

run_step "📦 Dependency Audit (cargo audit)" audit-deps.sh
run_step "📋 License & Advisory Policy (cargo deny)" cargo-deny.sh
run_step "🧯 Unsafe Code Check (cargo geiger)" unsafe-scan.sh

run_step "🔍 Clippy (Rust Linter)" clippy-check.sh
run_step "🧹 rustfmt (Code Formatting Check)" fmt-check.sh

run_step "🧪 Tests (cargo nextest)" nextest.sh
run_step "📊 Test Coverage (cargo tarpaulin)" coverage.sh

# Final summary
echo "✅ CI check completed. See above for results." >> "$SUMMARY_FILE"
echo "✅ CI check completed. See above for results." >> "$ARTIFACT_FILE"

exit $CI_STATUS
