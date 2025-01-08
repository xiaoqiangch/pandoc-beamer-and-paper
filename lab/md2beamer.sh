#!/bin/bash

# 检查输入文件是否存在
if [ ! -f "$1" ]; then
  echo "Usage: $0 input.md"
  exit 1
fi

# 获取输入文件名（不含扩展名）
filename=$(basename "$1" .md)

# 使用pandoc进行转换
# 生成PDF
pandoc "$1" -t beamer \
  --pdf-engine=xelatex \
  -V theme:Warsaw \
  -V colortheme:seahorse \
  -V mainfont="STSong" \
  -V CJKmainfont="STSong" \
  -o "${filename}.pdf"

# 生成TEX
pandoc "$1" -t latex \
  -o "${filename}.tex"

# 生成PDF
pandoc "$1" -t beamer \
  --pdf-engine=xelatex \
  -V theme:Warsaw \
  -V colortheme:seahorse \
  -V mainfont="STSong" \
  -V CJKmainfont="STSong" \
  -o "${filename}.pdf"

echo "Generated ${filename}.pdf"
