#!/bin/bash
###################################################
# Name:    update_repos.sh
# Purpose: for git repositories that you have cloned locally but are not planning to modify
# WARN: you will clobber work in progress if you've made any modifications
#
SOURCE_DIR=$1 && echo "Using source directory >$SOURCE_DIR<"

cd "$SOURCE_DIR" || { echo "Could not change to directory >$SOURCE_DIR<"; exit 1; }

for REPO in `ls -d */ | sed 's/\///' `
	do
		echo "Updating $REPO"
		cd "$REPO" || { echo "Could not change to directory >$REPO<"; exit 1; }
		git pull
		cd ..
done

echo "Updates complete"
