# Sketch

## Overview
- Sketch is my crappy little collection of dotfiles.
- The files are managed via my custom built dotfile manager [duttsy](https://github.com/LobotomizedHampster/duttsy)

## Color Scheme
(add dynamicly generated images for colors (imagemajic))

A modified Gruvbox theme made by me.
| ANSI | ANSI NAME                | NAME               | HEX CODE |
|------|--------------------------|--------------------|----------|
| 00   | black                    | black / background | 161414   |
| 01   | red                      | red                | b6343d   |
| 02   | green                    | green              | 74971a   |
| 03   | yellow                   | yellow             | d79921   |
| 04   | blue                     | blue               | 458588   |
| 05   | magenta                  | purple             | b16286   |
| 06   | cyan                     | cyan               | 689d8a   |
| 07   | white / light grey       | white / foreground | ebdbc2   |
| 08   | bright black / dark grey | grey / muted       | a89984   |
| 09   | birght red               | bright red         | e5585f   |
| 10   | bright green             | bright green       | 87b73a   |
| 11   | bright yellow            | bright yellow      | fcbe41   |
| 12   | bright blue              | bright blue        | 5ed0d6   |
| 13   | bright magenta           | pink               | d16286   |
| 14   | bright cyan              | bright cyan        | 89edc8   |
| 15   | bright white             | bright white       | ffeae2   |
| NULL | NULL                     | orange             | d05d0e   |

## FILES BEING MANGED
```
./
├── .bash_env
├── .bashrc
├── .config/
│   ├── config_files.conf
│   ├── conky/
│   │   ├── conky.conf
│   │   └── todo.sh*
│   ├── dunst/
│   │   └── dunstrc
│   ├── kitty/
│   │   ├── doodle.conf
│   │   └── kitty.conf
│   ├── nvim/
│   │   ├── after/
│   │   │   └── syntax/
│   │   │       └── draft.lua
│   │   ├── colors/
│   │   │   └── doodle.lua
│   │   ├── init.lua
│   │   ├── lazy-lock.json
│   │   └── lua/
│   │       ├── toggle-checkbox/
│   │       │   └── init.lua
│   │       └── user/
│   │           ├── commands.lua
│   │           ├── filetypes.lua
│   │           ├── options.lua
│   │           └── packages.lua
│   ├── picom/
│   │   └── picom.conf
│   ├── qtile/
│   │   ├── autostart.sh*
│   │   ├── config.py
│   │   ├── __pycache__/
│   │   │   ├── config.cpython-313.pyc
│   │   │   └── config.cpython-314.pyc
│   │   └── somthing/
│   │       └── thing.txt
│   ├── ranger/
│   │   ├── bookmarks
│   │   ├── colorschemes/
│   │   │   ├── __init__.py
│   │   │   ├── __pycache__/
│   │   │   │   ├── __init__.cpython-313.pyc
│   │   │   │   ├── __init__.cpython-314.pyc
│   │   │   │   ├── solarized.cpython-313.pyc
│   │   │   │   └── solarized.cpython-314.pyc
│   │   │   └── solarized.py
│   │   ├── commands_full.py
│   │   ├── commands.py
│   │   ├── rc.conf
│   │   ├── rifle.conf
│   │   └── scope.sh*
│   └── rofi/
│       ├── colors.rasi
│       ├── config.rasi
│       └── configure.rasi
├── .duttsy-ignore
├── .git/
│   ├── config
│   ├── description
│   ├── HEAD
│   ├── hooks/
│   │   ├── applypatch-msg.sample*
│   │   ├── commit-msg.sample*
│   │   ├── fsmonitor-watchman.sample*
│   │   ├── post-update.sample*
│   │   ├── pre-applypatch.sample*
│   │   ├── pre-commit.sample*
│   │   ├── pre-merge-commit.sample*
│   │   ├── prepare-commit-msg.sample*
│   │   ├── pre-push.sample*
│   │   ├── pre-rebase.sample*
│   │   ├── pre-receive.sample*
│   │   ├── push-to-checkout.sample*
│   │   ├── sendemail-validate.sample*
│   │   └── update.sample*
│   ├── index
│   ├── info/
│   │   └── exclude
│   ├── logs/
│   │   ├── HEAD
│   │   └── refs/
│   │       ├── heads/
│   │       │   └── main
│   │       └── remotes/
│   │           └── origin/
│   │               └── HEAD
│   ├── objects/
│   │   ├── info/
│   │   └── pack/
│   │       ├── pack-4d9f66ae7b78360af43f0f8e39ab0889c36d8905.idx
│   │       ├── pack-4d9f66ae7b78360af43f0f8e39ab0889c36d8905.pack
│   │       └── pack-4d9f66ae7b78360af43f0f8e39ab0889c36d8905.rev
│   ├── packed-refs
│   └── refs/
│       ├── heads/
│       │   └── main
│       ├── remotes/
│       │   └── origin/
│       │       └── HEAD
│       └── tags/
├── .local/
│   └── bin/
│       ├── calc*
│       ├── config*
│       ├── days*
│       ├── de*
│       ├── df-install*
│       ├── df-push*
│       ├── dmenu-menu.sh*
│       ├── ej*
│       ├── is-encrypted.sh*
│       ├── light*
│       ├── lock*
│       ├── recap*
│       ├── sc*
│       ├── tadc*
│       ├── td*
│       ├── todo*
│       └── wp*
├── .overwritten/
│   └── prefs.js
├── README.md
├── .xinitrc
├── .xprofile
└── .zen/
    ├── Default/
    │   ├── chrome/
    │   │   ├── userChrome.css
    │   │   ├── zen-themes/
    │   │   │   └── 642854b5-88b4-4c40-b256-e035532109df/
    │   │   │       ├── chrome.css
    │   │   │       ├── preferences.json
    │   │   │       └── readme.md
    │   │   └── zen-themes.css
    │   ├── containers.json
    │   ├── extensions/
    │   │   ├── {3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}.xpi
    │   │   ├── {446900e4-71c2-419f-a6a7-df9c091e268b}.xpi
    │   │   ├── {7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}.xpi
    │   │   ├── {91aa3897-2634-4a8a-9092-279db23a7689}.xpi
    │   │   ├── addon@darkreader.org.xpi
    │   │   └── uBlock0@raymondhill.net.xpi
    │   ├── handlers.json
    │   ├── permissions.sqlite
    │   ├── places.sqlite
    │   ├── places.sqlite-wal
    │   ├── prefs.js
    │   └── search.json.mozlz4
    └── Music/
        ├── chrome/
        │   ├── userChrome.css
        │   ├── zen-themes/
        │   │   └── 642854b5-88b4-4c40-b256-e035532109df/
        │   │       ├── chrome.css
        │   │       ├── preferences.json
        │   │       └── readme.md
        │   └── zen-themes.css
        ├── containers.json
        ├── extensions/
        │   ├── {446900e4-71c2-419f-a6a7-df9c091e268b}.xpi
        │   ├── {91aa3897-2634-4a8a-9092-279db23a7689}.xpi
        │   └── uBlock0@raymondhill.net.xpi
        ├── handlers.json
        ├── permissions.sqlite
        ├── places.sqlite
        ├── places.sqlite-wal
        ├── prefs.js
        └── search.json.mozlz4
```

| FILE       | DESCRIPTION                 |
|------------|-----------------------------|
| .bashrc    | terminal look and shortcuts |
| .xinitrc   | xorg startup config                 |
| .xprofile  | other random stuff          |
| .zen       | browser profiles            |
| .config    | app config files            |
| .local/bin | custom commands             |


## HOW TO

- couple handful of commands to help with managing the dotfiles

### ADDING FILES TO STOW & GITHUB

run code below:
```
cp ~/path/to/new/file ~/.dotfiles/path/to/new/file # copy files to .dotfiles
cd ~/.dotfiles # move into .dotfiles
stow --adopt . # remake all the symlinks with stow
git add . # add all files to commit
git commit -m "message" # commit the files
git push # push the files to GitHub
```
