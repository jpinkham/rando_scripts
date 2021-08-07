#!/bin/bash
# blank line for readability
echo

# POSIX-format, human-readable sizes, local filesystems only -- exclude output for tmpfs and pseudo-filesystems
#df --portability --human-readable --local|grep -vE 'loop|tmpfs|udev'

# easier -- just limit to ext4
 test "$MACHTYPE" = "x86_64-pc-linux-gnu" && df --portability --human-readable --local --type ext4

# compatible with BSD/MacOS
 test "$MACHTYPE" = "x86_64-apple-darwin19" && df -H -T ext4,hfs,apfs
