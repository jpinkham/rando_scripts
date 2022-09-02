#!/usr/bin/env bash

journalctl --lines 1000 --follow --no-hostname --output short-precise | grep -ivE 'rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo|Deactivated|X11|Assignment outside|gtk_widget_get_scale_factor|whoopsie|Advantage'
