# Dmenufm

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
	- `CPP` to copy the directory path under current directory.
		- Example:
			- current working directory is `$HOME`, if press `ESC` to leave dmenufm, then `$HOME` will be copied into `xclip`.
			- If press one directory in `$HOME`, then `$HOME/target_dir/` will be copied.
	- `MKD` and `MKF` make new directory or file to current working directory, respectively.
	- `RMM` remove one directory and/or file.
	- `TRH` is the trash function of dmenufm.
		- `$HOME/.config/dmenufm/trash` is the directory storing trashes for dmenufm.
		- `Move file to trash` will move one file/directory in current working directory into trash
		- `Go to trash` will move current working directory to trash directory.
		- `Empty trash` will remove all files/directories in trash directory.
	- `HIS` records the history of all directories that you went.
		- history file stored in `$HOME/.config/dmenufm/dmenufm_history`.
		- The maximum number of history is 5000.
	- `BMK` shows directories that you store as bookmarks.
		- Choose the listed bookmark to enter that directory. Bookmarks are stored in `$HOME/.config/dmenufm/dmenufm_bookmark`
		- Choose "Add BMK" to add current directory as bookmark.
		- Choose "Delete BMK" to delete one directory in bookmark.

Note: If you hate GUIarrowy world like me, based on `man dmenu`, you can

- `Ctrl-n` to go up,
- `Ctrl-p` to go down,
- `Meta-h` to go up,
- `Meta-l` to go down,
- `Meta-k` to go one page up,
- `Meta-j`  to go one page down,

where `Meta` is also called `Alt`.

## TODO

- Extract / Conpress directory to different format.


