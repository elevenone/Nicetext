#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
INPUT_FILE="$SCRIPT_DIR/_message.txt"
OUTPUT_FILE="$SCRIPT_DIR/_message.nicetext.txt"
RESTORED_FILE="$SCRIPT_DIR/_message.restored.txt"

# Default to the bundled JFK example database. Pass a different prefix
# as the first argument if you want another style/dictionary set.
DB_PREFIX="${1:-$SCRIPT_DIR/examples/database/jfk}"

NICETEXT_BIN="$SCRIPT_DIR/bin/nicetext"
SCRAMBLE_BIN="$SCRIPT_DIR/bin/scramble"

if [ ! -x "$NICETEXT_BIN" ]; then
    echo "Missing executable: $NICETEXT_BIN" >&2
    echo "Build the project first with: make" >&2
    exit 1
fi

if [ ! -x "$SCRAMBLE_BIN" ]; then
    echo "Missing executable: $SCRAMBLE_BIN" >&2
    echo "Build the project first with: make" >&2
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Missing input file: $INPUT_FILE" >&2
    exit 1
fi

"$NICETEXT_BIN" \
    -i "$INPUT_FILE" \
    -m "$DB_PREFIX" \
    -d "$DB_PREFIX" \
    -o "$OUTPUT_FILE"

"$SCRAMBLE_BIN" \
    -i "$OUTPUT_FILE" \
    -d "$DB_PREFIX" \
    -o "$RESTORED_FILE"

echo "Nicetext output:   $OUTPUT_FILE"
echo "Restored message:  $RESTORED_FILE"

if cmp -s "$INPUT_FILE" "$RESTORED_FILE"; then
    echo "Round-trip check:  OK"
else
    echo "Round-trip check:  FAILED" >&2
    exit 1
fi
