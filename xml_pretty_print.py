#!/usr/bin/env python
# the basis for this came from
# https://stackoverflow.com/questions/3973819/python-pretty-xml-printer-for-xml-string

import sys
from lxml import etree

#slurp all of STDIN in one fell swoop! so I can pipe in output from other scripts/sources
xml_str = sys.stdin.read()

root = etree.fromstring(xml_str)
print( etree.tostring( root, pretty_print=True ).decode() )
