#!/bin/bash
sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client = '192.168.11.118' AND status=1 ORDER BY id DESC LIMIT $1;"|sort|uniq -c|sort -g -r|head
