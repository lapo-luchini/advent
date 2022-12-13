#! /usr/bin/env node

const readline = require('readline');
let points = 0;

readline.createInterface({
    input:  process.stdin
}).on('line', function (s) {
    const m1 = s.charCodeAt(0) - 'A'.charCodeAt(0);
    const m2 = s.charCodeAt(2) - 'X'.charCodeAt(0);
    const mv = ((m1 + m2 - 1) % 3 + 3) % 3;
    const win = mv + 1 + m2 * 3;
    points += win;
    console.log(s + ' ' + mv + ' ' + win);
}).on('close', function () {
    console.log('Points:', points);
});
