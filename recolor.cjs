const fs = require('fs');
const filePath = 'public/admin-dashboard.html';

let text = fs.readFileSync(filePath, 'utf-8');

// Use regex replacements to handle newlines
const replacements = [
    { regex: /body\s*\{\s*background:\s*#ffffff;\s*color:\s*#fff;\s*\}/g, newStr: 'body {\n            background: #0b0f14;\n            color: #fff;\n        }' },
    { regex: /background:\s*#0e131a;/g, newStr: 'background: linear-gradient(180deg, #C52E7F 0%, #00032D 30%, #00032D 100%);' },
    { regex: /background:\s*#00c896;/g, newStr: 'background: #c0175d;' },
    { regex: /background:\s*#14b8a6;/g, newStr: 'background: #c0175d;' },
    { regex: /\.menu\s*a:hover\s*\{\s*background:\s*#c0175d;\s*color:\s*black;\s*\}/g, newStr: '.menu a:hover {\n            background: #c0175d;\n            color: white;\n        }' },
    { regex: /\.action:hover\s*\{\s*background:\s*#c0175d;\s*color:\s*black;\s*\}/g, newStr: '.action:hover {\n            background: #c0175d;\n            color: white;\n        }' },
    { regex: /radial-gradient\(circle\s+at\s+top,\s*#064e3b,\s*#022c22\)/g, newStr: 'radial-gradient(circle at top, #700f37, #3e081e)' },
    { regex: /color:\s*#2dd4bf;/g, newStr: 'color: #ffb8d2;' },
    { regex: /border-color:\s*#00c7a5;/g, newStr: 'border-color: #c0175d;' },
    { regex: /rgba\(0,\s*199,\s*165,\s*0\.3\)/g, newStr: 'rgba(192, 23, 93, 0.3)' },
    { regex: /background:\s*#00d2ae;/g, newStr: 'background: #c0175d;' },
    { regex: /background:\s*#00e8bd;/g, newStr: 'background: #a01250;' },
    { regex: /rgba\(20,\s*184,\s*166,\s*0\.18\)/g, newStr: 'rgba(192, 23, 93, 0.18)' },
    { regex: /rgba\(20,\s*184,\s*166,\s*0\.22\)/g, newStr: 'rgba(192, 23, 93, 0.22)' },
    { regex: /rgba\(20,\s*184,\s*166,\s*0\.65\)/g, newStr: 'rgba(192, 23, 93, 0.65)' },
    { regex: /rgba\(20,\s*184,\s*166,\s*0\.14\)/g, newStr: 'rgba(192, 23, 93, 0.14)' },
    { regex: /background:\s*#bf9bc0;/g, newStr: 'background: #111827;' },
    { regex: /background:\s*#ffffff;\s*border:\s*1px\s+solid\s+#1f2937;/g, newStr: 'background: #111827;\n            border: 1px solid #1f2937;' },
    { regex: /\.profile-add-btn\s*\{\s*background:\s*#c0175d;\s*color:\s*#000;\s*border:\s*none;/g, newStr: '.profile-add-btn {\n            background: #c0175d;\n            color: #fff;\n            border: none;' },
    { regex: /\.add-btn\s*\{\s*border:\s*none;\s*background:\s*#c0175d;\s*color:\s*#041b17;/g, newStr: '.add-btn {\n            border: none;\n            background: #c0175d;\n            color: #fff;' },
    { regex: /\.save-btn\s*\{\s*flex:\s*1;\s*background:\s*#c0175d;\s*border:\s*none;\s*color:\s*#000;/g, newStr: '.save-btn {\n            flex: 1;\n            background: #c0175d;\n            border: none;\n            color: #fff;' },
    { regex: /background:\s*#111827;\s*border:\s*1px\s+solid\s+#1f2937;/g, newStr: 'background: #111827;\n            border: 1px solid #1f2937;' } // safety
];

for (const r of replacements) {
    if (text.match(r.regex)) {
        text = text.replace(r.regex, r.newStr);
    }
}

fs.writeFileSync(filePath, text);
console.log('Success');
