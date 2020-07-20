#!/bin/bash

# Copy downloaded ebooks to Calibre server auto-add directory
scp "$1" pi@192.168.11.40:/tmp/ebooks/.
