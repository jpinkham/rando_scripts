#!/bin/bash
sudo tail --follow=name --retry -n 1000 /var/log/pihole.log|grep -i dhcp

