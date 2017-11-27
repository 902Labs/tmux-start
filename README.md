## TMUX Start Util

### What
tmux-start is a helper utility to manage tmux sessions with multiple projects and tickets.

### Why
Many developers who work in a TMUX+VIM or similar setup sometimes rely on having multiple sessions. I myself tend to be very specific with the windows I have open in tmux and their order and started to write scripts to start-up individual projects.

This personal script was an attempt to unify and simplify the approach

### How
tmux-start relies on a "project" folder containing folders of projects and "tickets" within. To me, "project" means client. Project just seemed more generic. You could easily cut out this step, or perhaps I should auto-skip/assume if there is only one project.

### Available Commands / Functions
- t-window: Creates a new window. First arg name, second arg optional relative path to base
- t-rename-window: Renames current window
- t-vSplit: Will create a vertical split line. Optional % width as first arg
- t-hSplit: Will create a horizontal split line. Optional % width as first arg
- t-left: moved the selected window to the left
- t-right: moved the selected window to the right

### Example script:
```
PBASE=~/clients/cool-company
COMMANDS="\
	t-rename-window \"Sandbox\"
	t-window \"Kubernetes\" /
	t-vSplit
	t-left
	t-hSplit
	t-window ui-project1
	t-window ui-project2
	t-window service-cart \
"
```


- The config is read by line breaks
- This is my second itteration, the goal is to remove as much as possible from this file making it as short and easy to config/maintain as possible
