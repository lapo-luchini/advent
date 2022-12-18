#! /usr/bin/env node

const fs = require('fs');

let s = fs.readFileSync(process.argv[2], 'utf-8');
s = s.replace(/="[0-9]{2}_files\//g, '="www/');
s = s.replace(/<style>\s+\.flipX([^<]|<[^s])+<\/style>/, '');
s = s.replace(/<style>\s+@keyframes blinkWarning([^<]|<[^s])+<\/style>/, '');
s = s.replace(/<script async="" src="www\/google-analytics_analytics.js">.+/, '');
s = s.replace(/<!-- ga -->([^<]|<[^!])+<!-- \/ga -->/, '');
s = s.replace(/<!--(?:[^-]+|-[^-])+-->/g, '');
fs.renameSync(process.argv[2], process.argv[2].replace(/\.html$/, '') + '-orig.html');
fs.writeFileSync(process.argv[2], s, 'utf-8');
