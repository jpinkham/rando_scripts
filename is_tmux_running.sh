#! /bin/bash
tmux has-session -t JPDefault
if [ $? -eq 0 ]
then
    echo "Session already running. Now attaching..." 
    sleep 1
    tmux attach 
else 
    echo "No session exists. Creating JPDefault..."
    sleep 1
    tmuxp load ~/dev/openstack_stuff/tmuxp-multi-window-bash.yaml
    echo "Attching."
    tmux attach
fi
