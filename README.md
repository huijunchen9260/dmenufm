# Dmenufm

![Dmenufm Introduction 1](./figure/dmenufm_1.gif)
![Dmenufm Introduction 2](./figure/dmenufm_2.gif)

A simple dmenu file manager written in POSIX-compliant shell script.

## Dependency

- `awk`, `sed`, `cat`, `wc -l`, `rm`, `mkdir`, `touch` in their POSIX-compliant version.
- `xclip` as clipboard
- `dunst` as notification daemon, and `notify-send` to send notification.

## Installation

Put both `dmenufm` and `dmenufm-open` in your `$PATH`.

## Usage

1. Type `dmenufm` to launch, or assign `dmenufm` to your favorite hot key.
2. `../` to go back to parent directory.
3. `./` to open your file manager (determined by `dmenufm-open`)
4. Choices with `/` are directory; choices without `/` are files.
5. Use `dmenufm-open` to open directories / files.
6. `Actions` is the actions you can do.
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

Note: If you hate GUIarrowy world like me, based on `man dmenu`, you can

- `Ctrl-n` to go up,
- `Ctrl-p` to go down,
- `Ctrl-y` to paste from primary X selection
	- Everything your "are selecting" can be paste into dmenu by this hotkey.
- `Meta-h` to go up,
- `Meta-l` to go down,
- `Meta-k` to go one page up,
- `Meta-j`  to go one page down,

where `Meta` is also called `Alt`.

## TODO

- Extract / Conpress directory to different format.


