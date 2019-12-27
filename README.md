# Dmenufm

A simple dmenu file manager written in POSIX-compliant shell script.

- Minimal (*only require **POSIX compliant shell** and coreutils*)
- File management (*yank, move, symbolic link, **ranger style bulk rename**, etc*)
- Remember you last path ([CD on Exit](#cd-on-exit))
- Rolling menu for dynamic file browsing ([Rolling Menu](#rolling-menu))
- Able to **Preview** you file. (use [`EYE` to preview your file](#eye-to-preview-your-file))


[![Distrotube introduced my project much better than I would](https://img.youtube.com/vi/EyW6pRlWv6Q/0.jpg)](https://www.youtube.com/watch?v=EyW6pRlWv6Q)

[Distrotube](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg) introduced my project much better than I would.


## Table of Content

<!-- vim-markdown-toc GFM -->

* [Preview](#preview)
* [Dependencies](#dependencies)
* [Installation](#installation)
* [Usage](#usage)
	* [Terminal](#terminal)
	* [CD on Exit](#cd-on-exit)
	* [Rolling Menu](#rolling-menu)
	* [Actions](#actions)
		* [`PCP` to copy path.](#pcp-to-copy-path)
		* [`NEW` to make new file / directory](#new-to-make-new-file--directory)
		* [`MVV` to move file](#mvv-to-move-file)
		* [`YAK` to copy files](#yak-to-copy-files)
		* [`LNK` to create symbolic links](#lnk-to-create-symbolic-links)
		* [`DEL` to remove](#del-to-remove)
		* [`TRH` to put in trash.](#trh-to-put-in-trash)
		* [`REM` to rename files / directories](#rem-to-rename-files--directories)
		* [`HIS` to record history](#his-to-record-history)
		* [`BMK` to store as bookmarks](#bmk-to-store-as-bookmarks)
		* [`CMD` to store command](#cmd-to-store-command)
			* [`CMD` Notes:](#cmd-notes)
		* [`SDO` to enter super user mode](#sdo-to-enter-super-user-mode)
		* [`EYE` to preview your file](#eye-to-preview-your-file)
	* [Open files](#open-files)
* [Configuration](#configuration)
* [Note](#note)
* [Troubleshooting](#troubleshooting)
	* [Why some of my GUI app will open in terminal?](#why-some-of-my-gui-app-will-open-in-terminal)
	* [Why files do not open in the right application](#why-files-do-not-open-in-the-right-application)
	* [I want to configure the color and font of dmenufm](#i-want-to-configure-the-color-and-font-of-dmenufm)
* [TODO](#todo)

<!-- vim-markdown-toc -->

## Preview

![Dmenufm Introduction 1](./figure/dmenufm_1.gif)
![Dmenufm Introduction 2](./figure/dmenufm_2.gif)

## Dependencies

With POSIX-compliance in mind, dmenufm makes use of and requires (or recommends) the below utilities.

- `sed`, `grep`
- `xclip`, `find`, `
- `cat`, `wc`, `cp`, `mv`, `rm`, `mkdir`, `touch` (GNU coreutils)
- `wmctrl` for [`EYE`](#eye-to-preview-your-file) action
- `tar`, `unlzma`, `bunzip2`, `unrar`, `unzip`, `uncompress`, `7z`, `unxz`, `cabextract`

In Debian- or Ubuntu-based distributions of Linux, the packages needed (versions are a guideline) are listed below, at least as is the case in Ubuntu 16.04 (Xenial).

- bzip2                  >= 1.0.6-8
- findutils              >= 4.6.0+git+20160126-2
- grep                   >= 2.25-1~16.04.1
- gzip                   >= 1.6-4
- sed                    >= 4.2.2-7
- suckless-tools         >= 42-1
- tar                    >= 1.28-2.1
- unzip                  >= 6.0-20
- xclip                  >= 0.12+svn84-4
- xz-utils               >= 5.1.1alpha+20120614-2

## Installation

`cd` into the `Makefile` directory, and type `sudo make install` in terminal to install dmenufm.

To uninstall dmenufm, type `sudo make uninstall` in terminal.

## Usage

1. Type `dmenufm` to launch, or assign `dmenufm` to your favorite hot key. You may supply a directory as an argument to start dmenufm in the specified directory.
2. `../` to go back to parent directory.
3. `./` to open your file manager in currend working directory (determined by `xdg-open`)
4. Choices with `/` are directory; choices without `/` are files.

Usage output (as of 2019-12-16) showing optional arguments for custom usage:

```
$ dmenufm --help
            DMENUFM
            Written by huijunchen9260 <chen.9260@osu.edu>

            Simple file manager using dmenu

SYNTAX:     dmenufm [OPTS]

OPTS:       -h | --help               - Show this usage information.
            -d | --directory          - Only directories.
            -f | --file               - Only show files.
            -D | --dotdirectory       - Only show hidden directories.
            -F | --dotfile            - Only show hidden files.
            -p | --lastpath           - Opens in last working directory. (cd on exit)
            -r | --rollingmenu        - Rolling menu based on selected files.
            -t | --termpath           - Print out the path of file / directory.
```

### Terminal

`Terminal` to open terminal in currend working directory. Should define terminal by adding
`export TERMINAL=<your terminal>` to the end of your `.bashrc` file (or any other system configuration file, like `.profile`, `zshrc`, etc).

### CD on Exit

Use `-p | --lastpath` option:

```sh
dmenufm -p
```

### Rolling Menu

Use `-r` option for rolling menu based on the file that you opened:

```sh
dmenufm -r
```

For example, the original list is
```sh
../
./
Actions
Terminal
file1
file2
file3
file4
```

You open `file3`. After you close `file3`, the menu would be
```sh
../
./
Actions
Terminal
file3
file4
file1
file2
```

### Actions

`Actions` is the actions you can do.

#### `PCP` to copy path.

Example:

- current working directory is `$HOME` (your user's own home directory), if `ESC` is pressed to leave dmenufm, then `$HOME` will be copied into `xclip`.
- You can browse into the directory; inside that directory, choose `./`, and the current working directory will be copied.

#### `NEW` to make new file / directory

Name with slash will consider as a directory; without as file.

- Example: Type `dirname/` to create new directory, and `filename` to create new file.

#### `MVV` to move file

- To move file to destination:
	- Choose source and destination to move your file. Enter the directory and choose `./` to confirm the destination.
	- `Bulk Move` for multi-selection
	- `Bulk Move all` to move all the content in the directory.

#### `YAK` to copy files

- The usage of this action is the same as `MVR`, but will copy the file instead of moving it.

#### `LNK` to create symbolic links

- The usage of this action is the same as `MVR`, but will create the symbolic link for the file instead of moving it.

#### `DEL` to remove

Delete directories or files.

- `Bulk Delete` for multi-selection
- `Bulk Delete all` to delete all the content in the directory.

#### `TRH` to put in trash.

- `$HOME/.cache/dmenufm/trash` is the directory storing trashes for dmenufm.
- `Move file to trash` will generate a new dmenu prompt.
	- Choose any file to move to trash.
	- To move a directory to trash, enter the directory, and choose `./` to confirm this directory..
	- `Bulk Trash` for multi-selection
	- `Bulk Trash all` to delete all the content in the directory.
- `Go to trash` will `cd` to trash directory.
- `Empty trash` will remove all files/directories in trash directory.

#### `REM` to rename files / directories

- Open the name of the selected files / directories to your `$EDITOR` / text editor.
	- `Bulk Rename` for multi-selection
	- `Bulk Rename all` to delete all the content in the directory.

#### `HIS` to record history

- history file stored in `$HOME/.config/dmenufm/dmenufm_history`.
- The maximum number of history is 5000.

#### `BMK` to store as bookmarks

- Choose the listed bookmark to enter that directory. Bookmarks are stored in `$HOME/.config/dmenufm/dmenufm_bookmark`
- Choose `Add BMK` to browse between directories using new dmenu prompt.
	- To add file to bookmark, choose files in new dmenu prompt.
	- To add directory to bookmark, enter the directory and choose `./` to confirm.
- Choose "Delete BMK" to delete one file/directory in bookmark.

#### `CMD` to store command

- Choose "Add CMD" to add both the command and command description in `$HOME/.config/dmenufm/dmenufm_command`.
- Choose "Delete CMD" to delete any command in `$HOME/.config/dmenufm/dmenufm_command`.
- Choose any stored command to execute.
	- If your command is a single command with no argument, e.g. `ncdu`, then dmenufm will open a terminal to run this command.
	- If your command has arguments, e.g. `chmod +x $1`, you only need to write one argument (`$1` part), and dmenufm will open a bulk mode, which allows you to choose files to execute.

##### `CMD` Notes:

GUI application will open only one windows, and terminal application will open a terminal for this command.

If there is no terminal opened for your terminal application, you need to modify `executecmd` function in `dmenufm`.

```sh
ExecCMD () { # Usage ExecCMD [CMD]
    software=$(printf '%s' "${1%% *}")
    appdesktop=$(find "$XDGDIR1" "$XDGDIR2" -name "*$software*.desktop" | tail -n 1)
    if [ -n "$appdesktop" ] && grep 'Terminal=false' "$appdesktop"; then
	printf '%s' "$1" | ${SHELL:-"/bin/sh"}
    else
	$TERMINAL -e $1 | ${SHELL:-"/bin/sh"}
    fi
}
```

`$TERMINAL -e $1` is the one you need to modify.

#### `SDO` to enter super user mode

Enter you password to enter super user mode (sudo).

The prompt will be all red because this is a dangerous action.

#### `EYE` to preview your file

The `EYE` prompt will appear at the button of the screen.

Recommend using this function with [Rolling Menu](#rolling-menu)

Need `wmctrl` to automatically close the opened file.

### Open files

Files are opened using `xdg-open`. If you have any trouble, go to [troubleshooting on xdg-open](#why-files-do-not-open-in-the-right-application)

For compression, now you can choose the compression, and it will extract into a new directory named by the compression.

## Configuration

There are many environment variables you can use to configure dmenufm by exporting them in your system or shell configuration file.

The default options are as follows:

```sh
# FILES LOCATION
export FM_PATH="$HOME/.config/dmenufm"
export FM_CACHE_PATH="$HOME/.cache/dmenufm"
export FM_BMKFILE="$FM_PATH/dmenufm_bookmark"
export FM_CMDFILE="$FM_PATH/dmenufm_command"
export FM_HISFILE="$FM_PATH/dmenufm_history"
export FM_SDOPROP="$FM_PATH/dmenufm_sudoprompt"
export FM_LASTPATH="$FM_CACHE_PATH/dmenufm_lastpath"
export FM_REMFILE="$FM_CACHE_PATH/dmenufm_bulk_rename"
export FM_ZIPATH="$FM_CACHE_PATH/compression/"
export FM_TRASH="$FM_CACHE_PATH/trash"
# Max number for history
export FM_MAX_HIS_LENGTH=5000
# FONTS
export FM_GENERIC_FONT="Monospace-15"
export FM_NOTIF_FONT="Monospace-25"
export FM_DANGER_FONT="Monospace-20"
# COLORs
export FM_GENERIC_COLOR="#005577"
export FM_SUDO_COLOR="red"
export FM_ACTION_COLOR_LV1="#33691e"
export FM_ACTION_COLOR_LV2="#FF8C00"
export FM_ACTION_COLOR_BULK="#CB06CB"
```

## Note

If you hate GUIarrowy world like me, based on `man dmenu`, you can

- `Ctrl-n` to go up,
- `Ctrl-p` to go down,
- `Ctrl-y` to paste from primary X selection
	- Everything your "are selecting" can be paste into dmenu by this hot key.
- `Meta-h` to go up,
- `Meta-l` to go down,
- `Meta-k` to go one page up,
- `Meta-j`  to go one page down,

where `Meta` is also called `Alt`.

## Troubleshooting

### Why some of my GUI app will open in terminal?

For GUI application like `sxiv`, default setting will open sxiv in a new terminal. In total, 2 windows will be opened.

This is because `sxiv.desktop` has no `Terminal=false` entry.

To fix this, use

```sh
< $(locate sxiv.desktop | tail -n 1) sudo ${EDITOR:-vi}
```

to open `.desktop` file in your editor, and add

```sh
Terminal=false
```

You can replace `sxiv` to any GUI application which has the same issue.

### Why files do not open in the right application

`dmenufm` use `xdg-open` to open files in the default application.

To open in the application that you want, you need to
1. find the filetype (`minor/major`) of the file
2. Set xdg-open default applications.

For example, I am using `sxhkd`. So I need to modify `sxhkdrc`. However, it is not opened in `nvim.desktop`, but in `firefox.desktop`.

So I

1. find the filetype:
	```sh
	# Go to directory
	cd ~/.config/sxhkd
	# find the filetype
	xdg-mime query filetype sxhkdrc
	```
	Find filetype `text/x-matlab`
1. Set `xdg-open` default applications:
	```sh
	xdg-mime default nvim.desktop text/x-matlab
	```

and you are all set.

### I want to configure the color and font of dmenufm

You can export the following environment variables in your shell (such as `.bashrc`) or system configuration file (such as `.profile`):

```sh
# FONTS
export FM_GENERIC_FONT="Monospace-15"
export FM_NOTIF_FONT="Monospace-25"
export FM_DANGER_FONT="Monospace-20"
# COLORs
export FM_GENERIC_COLOR="#005577"
export FM_ACTION_COLOR_LV1="#33691e"
export FM_ACTION_COLOR_LV2="#FF8C00"
export FM_ACTION_COLOR_BULK="#CB06CB"
export FM_SUDO_COLOR="red"
```

Change the font / font size / color in the `""` to customize the appearance  of dmenufm.


## TODO

See `Issues`.

