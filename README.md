# MagicMouseAgent

MagicMouseAgent is a small open-source macOS helper for a narrow set of Magic Mouse gestures. It is intended for people who only need a handful of BetterTouchTool-style actions and would rather run a focused local agent than keep a larger commercial app installed.

The current default mappings are:
- Global `One-Finger Tap` -> left click
- Global `Right-Front Tap` -> right click
- Google Chrome `One-Swipe-Left` -> previous tab
- Google Chrome `One-Swipe-Right` -> next tab
- Google Chrome `Two-Finger Tap` -> close current tab
- Google Chrome `Middle-Fix Index-Near-Tap` -> reopen last closed tab
- Google Chrome `Middle-Fix Index-Far-Tap` -> reopen last closed tab

## Why this exists

This repository packages a modified Jitouch-based agent around one concrete use case: replacing a small BetterTouchTool setup for Magic Mouse gestures on recent macOS releases. The focus is intentionally narrow:
- Keep the gesture set minimal
- Avoid random browser or system setting changes
- Make the build and launch flow easy to inspect
- Ship the corresponding source needed to rebuild the app

## How it works

MagicMouseAgent listens to Magic Mouse multitouch frames, resolves a small set of custom gestures, and dispatches keyboard or mouse actions locally. The gesture config is generated from `generate_config.py` into `config/MagicMouseAgent.plist`.

The current implementation includes:
- custom one-finger horizontal swipe handling for Chrome tab switching
- custom two-finger tap handling for Chrome tab close
- custom right-front tap handling for global right click
- custom one-finger tap handling for tap-to-click style primary click
- custom hold-right plus tap-left handling for reopening the most recently closed Chrome tab

## Requirements

- macOS
- A Magic Mouse
- Xcode Command Line Tools
- Accessibility permission for the built app

This project uses Apple's private `MultitouchSupport` framework, just like Jitouch. That means it is practical for personal use and open-source experimentation, but you should expect occasional macOS compatibility work when Apple changes input internals.

## Build

```bash
python3 ./generate_config.py
./build.sh
```

The build output is:

```text
build/MagicMouseAgent.app
```

## Run

```bash
./start.sh
```

On first launch, add the built app to:

`System Settings -> Privacy & Security -> Accessibility`

The path you should grant is:

```text
<repo>/build/MagicMouseAgent.app
```

Useful commands:

```bash
./stop.sh
./status.sh
./install-login-agent.sh
./uninstall-login-agent.sh
```

To inspect runtime logs:

```bash
/usr/bin/log show --style compact --last 8m --predicate 'process == "MagicMouseAgent"'
```

## Configuration

Edit `generate_config.py`, then regenerate and restart:

```bash
python3 ./generate_config.py
./build.sh
./start.sh
```

The generated files live under `config/` and are not meant to be edited by hand.

## Distribution

The default build uses ad-hoc signing so the bundle identity stays stable enough for local Accessibility permission during rebuilds. If you want to distribute prebuilt binaries to other users, the more polished path is to add a real Developer ID signature and notarization. The source tree itself does not require that.

## License

MagicMouseAgent is distributed under `GPL-3.0`. See [LICENSE](LICENSE) and [NOTICE](NOTICE).

This repository contains modified source from Jitouch and keeps the upstream license obligations intact.
