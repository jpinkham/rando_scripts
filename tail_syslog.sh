#!/usr/bin/env bash

journalctl --lines 500 --follow --no-hostname --output short-precise | grep -ivE 'rngd|cron|php|locale|accordingly|reloading.|apt-daily|daily apt|cleanup|calibre|slice|session|succeeded|tracker|sudo|Deactivated|X11'
