#!/usr/bin/python3

import sys

PROMPT_TEXT = sys.argv[1]
URL = sys.argv[2]

print("Building JS for prompt >$PROMPT_TEXT< and dest URL >$URL<")

print("javascript:var search_term=prompt('$PROMPT_TEXT ?'); window.location.href='$URL%22' + search_term + '%22';")
