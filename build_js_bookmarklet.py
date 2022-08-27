#!/usr/bin/python3

import sys

def usage():
    print(f"\nUsage: {sys.argv[0]} [<prompt text>] [<URL with search param last>]\n")

# first argument is the script name itself, hence checking for arguments
if len(sys.argv) < 3:
    usage()
    exit()

PROMPT_TEXT = sys.argv[1]
URL = sys.argv[2]

print(f"Building JS for prompt >{PROMPT_TEXT}< and dest URL >{URL}<\n")

print(f"javascript:var search_term=prompt('{PROMPT_TEXT} ?'); window.location.href='{URL}' + search_term ;")
