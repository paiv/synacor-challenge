#!/usr/bin/env python
from itertools import permutations

def monument(a,b,c,d,e):
  return a + b * c**2 + d**3 - e == 399

# 2 red
# 3 corroded
# 5 shiny
# 7 concave
# 9 blue

ans = [x for x in permutations([2,3,5,7,9]) if monument(*x)]
print(ans)
