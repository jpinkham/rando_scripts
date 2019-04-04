#!/bin/bash
###################################################
# Name:    update_repos.sh
# Purpose: for git repositories that you have cloned locally but are not planning to modify
# WARN: you will clobber work in progress if you've made any modifications
#          

SOURCE_DIR=$1 || $HOME/src/

cd $SOURCE_DIR 

for REPO in `ls -d */ | sed 's/\///' `
	do 
		echo "Updating $REPO"
		cd $REPO
		git pull
		cd ..
done

echo "Updates complete"
