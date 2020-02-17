#!/bin/bash
echo
echo "Partition     total  used free  %Used   Mount point"
echo "------------------------------------------------------"
df -h|grep -E 'nvm|sda' --color=never|grep -v boot
