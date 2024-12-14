#! /usr/bin/env node

function iter(a) {
    let b = {};
    let add = (n, m) => b[n] = (b[n] || 0) + m;
    for (const [n, m] of Object.entries(a)) {
        if (n == 0) {
            add(1, m);
            continue;
        }
        let s = '' + n;
        let l = s.length;
        if ((l & 1) == 0) {
            l /= 2;
            add(+s.slice(0, l), m);
            add(+s.slice(-l), m);
        } else
            add(2024 * n, m);
    }
    return b;
}

const fs = require('fs');
const a = fs.readFileSync(0, 'utf-8').split(' ').map(e => +e);
let v = {};
a.forEach(n => v[n] = 1);
console.log(0, a.length, v);
for (let i = 1; i <= 75; ++i) {
    v = iter(v);
    console.log(i, Object.values(v).reduce((a, b) => a+b));
}
