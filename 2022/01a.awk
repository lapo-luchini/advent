BEGIN {
    cur = 0
    max = -1
}
/[0-9]+/ {
    cur += $0
}
/^$/ {
    if (cur > max)
        max = cur
    cur = 0
}
END {
    print max
}
