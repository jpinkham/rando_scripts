#!/bin/bash

tshark -i eno1 -w ~/Documents/PCAPs/IoTDevices.`date +%Y%m%d.%H.%M`.pcap -f "not dst net 169.254.0.0/16 and not multicast and not broadcast and not arp and ( host 192.168.1.49 or host 192.168.1.92 or host 192.168.1.109 or host 192.168.1.130 or host 192.168.1.169 or host 192.168.1.170 or host 192.168.1.180 or host 192.168.1.231 or host 192.168.1.241) and not (src net 192.168.1.0/24 and dst net 192.168.1.0/24)"  -a duration:$1



#tshark -i eno1 -w IoTDevices.`date +%Y%m%d.%H.%M`.pcap -f "not dst net 169.254.0.0/16 and not multicast and not broadcast and not arp and (host 192.168.1.109 or host 192.168.1.39 or host 192.168.1.92 or host 192.168.1.49 or host 192.168.1.161 or host 192.168.1.169 or host 192.168.1.3 or host 192.168.1.80 or host 192.168.1.241 or host 192.168.1.161 or host 192.168.1.170 or host 192.168.1.159 or host 192.168.1.180)"  -a duration:$1
