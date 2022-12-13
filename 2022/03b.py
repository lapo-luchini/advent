import sys
def myord(k):
    if (k >= 'a' and k <= 'z'):
        return ord(k) - ord('a') + 1
    if (k >= 'A' and k <= 'Z'):
        return ord(k) - ord('A') + 27
    raise Exception('Invalid letter: ' + k)
def common(s1, s2):
    c = ''
    for k1 in s1:
        for k2 in s2:
            if (k1 == k2):
                c += k1
    return c
i = 0
c = ''
t = 0
for r in map(str.rstrip, sys.stdin):
    if (i == 0):
        c = r
    else:
        c = common(c, r)
    if (i == 2):
        o = myord(c[0])
        t += o
        print(c, o)
        i = 0
    else:
        i = i + 1
print(t)
