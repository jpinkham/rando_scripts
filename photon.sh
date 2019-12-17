#!/bin/bash

# Photon OSINT crawler tool
# Runs as a Docker container

HOST2SCAN=$1;
echo "Running Photon on >$HOST2SCAN<"; 
RESULTS_DIR="$HOME/data/Photon/$HOST2SCAN";
echo "Results will be available in >$RESULTS_DIR<";
sudo docker run -it -v "$RESULTS_DIR:/Photon/$HOST2SCAN" photon:latest --url $HOST2SCAN --wayback -v
