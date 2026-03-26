# MagicMouseAgent

MagicMouseAgent is a small macOS helper for a very specific job: replacing a small BetterTouchTool setup for Magic Mouse gestures.

Chinese guide: [README.zh-CN.md](README.zh-CN.md)

## Quick Start

If you only want to use it and do not want to read build instructions, do this:

1. Download the latest packaged zip from GitHub Releases when one is available.
2. Unzip it anywhere you like.
3. Double-click `Start MagicMouseAgent.command`.
4. The first time, macOS will ask for Accessibility permission.
5. In `System Settings -> Privacy & Security -> Accessibility`, enable:

```text
build/MagicMouseAgent.app
```

6. Test the gestures in Chrome.
7. If you want it to launch automatically after login, double-click `Install at Login.command`.

If you downloaded the source code instead of a packaged zip:

1. Install Xcode Command Line Tools.
2. Double-click `Build and Start MagicMouseAgent.command`.
3. Grant Accessibility permission when macOS asks for it.

## Default Gestures

- Global `One-Finger Tap` -> left click
- Global `Right-Front Tap` -> right click
- Google Chrome `One-Swipe-Left` -> previous tab
- Google Chrome `One-Swipe-Right` -> next tab
- Google Chrome `Two-Finger Tap` -> close current tab
- Google Chrome `Middle-Fix Index-Near-Tap` -> reopen last closed tab
- Google Chrome `Middle-Fix Index-Far-Tap` -> reopen last closed tab
- Google Chrome `Index-Fix Middle-Near-Tap` -> new tab
- Google Chrome `Index-Fix Middle-Far-Tap` -> new tab

## Double-Click Scripts

These files are meant for normal users who would rather click than type:

- `Build and Start MagicMouseAgent.command`
- `Start MagicMouseAgent.command`
- `Stop MagicMouseAgent.command`
- `Install at Login.command`
- `Uninstall from Login.command`

## If Something Does Not Work

1. Quit Chrome and open it again.
2. Remove `build/MagicMouseAgent.app` from Accessibility, then add it again.
3. Run `Stop MagicMouseAgent.command`, then `Start MagicMouseAgent.command`.
4. If macOS blocks the script or app because it is unsigned, right-click it once and choose `Open`.

## For Technical Users

Build from source:

```bash
python3 ./generate_config.py
./build.sh
```

Create a packaged zip:

```bash
./package.sh
```

Useful shell commands:

```bash
./start.sh
./stop.sh
./status.sh
./install-login-agent.sh
./uninstall-login-agent.sh
```

Logs:

```bash
/usr/bin/log show --style compact --last 8m --predicate 'process == "MagicMouseAgent"'
```

## Notes

- This project uses Apple's private `MultitouchSupport` framework, like Jitouch.
- The default build is ad-hoc signed, not notarized.
- If you want to distribute polished prebuilt binaries broadly, the next step is Developer ID signing and notarization.

## License

MagicMouseAgent is distributed under `GPL-3.0`. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
