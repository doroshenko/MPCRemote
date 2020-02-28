#!/bin/bash

START_DATE=$(date +"%s")

SWIFTLINT="${PODS_ROOT}/SwiftLint/swiftlint"
EXIT_CODE=0

# Usage description
function usage() {
    if [ -n "$1" ]; then
        echo -e "ERROR: $1\n" >&2
    fi
    local scriptfile="${0##*/}"
    echo "Usage: $scriptfile [-c path-to-swiftlint.yml] [-s] [-a]"
    echo "  -c, --config             A path to the configuration file (optional)"
    echo "  -s, --strict             Treat warnings as errors (default: false)"
    echo "  -a, --all                Lint all swift files (default: false)"
    echo ""
    echo "Example: $scriptfile --config /path/to/swiftlint.yml --strict"
    exit 1
}

# Parse params
while [[ "$#" > 0 ]]; do case $1 in
    -c|--config) CONFIG_FILE="$2"; shift;shift;;
    -s|--strict) STRICT=1;shift;;
    -a|--all) LINT_ALL=1;shift;;
    *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

# Set default params
if [ -z "$CONFIG_FILE" ]; then
    CONFIG_FILE="${SRCROOT}/.swiftlint.yml"
fi

if [ -z "$STRICT" ]; then
    STRICT=0
fi

if [ -z "$LINT_ALL" ]; then
    LINT_ALL=0
fi

# Perform linting
run_swiftlint() {
    local filename="${1}"

    if [ $STRICT -eq 0 ]; then
        $SWIFTLINT lint --config $CONFIG_FILE --path "${filename}"
        ret=$?
    else
        $SWIFTLINT lint --strict --config $CONFIG_FILE --path "${filename}" | sed "s/warning:/error:/g"
        ret=${PIPESTATUS[0]}
    fi

    if [ $ret -ne 0 ]; then
        EXIT_CODE=$ret
    fi
}

# Check if cocoapods is installed
if ! [ -e "$SRCROOT/Podfile.lock" ]; then
    echo "ERROR: cocoapods is not installed" >&2
    exit 1
fi

# Check if SwiftLint pod is installed
if ! [ -n "$(cat $SRCROOT/Podfile.lock | grep SwiftLint)" ]; then
    echo "ERROR: SwiftLint is not installed." >&2
    exit 1
fi

echo "SwiftLint version: $($SWIFTLINT version)"

if [ $LINT_ALL -eq 0 ]; then
    # Enumerate staged files
    while read filename; do
        run_swiftlint "${filename}";
    done < <(git diff --staged --relative --diff-filter=d --name-only -- "*.swift")

    # Enumerate unstaged modified files
    while read filename; do
        run_swiftlint "${filename}";
    done < <(git diff --relative --diff-filter=d --name-only -- "*.swift")

    # Enumerate new untracked files
    while read filename; do
        run_swiftlint "${filename}";
    done < <(git ls-files --others --exclude-standard -- "*.swift")
else
   # Enumerate all swift files
   run_swiftlint
fi

END_DATE=$(date +"%s")

TIME=$(($END_DATE - $START_DATE))
echo "SwiftLint finished after $TIME seconds with exit code $EXIT_CODE."
exit $EXIT_CODE
