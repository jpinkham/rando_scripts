#!/bin/bash

IP=$1
LIMIT=$2

HOST=$(local_nslookup $IP)

echo "Displaying stats on last $LIMIT blocked items for host $HOST (IP $IP)"
echo "======================================================================"

# timeout is needed because it takes 10 sec for sqlite to timeout if zero results are returned from query
timeout 1.5s sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client = '$1' AND status=1 ORDER BY id DESC LIMIT $2;"|sort|uniq -c|sort -g -r|head
