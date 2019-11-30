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

1. Type `dmenufm` to launch, or assign `dmenufm` to your favorite hot key.
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
- To rename file:
	- After choosing source, in the destination, type your new name (No need to add slash even for directory), and press `Shift+Return` to confirm inputed new name.
	- Note: `Shift+Return` will confirm the input rather than patched menu item.

### `CPP` to copy files to new / existing file

- The usage of this action is the same as `MVR`, but will copy the file instead of moving it.

### `RMM` to remove

Remove one directory or file.

### `TRH` to put in trash.

- `$HOME/.config/dmenufm/trash` is the directory storing trashes for dmenufm.
- `Move file to trash` will generate a new dmenu prompt.
	- Choose any file to move to trash.
	- To move a directory to trash, enter the directory, and choose `./` to confirm this directory..
- `Go to trash` will move current working directory to trash directory.
- `Empty trash` will remove all files/directories in trash directory.


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
export DMENUFM_PATH="$HOME/.config/dmenufm"
export DMENUFM_TRASH_PATH="$DMENUFM_PATH/trash"
export DMENUFM_BMKFILE="$DMENUFM_PATH/dmenufm_bookmark"
export DMENUFM_CMDFILE="$DMENUFM_PATH/dmenufm_command"
export DMENUFM_HISFILE="$DMENUFM_PATH/dmenufm_history"
export DMENUFM_LAST_PATH_FILE="$DMENUFM_PATH/dmenufm_lastpath"
export DMENUFM_MAX_HIS_LENGTH=5000
export DMENUFM_GENERIC_FONT="Monospace-15"
export DMENUFM_NOTIF_FONT="Monospace-25"
export DMENUFM_DANGER_FONT="Monospace-20"
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

## Dmenu font is too big/small

You can export the following environment variables in your shell or system configuration file:

```sh
DMENUFM_GENERIC_FONT="Monospace-20"
DMENUFM_NOTIF_FONT="Monospace-30"
DMENUFM_DANGER_FONT="Monospace-30"
```

- `DMENUFM_GENERIC_FONT` for general dmenu font size,
- `DMENUFM_NOTIF_FONT` for notification prompt, and
- `DMENUFM_DANGER_FONT` for dangerous prompt for further confirmation in `RMM` and `TRH`.


# TODO

- Compress directory ~~and extract files~~ to different format.
- Ranger style bulk rename
- Support MacOS (darwin)
- Multi-choices action
- Function to set up the xdg-open default application (Or is there any file that I can modify to just set up all my files once permanently?)
