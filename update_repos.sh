#!/bin/bash
###################################################
# Name:    update_repos.sh
# Purpose: for git repositories that you have cloned locally but are not
#          making any edits upon.

SOURCE_DIR=~/src
 
cd $SOURCE_DIR 

for REPO in `ls -d */ | sed 's/\///' `
	do 
		echo "Updating $REPO"
		cd $REPO
		git pull
		cd ..
done
