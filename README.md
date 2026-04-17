# Shuttle

[![Join the chat at https://gitter.im/fitztrev/shuttle](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/fitztrev/shuttle?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A simple shortcut menu for macOS

[http://fitztrev.github.io/shuttle/](http://fitztrev.github.io/shuttle/)

![How Shuttle works](https://raw.githubusercontent.com/fitztrev/shuttle/gh-pages/images/how-shuttle-works.gif)

**Sidenote**: *Many people ask, so here's how I have [my terminal setup](https://github.com/fitztrev/shuttle/wiki/My-Terminal-Prompt).*

## Installation

1. Download [Shuttle](http://fitztrev.github.io/shuttle/)
2. Copy to Applications

## Ghostty support

This fork adds support for using [Ghostty](https://ghostty.org/) as the terminal launched by Shuttle.

### What changed

* Added `Ghostty.app` as a valid value for the top-level `terminal` setting.
* Added bundled AppleScript handlers for Ghostty:
  * new window
  * current window
  * new tab
* Added the Ghostty Apple Events entitlement, `com.mitchellh.ghostty`.
* Fixed command launching on newer macOS versions by only treating strings with a URL scheme as URLs. Shell commands such as `ssh user@host` and custom commands such as `ssh-server ...` now continue through the terminal launcher instead of being passed to Finder as invalid URLs.

### Configuration

Set `terminal` to `Ghostty.app` in `~/.shuttle.json`:

```json
{
  "terminal": "Ghostty.app",
  "open_in": "new"
}
```

`open_in` continues to support Shuttle's existing values:

* `new` opens a new Ghostty window.
* `tab` opens a new tab in the front Ghostty window, or creates a window if none exists.
* `current` runs the command in the focused terminal of the front Ghostty window, or creates a window if none exists.

Per-host `inTerminal` overrides still work the same way:

```json
{
  "name": "Example server",
  "cmd": "ssh user@example.com",
  "inTerminal": "tab"
}
```

Ghostty support requires Ghostty 1.3.0 or newer because it relies on Ghostty's macOS AppleScript API. The first time Shuttle controls Ghostty, macOS may ask for Automation permission; allow Shuttle to control Ghostty.

## Help
See the [Wiki](https://github.com/fitztrev/shuttle/wiki) pages. 

## Roadmap

* Cloud hosting integration
  * AWS, Rackspace, Digital Ocean, etc
  * Using their APIs, automatically add all of your machines to the menu
* Preferences panel for easier configuration
* Update notifications
* Keyboard hotkeys
  * Open menu
  * Select host option within menu

## Contributors

This project was created by [Trevor Fitzgerald](https://github.com/fitztrev). I owe many thanks to the following people who have helped make Shuttle even better.

(In alphabetical order)

* [Alexis NIVON](https://github.com/anivon)
* [Alex Carter](https://github.com/blazeworx)
* [bihicheng](https://github.com/bihicheng)
* [Dave Eddy](https://github.com/bahamas10)
* [Dmitry Filimonov](https://github.com/petethepig)
* [Frank Enderle](https://github.com/fenderle)
* [Jack Weeden](https://github.com/jackbot)
* [Justin Swanson](https://github.com/geeksunny)
* [Kees Fransen](https://github.com/keesfransen)
* Marco Aurélio
* [Martin Grund](https://github.com/grundprinzip)
* [Matt Turner](https://github.com/thshdw)
* [Michael Davis](https://github.com/mpdavis)
* [Morton Fox](https://github.com/mortonfox)
* [Pluwen](https://github.com/pluwen)
* Rebecca Dominguez
* [Rui Rodrigues](https://github.com/rmrodrigues)
* [Ryan Cohen](https://github.com/imryan)
* [Stefan Jansen](https://github.com/steffex)
* Thomas Rosenstein
* [Thoro](https://github.com/Thoro)
* [Tibor Bödecs](https://github.com/tib)
* [welsonla](https://github.com/welsonla)

## Credits

Shuttle was inspired by [SSHMenu](http://sshmenu.sourceforge.net/), the GNOME applet for Linux.

I also looked to projects such as [MLBMenu](https://github.com/markolson/MLB-Menu) and [QuickSmileText](https://github.com/scturtle/QuickSmileText) for direction on building a Cocoa app for the status bar.
