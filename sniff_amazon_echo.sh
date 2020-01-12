#!/bin/bash

tshark -i $1 -w ~/Documents/PCAPs/amazon_echo_devices.`date +%Y%m%d.%H.%M`.pcap -f "not dst net 169.254.0.0/16 and not multicast and not broadcast and not arp and ( host 192.168.1.130 or host 192.168.1.170 or host 192.168.1.231)"  -a duration:$2

