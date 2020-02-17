#!/bin/bash
# blank line for readability
echo

# POSIX-format, human-readable sizes, local filesystems only -- exclude output for tmpfs and pseudo-filesystems
#df --portability --human-readable --local|grep -vE 'loop|tmpfs|udev'

# easier -- just limit to ext4
df --portability --human-readable --local --type ext4
