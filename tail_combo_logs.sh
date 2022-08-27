#!/usr/bin/env bash

FILE="all_remote_syslogs.log"
IPADDRESS=$(ifconfig|grep 192|awk '{print $2}')

if [[ "$HOSTNAME" == "TheCheat" ]]; then
    DIRNAME="/usr/share/extra_storage/syslog"
else
    DIRNAME="/mnt/thecheat_storage/syslog"
fi

# filter log entries we don't care about, including entries from current host
# pipe through local_dns_lookups.sh to dynamically convert ip addresses to hostnames
sudo tail -n 2500 --follow=name --retry $DIRNAME/$FILE|grep -ivE "rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo|ntpd|certbot|$IPADDRESS"
# figure out how to extract ip from message and run it against lical_dns_lookup.sh in order to show short hostnames
