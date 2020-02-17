#!/bin/bash
sqlite3 /etc/pihole/pihole-FTL.db "SELECT domain FROM queries WHERE client = '192.168.11.18' ORDER BY id DESC LIMIT 20;"
