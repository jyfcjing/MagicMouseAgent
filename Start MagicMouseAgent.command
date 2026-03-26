#!/bin/zsh

ROOT="${0:A:h}"
STATUS=0

cd "$ROOT"

echo "Starting MagicMouseAgent..."
echo

./start.sh || STATUS=$?

echo
if [[ $STATUS -eq 0 ]]; then
  echo "MagicMouseAgent is running."
else
  echo "MagicMouseAgent failed with exit code $STATUS."
fi
echo
read '?Press Enter to close this window...'
exit $STATUS
