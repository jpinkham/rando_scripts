#!/bin/bash

tshark -i $1 -w ~/Documents/PCAPs/http_requests.`date +%Y%m%d.%H.%M`.pcap -f "port 80" -a duration:$2
