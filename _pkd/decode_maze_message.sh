#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

if [ "${1:-}" != "" ]; then
    INPUT_FILE="$1"
else
    INPUT_FILE=$(ls -t "$ROOT_DIR"/_message.a_maze_of_death.nicetext*.txt 2>/dev/null | head -n 1 || true)
fi

OUTPUT_FILE="${2:-$ROOT_DIR/_message.decoded.txt}"
PREFIX="$SCRIPT_DIR/build/a_maze_of_death"

SCRAMBLE_BIN="$ROOT_DIR/bin/scramble"

if [ ! -x "$SCRAMBLE_BIN" ]; then
    echo "Missing executable: $SCRAMBLE_BIN" >&2
    echo "Build the project first with: make" >&2
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Missing input file: $INPUT_FILE" >&2
    exit 1
fi

if [ ! -f "${PREFIX}dict.dat" ] || [ ! -f "${PREFIX}type.dat" ]; then
    echo "Missing dictionary files for prefix: $PREFIX" >&2
    echo "Build them first with: ./_pkd/build_maze_model.sh" >&2
    exit 1
fi

"$SCRAMBLE_BIN" \
    -i "$INPUT_FILE" \
    -d "$PREFIX" \
    -o "$OUTPUT_FILE"

echo "Decoded output: $OUTPUT_FILE"
