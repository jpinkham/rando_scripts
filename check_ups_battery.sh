#!/bin/bash

echo "Battery Charge:"
sudo apcaccess -p BCHARGE

echo "Battery time left:"
sudo apcaccess -p TIMELEFT

echo "Current load on battery:"
sudo apcaccess -p LOADPCT
