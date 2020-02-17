#!/bin/bash

tshark -i $1 -w ~/Documents/PCAPs/dns_requests.`date +%Y%m%d.%H.%M`.pcap -f "port 53" -a duration:$2
