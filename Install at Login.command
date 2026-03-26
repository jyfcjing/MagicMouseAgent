#!/bin/zsh

ROOT="${0:A:h}"
STATUS=0

cd "$ROOT"

echo "Installing MagicMouseAgent to launch at login..."
echo

./install-login-agent.sh || STATUS=$?

echo
if [[ $STATUS -eq 0 ]]; then
  echo "MagicMouseAgent will now start automatically after login."
else
  echo "Install failed with exit code $STATUS."
fi
echo
read '?Press Enter to close this window...'
exit $STATUS
