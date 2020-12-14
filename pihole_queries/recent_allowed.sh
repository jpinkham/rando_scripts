#!/bin/bash


IP=$1 || 192.168.2.18;
LIMIT=$2 || 10;
HOST=$(local_nslookup $IP)

echo "Displaying stats on last $LIMIT allowed items for host $HOST (IP $IP)"
echo "======================================================================"

# timeout is needed because it takes 10 sec for sqlite to timeout if zero results are returned from query
timeout 1.5s sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client = '$IP' AND status=2 ORDER BY id DESC LIMIT $LIMIT;"|sort|uniq -c|sort -g -r|head
