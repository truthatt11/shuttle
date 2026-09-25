#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(path):
    return (ROOT / path).read_text()


def test_missing_config_file_does_not_reach_json_parser():
    app_delegate = read("Shuttle/AppDelegate.m")
    assert "if (data) {" in app_delegate
    assert "if (dataAlt) {" in app_delegate


def test_missing_terminal_setting_falls_back_to_terminal_app():
    app_delegate = read("Shuttle/AppDelegate.m")
    assert "terminalPref = [json[@\"terminal\"] lowercaseString];" not in app_delegate
    assert ": @\"terminal.app\";" in app_delegate


def test_applescript_errors_are_reported():
    app_delegate = read("Shuttle/AppDelegate.m")
    assert "executeAppleEvent:containerEvent error:nil" not in app_delegate
    assert "executeAppleEvent:containerEvent error:&appleScriptExecutionError" in app_delegate
    assert "[self reportScriptError:appleScriptCreationError forScript:scriptPath]" in app_delegate
    assert "- (void) reportScriptError:(NSDictionary *)errorInfo forScript:(NSString *)scriptPath" in app_delegate


if __name__ == "__main__":
    for name, value in sorted(globals().items()):
        if name.startswith("test_") and callable(value):
            value()
