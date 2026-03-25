import sys

file_path = r'c:\Users\user\Desktop\ereport1\e-report\public\admin-dashboard.html'

with open(file_path, 'r', encoding='utf-8') as f:
    text = f.read()

# perform replacements for branding
replacements = [
    ('background: #0e131a;', 'background: linear-gradient(180deg, #C52E7F 0%, #00032D 30%, #00032D 100%);'),
    ('background: #00c896;', 'background: #c0175d;'),
    ('background: #14b8a6;', 'background: #c0175d;'),
    ('color: #000;', 'color: #fff;'),
    ('radial-gradient(circle at top, #064e3b, #022c22)', 'radial-gradient(circle at top, #700f37, #3e081e)'),
    ('color: #2dd4bf;', 'color: #ffb8d2;'),
    ('border-color: #00c7a5;', 'border-color: #c0175d;'),
    ('rgba(0, 199, 165, 0.3)', 'rgba(192, 23, 93, 0.3)'),
    ('background: #00d2ae;', 'background: #c0175d;'),
    ('background: #00e8bd;', 'background: #a01250;'),
    ('rgba(20, 184, 166, 0.18)', 'rgba(192, 23, 93, 0.18)'),
    ('rgba(20, 184, 166, 0.22)', 'rgba(192, 23, 93, 0.22)'),
    ('rgba(20, 184, 166, 0.65)', 'rgba(192, 23, 93, 0.65)'),
    ('rgba(20, 184, 166, 0.14)', 'rgba(192, 23, 93, 0.14)'),
    ('color: #041b17;', 'color: #fff;'),
    ("background: #ffffff;\n            color: #fff;", "background: #0b0f14;\n            color: #fff;"),
    ("background: #ffffff;\n            border: 1px solid #1f2937;", "background: #111827;\n            border: 1px solid #1f2937;"),
    ("background: #bf9bc0;", "background: #111827;")
]

for old, new in replacements:
    text = text.replace(old, new)


with open(file_path, 'w', encoding='utf-8') as f:
    f.write(text)

print('Done.')
