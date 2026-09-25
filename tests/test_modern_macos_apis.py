#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(path):
    return (ROOT / path).read_text()


def test_launch_at_login_uses_smappservice():
    source = read("Shuttle/LaunchAtLoginController.m")
    assert "SMAppService mainAppService" in source
    assert "LSSharedFileList" not in source.replace("LSSharedFileList (kLSSharedFileListSessionLoginItems)", "")
    assert "NSMakeCollectable" not in source


def test_launch_at_login_is_compiled_with_arc_and_links_servicemanagement():
    project = read("Shuttle.xcodeproj/project.pbxproj")
    assert "-fno-objc-arc" not in project
    assert "ServiceManagement.framework in Frameworks */," in project


def test_deployment_target_is_macos_13():
    project = read("Shuttle.xcodeproj/project.pbxproj")
    targets = set(re.findall(r"MACOSX_DEPLOYMENT_TARGET = ([0-9.]+);", project))
    assert targets == {"13.0"}
    assert "VALID_ARCHS" not in project


def test_deprecated_appkit_apis_are_gone():
    app_delegate = read("Shuttle/AppDelegate.m")
    for deprecated in [
        "NSOKButton",
        "NSFileHandlingPanelOKButton",
        "NSWarningAlertStyle",
        "openFile:",
        "[statusItem setImage:",
    ]:
        assert deprecated not in app_delegate, deprecated
    assert "if (@available(macOS 14.0, *))" in app_delegate


if __name__ == "__main__":
    for name, value in sorted(globals().items()):
        if name.startswith("test_") and callable(value):
            value()
