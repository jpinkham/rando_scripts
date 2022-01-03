#!/bin/bash
# shellcheck disable=SC2035,SC2045
###################################################
# Name:    update_repos.sh
# Purpose: for git repositories that you have cloned locally but are not planning to modify
# WARN: you will clobber work in progress if you've made any modifications
#
SOURCE_DIR=$1 && echo "Using source directory >$SOURCE_DIR<"

cd "$SOURCE_DIR" || { echo "Could not change to directory >$SOURCE_DIR<"; exit 1; }

for REPO in $(ls -d *) 
 # SC2045: Iterating over ls output is fragile. Use globs.
 # SC2035: Use ./*glob* or -- *glob* so names with dashes won't become options
	do
		echo "Updating $REPO"
		cd "$REPO" || { echo "Could not change to directory >$REPO<"; exit 1; }

        # Adds 4 spaces in front of output from git command, without including default newline
        echo -n "    "  
		git pull

		cd ..
done

echo "Updates complete"
