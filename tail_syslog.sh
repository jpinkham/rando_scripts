#!/bin/sh
sudo tail -n 2500 --follow=name --retry /var/log/messages|grep -ivE 'rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo'
