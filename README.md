# Dmenufm

A simple dmenu file manager written in POSIX-compliant shell script.

[![Distrotube introduce my project better than me.](https://img.youtube.com/vi/EyW6pRlWv6Q/0.jpg)](https://www.youtube.com/watch?v=EyW6pRlWv6Q)

[Distrotube](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg) introduce my project much better than I do.

# Some gifs

![Dmenufm Introduction 1](./figure/dmenufm_1.gif)
![Dmenufm Introduction 2](./figure/dmenufm_2.gif)

# Dependency

- `awk`, `sed`, `cat`, `wc -l`, `rm`, `mkdir`, `touch` in their POSIX-compliant version.
- `xclip` as clipboard
- `tar`; `unlzma`; `bunzip2`; `unrar`; `unzip`; `uncompress`; `7z`; `unxz`; `cabextract` for extraction.

# Installation

Put `dmenufm` in your `$PATH`.

# Usage

1. Type `dmenufm` to launch, or assign `dmenufm` to your favorite hot key. You may supply a directory as an argument to start dmenufm in the specified directory.
2. `../` to go back to parent directory.
3. `./` to open your file manager in currend working directory (determined by `xdg-open`)
4. Choices with `/` are directory; choices without `/` are files.


```sh
Optional arguments for custom usage:
-d | --directory: dmenufm only show directories
-f | --file: dmenufm only show files
-D | --dotdirectory: dmenufm only show hidden directories
-F | --dotfile: dmenufm only hidden files
-p | --lastpath: dmenufm open on last working directory (cd on exit)
-h | --help: Show this message
```

## Terminal

`Terminal` to open terminal in currend working directory. Should define terminal by adding
`export TERMINAL=<your terminal>` to the end of your `.bashrc` file (or any other system configuration file, like `.profile`, `zshrc`, etc).

## CD on exit

Use `-p` option:

```sh
dmenufm -p
```

## Actions

`Actions` is the actions you can do.

### `PCP` to copy path.

Example:

- current working directory is `$HOME`, if press `ESC` to leave dmenufm, then `$HOME` will be copied into `xclip`.
- You can browse into the any directory. Inside that directory, choose `./`, and current working directory will be copied.

### `NEW` to make new file / directory

Name with slash will consider as a directory; without as file.
- Example: Type `dirname/` to create new directory, and `filename` to create new file.

### `MVR` to move / rename file

- To move file to destination:
	- Choose source and destination to move your file. Enter the directory and choose `./` to confirm the destination.
	- `Bulk Move` for multi-selection
	- `Bulk Move all` to move all the content in the directory.
- To rename file:
	- After choosing source, in the destination, type your new name (No need to add slash even for directory), and press `Shift+Return` to confirm inputed new name.
	- Note: `Shift+Return` will confirm the input rather than patched menu item.

### `YAK` to copy files

- The usage of this action is the same as `MVR`, but will copy the file instead of moving it.

### `LNK` to create symbolic links

- The usage of this action is the same as `MVR`, but will create the symbolic link for the file instead of moving it.

### `DEL` to remove

Delete directories or files.

- `Bulk Delete` for multi-selection
- `Bulk Delete all` to delete all the content in the directory.

### `TRH` to put in trash.

- `$HOME/.config/dmenufm/trash` is the directory storing trashes for dmenufm.
- `Move file to trash` will generate a new dmenu prompt.
	- Choose any file to move to trash.
	- To move a directory to trash, enter the directory, and choose `./` to confirm this directory..
	- `Bulk Trash` for multi-selection
	- `Bulk Trash all` to delete all the content in the directory.
- `Go to trash` will move current working directory to trash directory.
- `Empty trash` will remove all files/directories in trash directory.

### `REM` to rename files / directories

- Open the name of the selected files / directories to your `$EDITOR` / text editor.
	- `Bulk Rename` for multi-selection
	- `Bulk Rename all` to delete all the content in the directory.

### `HIS` to record history
- history file stored in `$HOME/.config/dmenufm/dmenufm_history`.
- The maximum number of history is 5000.

### `BMK` to store as bookmarks
- Choose the listed bookmark to enter that directory. Bookmarks are stored in `$HOME/.config/dmenufm/dmenufm_bookmark`
- Choose "Add BMK" to browse between directories using new dmenu prompt.
	- To add file to bookmark, choose files in new dmenu prompt.
	- To add directory to bookmark, enter the directory and choose `./` to confirm.
- Choose "Delete BMK" to delete one file/directory in bookmark.

### `CMD` to store command

- Choose "Add CMD" to add both the command and command description in `$HOME/.config/dmenufm/dmenufm_command`.
- Choose "Delete CMD" to delete any command in `$HOME/.config/dmenufm/dmenufm_command`.
- Choose "Type and execute" to type and execute command.
- Choose any stored command to execute.

#### `CMD` Notes:

GUI application will open only one windows, and terminal application will open a terminal for this command.

If there is no terminal opened for your terminal application, you need to modify `executecmd` function in `dmenufm`.
```sh
executecmd () {
	software=$(printf '%s' "$1" | awk -F ' ' '{print $1}')
	if < $(locate $software.desktop | tail -n 1) grep "Terminal=false"; then
		printf '%s' "$1" | ${SHELL:-"/bin/sh"} &
	else
		$TERMINAL -e $1 | ${SHELL:-"/bin/sh"} &
	fi
}
```

`$TERMINAL -e $1` is the one you need to modify.

## Open files

Files are opened using `xdg-open`. If you have any trouble, go to [troubleshooting on xdg-open](#why-files-do-not-open-in-the-right-application)

For compressions, now you can choose the compression, and it will extract into a new directory named by the compression.

# Configuration

There are many environment variables you can use to conigure dmenufm by exporting them in your system or shell configuration file.

The default options are as follows:
```sh
# FILES LOCATION
export FM_PATH="$HOME/.config/dmenufm"
export FM_TRASH="$FM_PATH/trash"
export FM_BMKFILE="$FM_PATH/dmenufm_bookmark"
export FM_CMDFILE="$FM_PATH/dmenufm_command"
export FM_HISFILE="$FM_PATH/dmenufm_history"
export FM_LASTPATH="$FM_PATH/dmenufm_lastpath"
export FM_REMFILE="$FM_PATH/dmenufm_bulk_rename"
# Max number for history
export FM_MAX_HIS_LENGTH=5000
# FONTS
export FM_GENERIC_FONT="Monospace-15"
export FM_NOTIF_FONT="Monospace-25"
export FM_DANGER_FONT="Monospace-20"
# COLORs
export FM_GENERIC_COLOR="#005577"
export FM_ACTION_COLOR_LV1="#33691e"
export FM_ACTION_COLOR_LV2="#FF8C00"
export FM_ACTION_COLOR_BULK="#CB06CB"
```

# Note

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

# Troubleshooting

## Why some of my GUI app will open in terminal?

For GUI application like `sxiv`, default setting will open sxiv in a new terminal. In total, 2 windows will be opened.

This is because `sxiv.desktop` has no `Terminal=false` entry.

To fix this, use

```sh
< $(locate sxiv.desktop | tail -n 1) sudo $EDITOR
```

to open `.desktop` file in your editor, and add

```sh
Terminal=false
```

You can replace `sxiv` to any GUI application which has the same issue.

## Why files do not open in the right application

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

## I want to configure the color and font of dmenufm

You can export the following environment variables in your shell or system configuration file:

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
```

Change the font / font size / color in the `""` to customize the appearance  of dmenufm.


# TODO

- Compress directory ~~and extract files~~ to different format.
- Support MacOS (darwin)
