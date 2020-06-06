#!/bin/sh
sudo tail -n 2500 --follow=name --retry /mnt/thecheat_storage/syslog/all_remote_syslogs.log|grep -ivE 'rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo'
