#!/bin/bash

tshark -i $1 -w ~/Documents/PCAPs/IoTDevices-nonintranettraffic.`date +%Y%m%d.%H.%M`.pcap -f "not dst net 169.254.0.0/16 and not multicast and not broadcast and not arp and ( host 192.168.1.49 or host 192.168.1.92 or host 192.168.1.109 or host 192.168.1.130 or host 192.168.1.169 or host 192.168.1.170 or host 192.168.1.180 or host 192.168.1.231 or host 192.168.1.241) and not (src net 192.168.1.0/24 and dst net 192.168.1.0/24)"  -a duration:$2

