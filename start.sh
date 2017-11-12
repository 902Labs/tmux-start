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

	tmux select-window -t 0
	tmux a -t $SESSION
}


function choose_session {
	PROJECT=$1
	PS3='Please choose a session: '

	options=$(find $BASEDIR/projects/$PROJECT -maxdepth 1 -type f | rev | cut -d/ -f1 | rev | cut -d. -f1)
	find $BASEDIR/projects/$PROJECT -maxdepth 1 -type f

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
