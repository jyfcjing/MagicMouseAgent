#!/usr/bin/env python3
import plistlib
from pathlib import Path


ROOT = Path(__file__).resolve().parent
CONFIG_DIR = ROOT / "config"
CONFIG_PATH = CONFIG_DIR / "MagicMouseAgent.plist"
SUMMARY_PATH = CONFIG_DIR / "migration-summary.md"


CMD = 1 << 20
SHIFT = 1 << 17
ALT = 1 << 19
CTRL = 1 << 18


def action(gesture: str, command: str) -> dict:
    return {
        "Gesture": gesture,
        "Command": command,
        "IsAction": True,
        "ModifierFlags": 0,
        "KeyCode": 0,
        "Enable": True,
    }


def shortcut(gesture: str, label: str, keycode: int, modifiers: int) -> dict:
    return {
        "Gesture": gesture,
        "Command": label,
        "IsAction": False,
        "ModifierFlags": modifiers,
        "KeyCode": keycode,
        "Enable": True,
    }


def app_entry(name: str, path: str, gestures: list[dict]) -> dict:
    return {"Application": name, "Path": path, "Gestures": gestures}


def build_magic_mouse_commands() -> list[dict]:
    return [
        app_entry(
            "All Applications",
            "",
            [
                action("One-Finger Tap", "Left Click"),
                action("Right-Front Tap", "Right Click"),
            ],
        ),
        app_entry(
            "Google Chrome",
            "/Applications/Google Chrome.app",
            [
                action("One-Swipe-Left", "Previous Tab"),
                action("One-Swipe-Right", "Next Tab"),
                action("Two-Finger Tap", "Close / Close Tab"),
                action("Middle-Fix Index-Near-Tap", "Open Recently Closed Tab"),
                action("Middle-Fix Index-Far-Tap", "Open Recently Closed Tab"),
            ],
        ),
    ]


def build_trackpad_commands() -> list[dict]:
    return [
        app_entry(
            "All Applications",
            "",
            [
                action("One-Fix One-Slide", "Move / Resize"),
                action("Three-Finger Tap", "Middle Click"),
            ],
        )
    ]


def build_recognition_commands() -> list[dict]:
    return [app_entry("All Applications", "", [])]


def write_summary() -> None:
    text = """# Migration Summary

This pass is intentionally mouse-first and focused on replacing a small BetterTouchTool setup with a dedicated Magic Mouse agent.

Supported now:
- Magic Mouse single-finger tap for a primary left click.
- Magic Mouse single-finger swipe left/right for previous/next tab in Chrome.
- Magic Mouse two-finger tap to close the current tab in Google Chrome.
- Magic Mouse hold-right plus tap-left to reopen the most recently closed tab in Google Chrome.
- Magic Mouse front-right tap for a global right click.

Not migrated 1:1 in this pass:
- BetterTouchTool top-edge Magic Mouse touch gestures.
- BetterTouchTool-specific 1-finger and 2-finger trackpad side-tip-tap variants.
- Remaining browser gestures that depended on older Jitouch-specific gesture families.

Trackpad gesture handling is still disabled by default.
"""
    SUMMARY_PATH.write_text(text)


def main() -> None:
    CONFIG_DIR.mkdir(parents=True, exist_ok=True)

    payload = {
        "Revision": 26,
        "enAll": 1,
        "ClickSpeed": 0.25,
        "Sensitivity": 4.6666,
        "ShowIcon": 0,
        "LogLevel": 1,
        "enTPAll": 0,
        "Handed": 0,
        "enMMAll": 1,
        "MMHanded": 0,
        "enCharRegTP": 0,
        "enCharRegMM": 0,
        "charRegMouseButton": 0,
        "charRegIndexRingDistance": 0.33,
        "enOneDrawing": 0,
        "enTwoDrawing": 1,
        "TrackpadCommands": build_trackpad_commands(),
        "MagicMouseCommands": build_magic_mouse_commands(),
        "RecognitionCommands": build_recognition_commands(),
    }

    with CONFIG_PATH.open("wb") as f:
        plistlib.dump(payload, f, sort_keys=False)

    write_summary()
    print(CONFIG_PATH)


if __name__ == "__main__":
    main()
