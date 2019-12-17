#!/bin/bash


tshark -i eno1 -f "not dst net 169.254.0.0/16 and not multicast and not broadcast and not arp"  -a duration:$1
