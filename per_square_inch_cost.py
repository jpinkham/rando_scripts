#!/usr/bin/env python3

import sys

PRICE = float(sys.argv[1])
WIDTH = float(sys.argv[2])
LENGTH = float(sys.argv[3])
AREA = WIDTH * LENGTH
PER_UNIT_COST = PRICE/AREA

print(f'{WIDTH}"w x {LENGTH}"h for ${PRICE} =  ${format(PER_UNIT_COST,".2f")} per sq inch')





