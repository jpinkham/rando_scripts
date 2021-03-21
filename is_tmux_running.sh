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

	# determine which config file to load
	TMUXP_FILE="tmuxp_base.yaml"
	test $OSTYPE = "darwin19" && TMUXP_FILE="tmuxp_osx.yaml"
	test $OSTYPE = "linux-gnueabihf" && TMUXP_FILE="tmuxp_pi3.yaml"
	test $HOSTNAME = "RaspberryPi3" && TMUXP_FILE="tmuxp_pi3.yaml"
	test $HOSTNAME = "DietPiHole" && TMUXP_FILE="tmuxp_dietpihole.yaml"
	if [[ $HOSTNAME == "*code*" ]]; then 
		echo "\tDetected VPS server. Loading appropriate config"
		$TMUXP_FILE="tmuxp_VPS.yaml"; 
	fi


	tmuxp load $HOME/dev/dotfiles/tmux/$TMUXP_FILE 
	echo "Attaching."
	tmux attach
fi
