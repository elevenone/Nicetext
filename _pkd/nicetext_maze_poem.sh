#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

INPUT_FILE="${1:-$ROOT_DIR/_pkd/_message.txt}"
OUTPUT_FILE="${2:-$ROOT_DIR/_pkd/_message.a_maze_of_death.poem.txt}"
PREFIX="$ROOT_DIR/_pkd/build_pkd_poem/a_maze_of_death"
GRAMMAR_FILE="$ROOT_DIR/_pkd/a_maze_of_death_poem.def"
NICETEXT_BIN="$ROOT_DIR/bin/nicetext"

if [ ! -x "$NICETEXT_BIN" ]; then
    echo "Missing executable: $NICETEXT_BIN" >&2
    echo "Build the project first with: make install" >&2
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Missing input file: $INPUT_FILE" >&2
    exit 1
fi

if [ ! -f "$GRAMMAR_FILE" ]; then
    echo "Missing grammar file: $GRAMMAR_FILE" >&2
    exit 1
fi

if [ ! -f "${PREFIX}dict.dat" ] || [ ! -f "${PREFIX}type.dat" ]; then
    echo "Missing dictionary files for prefix: $PREFIX" >&2
    echo "Build them first with: ./_pkd/build_pkd_poem.sh" >&2
    exit 1
fi

"$NICETEXT_BIN" \
    -i "$INPUT_FILE" \
    -d "$PREFIX" \
    -g "$GRAMMAR_FILE" \
    -o "$OUTPUT_FILE"

echo "Poem output: $OUTPUT_FILE"
