## TMUX Start Util

### What
tmux-start is a helper utility to manage tmux sessions with multiple projects and tickets.

### Why
Many developers who work in a TMUX+VIM or similar setup sometimes rely on having multiple sessions. I myself tend to be very specific with the windows I have open in tmux and their order and started to write scripts to start-up individual projects.

This personal script was an attempt to unify and simplify the approach

### How
tmux-start relies on a "project" folder containing folders of projects and "tickets" within. To me, "project" means client. Project just seemed more generic. You could easily cut out this step, or perhaps I should auto-skip/assume if there is only one project.

### Example script:
```
#!/bin/bash

PBASE=~/clients/cool-company

# Start a new session
tmux new -d -s $SESSION -c $PBASE

# Rename the first window Sandbox
tmux rename-window "Sandbox"

# Create a new window at the root with a name of Kubernetes
newTmuxWindow $SESSION $PBASE "Kubernetes" /

# Create 4 new windows in the sub-folder and the name of the 3rd arg
newTmuxWindow $SESSION $PBASE ui-project1;
newTmuxWindow $SESSION $PBASE ui-project2;
newTmuxWindow $SESSION $PBASE service-cart;
newTmuxWindow $SESSION $PBASE service-identity;
```

- SESSION is inherited from the script, don't override this
- This is my first itteration, the goal is to remove as much as possible from this file making it as short and easy to config/maintain as possible
