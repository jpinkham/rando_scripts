#!/bin/bash
sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client IN('192.168.2.18','192.168.11.3','192.168.11.139','192.168.11.51') AND status=2 ORDER BY id DESC LIMIT 1" |sort|uniq -c|sort -g -r|head
