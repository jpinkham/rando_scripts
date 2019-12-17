#!/bin/bash

tshark -w dns_requests.`date +%Y%m%d.%H.%M`.pcap -f "port 53" -a duration:$1
