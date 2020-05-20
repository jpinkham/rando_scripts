#!/bin/sh
digitemp_DS9097U -s /dev/ttyUSB0 -n 1 -q -t 0 | cut -d ' ' -f 9
