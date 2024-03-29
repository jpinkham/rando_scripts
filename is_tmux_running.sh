#! /bin/bash
#So I don't accidentally create a whole bunch of sessions, check if my main one is already running
tmux has-session -t JPDefault
if [ $? -eq 0 ]
then
	echo "Session already running. Now attaching..." 
    # echo the commands to all bash shells to point to same ssh agent, which was already started and had keys loaded. the socket will change regularly, so it will need to be updated in any running bash session

    for i in 1 2 3 ;do
        # send Ctrl-u to clear whatever was left on the command line
        tmux send-keys -t$i C-u

        # run history command to append current bash history to .bash_history
        tmux send-keys -t$i "history -a" Enter

        # I'll be able to use the SSH agent keys that are available outside tmux
        # so I can use git operations in any bash shell without being prompted for password
        tmux send-keys -t$i "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" Enter
    done

	tmux attach 
else 
	echo "No session exists. Creating JPDefault..."
	sleep 1

	echo "Determined OSTYPE=$OSTYPE"
	echo "Determined HOSTNAME=$HOSTNAME"

	# determine which config file to load
	TMUXP_FILE="tmuxp_base.yaml"
	test $OSTYPE = "darwin19" && TMUXP_FILE="tmuxp_osx.yaml"
	test $OSTYPE = "linux-gnueabihf" && TMUXP_FILE="tmuxp_pi3.yaml"
	test $OSTYPE = "linux-gnu" && TMUXP_FILE="tmuxp_VPS.yaml"
	test $HOSTNAME = "RaspberryPi3" && TMUXP_FILE="tmuxp_pi3.yaml"
	test $HOSTNAME = "DietPiHole" && TMUXP_FILE="tmuxp_dietpihole.yaml"
	test $HOSTNAME = "TheCheat" && TMUXP_FILE="tmuxp_TheCheat.yaml"

	echo "Loading $TMUXP_FILE..."

    # this script must be "sourced" or env vars created will not be available inside tmux session
    # SC1091 is triggered when shellcheck can't/won't follow a file in a 'source' command
    # shellcheck disable=SC1091
    source $HOME/dev/rando_scripts/is_agent_running.sh

	# wait 2 seconds so I can see what config file is loading
	sleep 2
    # codegirl claims this can't be found when run as initial command from Shelly ios app, so added symlink
	$HOME/bin/tmuxp load $HOME/dev/dotfiles/tmux/$TMUXP_FILE 
    echo "Attaching."
	tmux attach
fi
