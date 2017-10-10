#!/usr/bin/python                                                                                                             

import sys
from itertools import *

RED = 31
GREEN = 32

RESET_SEQ = "\033[0m"
COLOR_SEQ = "\033[0;%dm"

stack = []

def inverse(line):
    return ('-' if line[0] == '+' else '+') + line[1:].strip()

def reverse_enumerate(l):
    for i, x in enumerate(reversed(l)):
        yield len(l)-1-i, x

def dumpchanges():
    for line in stack:
        SEQ = COLOR_SEQ % (GREEN if line.startswith('+') else RED)
        print SEQ + line.strip() + RESET_SEQ
    stack[:] = []

for line in sys.stdin.readlines():
    if not line[1:].strip():
        continue # ignore empty lines                                                                                         
    if line.startswith(('---', '+++')):
        dumpchanges()
        print line.strip()
    elif line.startswith(('+', '-')):
        inverted = inverse(line)
        line = line[0] + line[1:].strip()
        for i, match in reverse_enumerate(stack):
            if inverted == match:
                stack.pop(i)
                break
        else:
            stack.append(line)

# finished reading, still have state to be dumped                                                                             
dumpchanges()
