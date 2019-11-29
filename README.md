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
- ~~`dunst` as notification daemon, and `notify-send` to send notification.~~
	- Use `dmenu` to show notification.

# Installation

Put `dmenufm` in your `$PATH`.

(`dmenufm-ext` is file for extraction. Use this file into `dmenufm` is one of the TODO list.)

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
-p | --lastpath: dmenufm open on last working directory
-h | --help: Show this message
```

## Terminal

`Terminal` to open terminal in currend working directory.


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

# Dmenufm-ext

`dmenufm-ext` is a POSIX compliant shell script that extract files.

~~Now this script are able to extract compression file by choosing it in dmenufm.~~

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

## Dmenu font is too big/small

Open `dmenufm` script, and you can change the following three variables:

```sh
GENEFONT="Monospace-20"
NOTIFONT="Monospace-30"
DANGERFONT="Monospace-30"
```

- `GENEFONT` for general dmenu font size,
- `NOTIFONT` for notification prompt, and
- `DANGERFONT` for dangerous prompt for further confirmation in `RMM` and `TRH`.


# TODO

- Compress directory and extract files to different format.
- `cp` function


