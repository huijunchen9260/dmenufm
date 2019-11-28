# Dmenufm

![Dmenufm Introduction 1](./figure/dmenufm_1.gif)
![Dmenufm Introduction 2](./figure/dmenufm_2.gif)

A simple dmenu file manager written in POSIX-compliant shell script.

## Dependency

- `awk`, `sed`, `cat`, `wc -l`, `rm`, `mkdir`, `touch` in their POSIX-compliant version.
- `xclip` as clipboard
- ~~`dunst` as notification daemon, and `notify-send` to send notification.~~
	- Use `dmenu` to show notification.

## Installation

Put both `dmenufm` and `dmenufm-open` in your `$PATH`.

## Usage

1. Type `dmenufm` to launch, or assign `dmenufm` to your favorite hot key.
2. `../` to go back to parent directory.
3. `./` to open your file manager (determined by `dmenufm-open`)
4. Choices with `/` are directory; choices without `/` are files.
5. Use `dmenufm-open` to open directories / files.

### CommandLine

`CommandLine` to execute any command in dmenufm.

GUI application will open only one windows, and terminal application will open a terminal for this command.

If you find the terminal command doesn't appear in your terminal, you need to modify `executecmd` function in `dmenufm`.

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

I am using urxvt. The default setting will match urxvt.



### Actions

`Actions` is the actions you can do.

- `CPP` to copy the directory path.
	- Example:
		- current working directory is `$HOME`, if press `ESC` to leave dmenufm, then `$HOME` will be copied into `xclip`.
		- You can browse into the any directory. Inside that directory, choose `./`, and current working directory will be copied.
- `MKD` and `MKF` make new directory or file to current working directory, respectively.
- `RMM` remove one directory and/or file.
- `TRH` is the trash function of dmenufm.
	- `$HOME/.config/dmenufm/trash` is the directory storing trashes for dmenufm.
	- `Move file to trash` will generate a new dmenu prompt.
		- Choose any file to move to trash.
		- To move a directory to trash, enter the directory, and choose `./` to confirm this directory..
	- `Go to trash` will move current working directory to trash directory.
	- `Empty trash` will remove all files/directories in trash directory.
- `HIS` records the history of all directories that you went.
	- history file stored in `$HOME/.config/dmenufm/dmenufm_history`.
	- The maximum number of history is 5000.
- `BMK` shows directories that you store as bookmarks.
	- Choose the listed bookmark to enter that directory. Bookmarks are stored in `$HOME/.config/dmenufm/dmenufm_bookmark`
	- Choose "Add BMK" to browse between directories using new dmenu prompt.
		- To add file to bookmark, choose files in new dmenu prompt.
		- To add directory to bookmark, enter the directory and choose `./` to confirm.
	- Choose "Delete BMK" to delete one file/directory in bookmark.
- `CMD` can store command that used frequently.
	- Choose any stored command to execute.
	- Choose "Add CMD" to add both the command and command description in `$HOME/.config/dmenufm/dmenufm_command`.
	- Choose "Delete CMD" to delete any command in `$HOME/.config/dmenufm/dmenufm_command`.
	- Choose "Type and execute" to type and execute command.

## Dmenufm-open

`Dmenufm-open` is a POSIX compliant shell script that opens the files/directories.

I use

- `libreoffice` for office stuff,
- `sxiv` for image,
- `mpv` for video,
- `inkscape` for svg,
- `nvim` for text file,
- `xdg-open` for others.

Now this script are able to extract compression file by choosing it in dmenufm.

Feel free to modify this opener to suit your need.

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
< $(locate sxiv.desktop | tail -n 1) sudo $EDITOR
```

to open `.desktop` file in your editor, and add

```sh
Terminal=false
```

You can replace `sxiv` to any GUI application which has the same issue.

## TODO

- Compress directory to different format.
- `mv` function
- `cp` function
- rename function (maybe use `mv`)


