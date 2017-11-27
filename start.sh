#!/bin/bash
# Bash Menu Script Example

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function newTmuxWindow {
	if [ -z "$4" ]; then
		tmux new-window -a -t $1 -n $3 -c "$2/$3"
	else
		tmux new-window -a -t $1 -n $3 -c "$2$4"
	fi
}

function startTmux {
	PROJECT=$1
	TICKET=$2
	SESSION="$1-$2"
	RUNNING=$(tmux ls | cut -d":" -f1 | grep "^$SESSION$")

	if [ -z "$RUNNING" ]; then
		. $BASEDIR/projects/$PROJECT/$TICKET.sh
	fi

	function t-vSplit {
		SPLIT=${1:-50}
		tmux splitw -h -p $SPLIT -c $PBASE
	}

	function t-hSplit {
		SPLIT=${1:-50}
		tmux splitw -v -p $SPLIT -c $PBASE
	}

	function t-left {
		tmux select-pane -L
	}

	function t-right {
		tmux select-pane -R
	}

	function t-window {
		if [ -z "$2" ]; then
			tmux new-window -a -t $SESSION -n $1 -c "$PBASE/$1"
		else
			tmux new-window -a -t $SESSION -n $1 -c "$PBASE$2"
		fi
	}

	function t-rename-window {
		tmux rename-window "$1"
	}

	if [ ! -z "$COMMANDS" ]; then
		# START THE NEW SESSION
		tmux new -d -s $SESSION -c $PBASE

		IFS=$'\n'
		for INSTR in $COMMANDS
		do
			eval $INSTR
		done
	fi

	tmux select-window -t 0
	tmux a -t $SESSION
}


function choose_session {
	PROJECT=$1
	PS3='Please choose a session: '

	options=$(find $BASEDIR/projects/$PROJECT -maxdepth 1 -type f | rev | cut -d/ -f1 | rev | cut -d. -f1)

	select TICKET in $options
	do
		startTmux $PROJECT $TICKET
		break
	done
}

function choose_project {
	if [ -z "$1" ]; then
		PS3='Please choose a project: '

		options=$(find $BASEDIR/projects/* -maxdepth 1 -type d | xargs basename)

		select PROJECT in $options
		do
			choose_session $PROJECT
			break
		done
	else
		choose_session $1
	fi
}

choose_project $1
