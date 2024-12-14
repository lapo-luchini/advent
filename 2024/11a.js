#! /usr/bin/env node

function iter(a) {
    let b = [];
    for (let e of a) {
        if (e === 0) {
            b.push(1);
            continue;
        }
        let s = '' + e;
        let l = s.length;
        if ((l & 1) == 0) {
            l /= 2;
            b.push(+s.slice(0, l));
            b.push(+s.slice(-l));
        } else
            b.push(2024 * s);
    }
    return b;
}

const fs = require('fs');
let a = fs.readFileSync(0, 'utf-8').split(' ').map(e => +e);
console.log(0, a);
for (let i = 1; i <= 25; ++i) {
    a = iter(a);
    console.log(i, a.length, a);
}
