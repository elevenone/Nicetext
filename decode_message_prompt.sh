#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [ -x "$SCRIPT_DIR/babble/src/scramble" ]; then
    SCRAMBLE_BIN="$SCRIPT_DIR/babble/src/scramble"
elif [ -x "$SCRIPT_DIR/bin/scramble" ]; then
    SCRAMBLE_BIN="$SCRIPT_DIR/bin/scramble"
else
    echo "Missing executable: scramble" >&2
    echo "Build the project first with: make" >&2
    exit 1
fi

resolve_path() {
    input_path=$1

    if [ -d "$input_path" ] || [ -f "$input_path" ]; then
        printf '%s\n' "$input_path"
        return 0
    fi

    if [ -d "$SCRIPT_DIR/$input_path" ] || [ -f "$SCRIPT_DIR/$input_path" ]; then
        printf '%s\n' "$SCRIPT_DIR/$input_path"
        return 0
    fi

    if [ -d "$SCRIPT_DIR/_pkd/$input_path" ] || [ -f "$SCRIPT_DIR/_pkd/$input_path" ]; then
        printf '%s\n' "$SCRIPT_DIR/_pkd/$input_path"
        return 0
    fi

    return 1
}

encoded_input="${1:-}"
dict_input="${2:-}"

if [ -z "$encoded_input" ]; then
    printf 'File to decode: '
    IFS= read -r encoded_input
fi

if [ -z "$encoded_input" ]; then
    echo "No input file provided." >&2
    exit 1
fi

if ! ENCODED_FILE=$(resolve_path "$encoded_input"); then
    echo "Could not find input file: $encoded_input" >&2
    exit 1
fi

if [ ! -f "$ENCODED_FILE" ]; then
    echo "Input is not a file: $ENCODED_FILE" >&2
    exit 1
fi

if [ -z "$dict_input" ]; then
    printf 'Dataset folder: '
    IFS= read -r dict_input
fi

if [ -z "$dict_input" ]; then
    echo "No dataset folder provided." >&2
    exit 1
fi

if ! DICT_DIR=$(resolve_path "$dict_input"); then
    echo "Could not find dataset folder: $dict_input" >&2
    exit 1
fi

if [ ! -d "$DICT_DIR" ]; then
    echo "Dataset path is not a directory: $DICT_DIR" >&2
    exit 1
fi

dict_matches=$(find "$DICT_DIR" -maxdepth 1 -type f -name '*dict.dat' | sort)

if [ -z "$dict_matches" ]; then
    echo "No dataset dictionary found in: $DICT_DIR" >&2
    exit 1
fi

dict_count=$(printf '%s\n' "$dict_matches" | sed '/^$/d' | wc -l | tr -d ' ')

if [ "$dict_count" -ne 1 ]; then
    echo "Expected exactly one *dict.dat file in $DICT_DIR, found $dict_count." >&2
    printf '%s\n' "$dict_matches" >&2
    exit 1
fi

DICT_DAT_FILE=$(printf '%s\n' "$dict_matches" | head -n 1)
DATASET_PREFIX=${DICT_DAT_FILE%dict.dat}

for file in "${DATASET_PREFIX}dict.dat" "${DATASET_PREFIX}type.dat"; do
    if [ ! -f "$file" ]; then
        echo "Missing dataset file: $file" >&2
        exit 1
    fi
done

TMP_OUTPUT=$(mktemp "${TMPDIR:-/tmp}/nicetext_decode.XXXXXX")
trap 'rm -f "$TMP_OUTPUT"' EXIT INT TERM HUP

"$SCRAMBLE_BIN" \
    -i "$ENCODED_FILE" \
    -d "$DATASET_PREFIX" \
    -o "$TMP_OUTPUT"

echo
echo "Decoded message:"
cat "$TMP_OUTPUT"
