#!/usr/bin/env bash

TODAY=$(date +%Y%m%d)
FILENAME="$HOME/Dropbox/Backups/Macs/Marzipan.homebrew-installs.$TODAY.json"
touch $FILENAME || exit 1
brew info --json --installed > "$FILENAME"

