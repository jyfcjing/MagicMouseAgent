#!/bin/zsh
set -euo pipefail

ROOT="${0:A:h}"
APP_NAME="MagicMouseAgent"
APP_BUNDLE="$ROOT/build/$APP_NAME.app"
CONFIG="$ROOT/config/MagicMouseAgent.plist"
LABEL="io.github.magicmouseagent.agent"
PLIST_DST="$HOME/Library/LaunchAgents/$LABEL.plist"
GUI_DOMAIN="gui/$(id -u)"

mkdir -p "$ROOT/run" "$HOME/Library/LaunchAgents"

if [[ ! -x "$APP_BUNDLE/Contents/MacOS/$APP_NAME" ]]; then
  "$ROOT/build.sh" >/dev/null
fi

if [[ ! -f "$CONFIG" ]]; then
  python3 "$ROOT/generate_config.py" >/dev/null
fi

cat > "$PLIST_DST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/open</string>
    <string>-W</string>
    <string>$APP_BUNDLE</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
  <key>ProcessType</key>
  <string>Interactive</string>
  <key>StandardOutPath</key>
  <string>$ROOT/run/launchd.stdout.log</string>
  <key>StandardErrorPath</key>
  <string>$ROOT/run/launchd.stderr.log</string>
</dict>
</plist>
PLIST

launchctl bootout "$GUI_DOMAIN" "$PLIST_DST" >/dev/null 2>&1 || true
launchctl bootstrap "$GUI_DOMAIN" "$PLIST_DST"
launchctl enable "$GUI_DOMAIN/$LABEL"

echo "$PLIST_DST"
