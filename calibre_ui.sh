#!/bin/bash
echo "Stopping calibre server."
sudo service calibre-server stop
echo "Starting up GUI..."
sleep 1
calibre-debug --gui
echo "Restarting calibre server..."
sudo service calibre-server start
sudo service calibre-server status
