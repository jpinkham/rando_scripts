#!/bin/bash
cat /etc/pihole/dhcp.leases | cut -d " " -f 3,4 | sort
