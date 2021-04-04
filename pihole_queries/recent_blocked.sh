#!/bin/bash

IP=$1 || 192.168.2.18
LIMIT=$2 || 10

HOST=$(local_nslookup $IP)

echo "Displaying stats on last $LIMIT blocked items for host $HOST (IP $IP)"
echo "======================================================================"

#SELECT_STMT="SELECT domain FROM queries WHERE client = '$IP' AND status=1 ORDER BY id DESC LIMIT $LIMIT;"
#echo "DEBUG: Running SQL >$SELECT_STMT<"

# timeout is needed because it takes 10 sec for sqlite to timeout if zero results are returned from query
#CMD_TO_RUN="timeout 1.5s sqlite3 /etc/pihole/pihole-FTL.db \\"$SELECT_STMT\\" | sort | uniq -c | sort -g -r | head"
#echo "DEBUG: Running command >$CMD_TO_RUN<"

# This simple line works for recent_allowed, so we're going to re-use and tweak, instead of getting fancy and making a mess as I've done above
#timeout 1.5s sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client = '$IP' AND status=2 ORDER BY id DESC LIMIT $LIMIT;"|sort|uniq -c|sort -g -r|head

timeout 1.5s sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client = '$IP' AND status=1 ORDER BY id DESC LIMIT $LIMIT;"|sort|uniq -c|sort -g -r|head
