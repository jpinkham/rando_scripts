#!/usr/bin/env bash

FILE="all_remote_syslogs.log"

if [[ "$HOSTNAME" == "TheCheat" ]]; then
    DIRNAME="/usr/share/extra_storage/syslog"
else
    DIRNAME="/mnt/thecheat_storage/syslog"
fi

sudo tail -n 2500 --follow=name --retry $DIRNAME/$FILE|grep -ivE 'rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo'
