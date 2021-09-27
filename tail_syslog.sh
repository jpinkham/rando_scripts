#!/usr/bin/env bash

sudo tail -n 2500 --follow=name --retry /var/log/messages /var/log/syslog |grep -ivE 'rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo' | sed "s/$HOSTNAME //"
