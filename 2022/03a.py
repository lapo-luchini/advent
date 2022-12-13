import sys
def myord(k):
    if (k >= 'a' and k <= 'z'):
        return ord(k) - ord('a') + 1
    if (k >= 'A' and k <= 'Z'):
        return ord(k) - ord('A') + 27
    raise Exception('Invalid letter: ' + k)
t = 0
for r in map(str.rstrip, sys.stdin):
    l = len(r)//2
    s1 = r[:l]
    s2 = r[l:]
    c = ''
    for k1 in s1:
        for k2 in s2:
            if (k1 == k2):
                c = k1
    o = myord(c)
    t += o
    print(c, o)
print(t)
