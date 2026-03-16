#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

INPUT_FILE_REL="../../_pkd/text/A_Maze_of_Death.txt"
OUTPUT_DIR_REL="../../_pkd/build"
OUTPUT_PREFIX_REL="$OUTPUT_DIR_REL/a_maze_of_death"

INPUT_FILE="$SCRIPT_DIR/text/A_Maze_of_Death.txt"
OUTPUT_DIR="$SCRIPT_DIR/build"

GENMODEL_BIN="$ROOT_DIR/bin/genmodel"
DICT_PREFIX_REL="mstr"

if [ ! -x "$GENMODEL_BIN" ]; then
    echo "Missing executable: $GENMODEL_BIN" >&2
    echo "Build the project first with: make" >&2
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Missing input file: $INPUT_FILE" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# genmodel has an old hardcoded dependency on mstrtype.* in the current
# directory, so run it from the bundled database folder.
cd "$ROOT_DIR/examples/database"

"$GENMODEL_BIN" \
    -s \
    -i "$INPUT_FILE_REL" \
    -d "$DICT_PREFIX_REL" \
    -m "$OUTPUT_PREFIX_REL" \
    -o "$OUTPUT_PREFIX_REL" \
    -b "$OUTPUT_DIR_REL/badword.out"

echo "Model files:"
echo "  $OUTPUT_PREFIX_REL"model.dat
echo "  $OUTPUT_PREFIX_REL"model.jmp
echo "Subset dictionary files:"
echo "  $OUTPUT_PREFIX_REL"dict.dat
echo "  $OUTPUT_PREFIX_REL"dict.jmp
echo "  $OUTPUT_PREFIX_REL"dict.alt
echo "  $OUTPUT_PREFIX_REL"type.dat
echo "  $OUTPUT_PREFIX_REL"type.jmp
echo "Bad-word report:"
echo "  $OUTPUT_DIR_REL/badword.out"
