#!/usr/bin/env bash

# Purpose: run as a cron job to alert me when disk usage is getting high

DISK_USAGE=$(df /System/Volumes/Data|tail -1 |awk '{print $5}'|sed 's/%//')
MAX_USAGE=85


if [[ $DISK_USAGE > $MAX_USAGE ]]; then
    echo "WARN! disk usage above $MAX_USAGE%"
fi
