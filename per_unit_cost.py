#!/usr/bin/env python3

import sys

PRICE = float(sys.argv[1])
NUM_UNITS = int(sys.argv[2])
PER_UNIT_COST = PRICE/NUM_UNITS

print(f'${PRICE} / {NUM_UNITS} = ${format(PER_UNIT_COST,".2f")} per unit')





