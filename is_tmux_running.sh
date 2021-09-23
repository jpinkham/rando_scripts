#! /bin/bash
#So I don't accidentally create a whole bunch of sessions, check if my main one is already running
tmux has-session -t JPDefault
if [ $? -eq 0 ]
then
	echo "Session already running. Now attaching..." 
	sleep 1
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

	sleep 1
# this script must be "sourced" or env vars created will not be available inside tmux session
    source $HOME/dev/rando_scripts/is_agent_running.sh

	# wait 2 seconds so I can see what config file is loading
	sleep 2
	tmuxp load $HOME/dev/dotfiles/tmux/$TMUXP_FILE 
	echo "Attaching."
	tmux attach
fi
