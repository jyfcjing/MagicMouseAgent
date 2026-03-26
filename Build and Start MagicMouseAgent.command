#!/bin/zsh

ROOT="${0:A:h}"
STATUS=0

cd "$ROOT"

echo "Building and starting MagicMouseAgent..."
echo

python3 ./generate_config.py && ./build.sh && ./start.sh || STATUS=$?

echo
if [[ $STATUS -eq 0 ]]; then
  echo "MagicMouseAgent is ready."
else
  echo "MagicMouseAgent failed with exit code $STATUS."
fi
echo
read '?Press Enter to close this window...'
exit $STATUS
