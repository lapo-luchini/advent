BEGIN {
    cur = 0
    max[0] = -1
    max[1] = -1
    max[2] = -1
}
/[0-9]+/ {
    cur += $0
}
/^$/ {
    if (cur > max[2]) {
        if (cur > max[0]) {
            max[2] = max[1]
            max[1] = max[0]
            max[0] = cur
        } else if (cur > max[1]) {
            max[2] = max[1]
            max[1] = cur
        } else
            max[2] = cur
        print max[0] ", " max[1] ", " max[2]
    }
    cur = 0
}
END {
    print max[0] + max[1] + max[2]
}
