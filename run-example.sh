#!/bin/bash

# 将 markdown 转换为带 Lua filter 的 HTML
pandoc example.md \
    --lua-filter=example-filter.lua \
    -o example.tex

# 将 markdown 转换为带 Lua filter 的 PDF
pandoc example.md \
    --lua-filter=example-filter.lua \
    --pdf-engine=xelatex \
    -V mainfont="STSong" \
    -V CJKmainfont="STSong" \
    -o example.pdf

echo "转换完成，生成文件："
echo "- example.tex"
echo "- example.pdf"
