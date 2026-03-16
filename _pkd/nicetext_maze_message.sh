#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

INPUT_FILE="$ROOT_DIR/_message.txt"
OUTPUT_FILE="$ROOT_DIR/_message.a_maze_of_death.nicetext.txt"
RESTORED_FILE="$ROOT_DIR/_message.a_maze_of_death.restored.txt"
PREFIX="$SCRIPT_DIR/build/a_maze_of_death"

NICETEXT_BIN="$ROOT_DIR/bin/nicetext"
SCRAMBLE_BIN="$ROOT_DIR/bin/scramble"

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

if [ ! -f "${PREFIX}model.dat" ] || [ ! -f "${PREFIX}dict.dat" ]; then
    echo "Missing model or dictionary files for prefix: $PREFIX" >&2
    echo "Build them first with: ./_pkd/build_maze_model.sh" >&2
    exit 1
fi

"$NICETEXT_BIN" \
    -i "$INPUT_FILE" \
    -m "$PREFIX" \
    -d "$PREFIX" \
    -o "$OUTPUT_FILE"

"$SCRAMBLE_BIN" \
    -i "$OUTPUT_FILE" \
    -d "$PREFIX" \
    -o "$RESTORED_FILE"

echo "Nicetext output:   $OUTPUT_FILE"
echo "Restored message:  $RESTORED_FILE"

if cmp -s "$INPUT_FILE" "$RESTORED_FILE"; then
    echo "Round-trip check:  OK"
else
    echo "Round-trip check:  FAILED" >&2
    exit 1
fi
