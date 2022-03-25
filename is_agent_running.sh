#!/bin/bash

AGENT_OUTPUT=`ssh-add -l 2>&1`

function add_keys() {
    # Load every private key that starts with "id_"
    for KEY in $(find ~/.ssh/ -name "id_*"|grep -v pub); do
        ssh-add -t 999999 $KEY > /dev/null 2>&1;
    done
}

if [[ $AGENT_OUTPUT == "Error connecting to agent: No such file or directory" ]] || [[ $AGENT_OUTPUT == "Error connecting to agent: Connection refused" ]] || [[ $AGENT_OUTPUT == "Could not open a connection to your authentication agent." ]] || [[ $SSH_AGENT_PID == "" ]]; then
    echo "No SSH agent running. Starting one and adding keys"
    eval $(ssh-agent)
    add_keys
elif [ "$AGENT_OUTPUT" == "The agent has no identities." ]; then
    echo "SSH agent running but contains no keys. Adding."
    add_keys
else
    echo "SSH agent already running and contains keys"
fi

export SSH_AGENT_PID
export SSH_AUTH_SOCK

echo "---------------------------------------------------"

echo "SSH Agent identity list:"
# Not sure how else to ignore the complaints about protocol type 1 queries being refused by agent, beyond sending STDERR to the trash
ssh-add -l 2>/dev/null

echo
echo "SSH Env vars:"
echo "SSH_AGENT_PID = $SSH_AGENT_PID"
echo "SSH_AUTH_SOCK = $SSH_AUTH_SOCK"
echo "---------------------------------------------------"

