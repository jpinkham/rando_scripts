#!/bin/bash

AGENT_OUTPUT=`ssh-add -l 2>&1`

if [[ $AGENT_OUTPUT == "Error connecting to agent: No such file or directory" ]] || [[ $AGENT_OUTPUT == "Error connecting to agent: Connection refused" ]] || [[ $AGENT_OUTPUT == "Could not open a connection to your authentication agent." ]] || [[ $SSH_AGENT_PID == "" ]]; then
    echo "No SSH agent running. Starting one and adding keys"
    eval $(ssh-agent)
    ssh-add -t 999999 ~/.ssh/github_rsa > /dev/null 2>&1
    ssh-add -t 999999 ~/.ssh/id_github  > /dev/null 2>&1
    ssh-add -t 999999 ~/.ssh/id_rsa  > /dev/null 2>&1
elif [ "$AGENT_OUTPUT" == "The agent has no identities." ]; then
    echo "SSH agent running but contains no keys. Adding."
    ssh-add -t 999999 ~/.ssh/github_rsa > /dev/null 2>&1
    ssh-add -t 999999 ~/.ssh/id_github  > /dev/null 2>&1
    ssh-add -t 999999 ~/.ssh/id_rsa  > /dev/null 2>&1
else
    echo "SSH agent already running and already contains keys"
    ssh-add -t 9999999 ~/.ssh/id_github  > /dev/null 2>&1
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

