#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
OUT_DIR="$SCRIPT_DIR/out"

MESSAGE_FILE="$SCRIPT_DIR/message.txt"
MODEL_PREFIX="$ROOT_DIR/examples/database/jfk"
NICETEXT_BIN="$ROOT_DIR/babble/src/nicetext"
SCRAMBLE_BIN="$ROOT_DIR/babble/src/scramble"
SORTDCT_BIN="$ROOT_DIR/gendict/src/sortdct"
DCT2MSTR_BIN="$ROOT_DIR/gendict/src/dct2mstr"
GENMODEL_BIN="$ROOT_DIR/gendict/src/genmodel"
TUTORIAL_DIR="$ROOT_DIR/examples/tutorial/1"

for file in "$MESSAGE_FILE" "${MODEL_PREFIX}dict.dat" "${MODEL_PREFIX}model.dat"; do
    if [ ! -f "$file" ]; then
        echo "Missing required test fixture: $file" >&2
        exit 1
    fi
done

for file in "$TUTORIAL_DIR/dict.raw" "$TUTORIAL_DIR/sample.txt" "$TUTORIAL_DIR/secret.txt"; do
    if [ ! -f "$file" ]; then
        echo "Missing required tutorial fixture: $file" >&2
        exit 1
    fi
done

for bin in "$NICETEXT_BIN" "$SCRAMBLE_BIN" "$SORTDCT_BIN" "$DCT2MSTR_BIN" "$GENMODEL_BIN"; do
    if [ ! -x "$bin" ]; then
        echo "Missing required executable: $bin" >&2
        echo "Build the project first with: make" >&2
        exit 1
    fi
done

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR/tutorial1"

echo "Test 1/2: model round-trip with bundled JFK dataset"
"$NICETEXT_BIN" \
    -i "$MESSAGE_FILE" \
    -m "$MODEL_PREFIX" \
    -d "$MODEL_PREFIX" \
    -o "$OUT_DIR/message.model.nicetext.txt"

"$SCRAMBLE_BIN" \
    -i "$OUT_DIR/message.model.nicetext.txt" \
    -d "$MODEL_PREFIX" \
    -o "$OUT_DIR/message.model.restored.txt"

cmp -s "$MESSAGE_FILE" "$OUT_DIR/message.model.restored.txt"

echo "Test 2/2: grammar round-trip with tutorial fixtures"
cp "$TUTORIAL_DIR/dict.raw" "$OUT_DIR/tutorial1/dict.raw"
cp "$TUTORIAL_DIR/sample.txt" "$OUT_DIR/tutorial1/sample.txt"
cp "$TUTORIAL_DIR/secret.txt" "$OUT_DIR/tutorial1/secret.txt"

( cd "$OUT_DIR/tutorial1" && "$SORTDCT_BIN" < dict.raw > dict.srt )
( cd "$OUT_DIR/tutorial1" && "$DCT2MSTR_BIN" -i dict.srt )
( cd "$OUT_DIR/tutorial1" && "$GENMODEL_BIN" -s -g grambase.def -i sample.txt )

"$NICETEXT_BIN" \
    -i "$OUT_DIR/tutorial1/secret.txt" \
    -d "$OUT_DIR/tutorial1/mstr" \
    -g "$OUT_DIR/tutorial1/grambase.def" \
    -o "$OUT_DIR/message.grammar.nicetext.txt"

"$SCRAMBLE_BIN" \
    -i "$OUT_DIR/message.grammar.nicetext.txt" \
    -d "$OUT_DIR/tutorial1/mstr" \
    -o "$OUT_DIR/message.grammar.restored.txt"

cmp -s "$OUT_DIR/tutorial1/secret.txt" "$OUT_DIR/message.grammar.restored.txt"

echo "All round-trip tests passed."
echo "Artifacts written to: $OUT_DIR"
