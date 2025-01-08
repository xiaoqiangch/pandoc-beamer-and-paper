#!/bin/bash

# Parse command line arguments
output_pdf=false
output_beamer=false

DATA_DIR="pandoc"
PDF_ENGINE="xelatex"
TEMPLATE="pandoc/templates/default.latex"
PREAMBLE="pandoc/templates/preamble.tex"
LUA_FILTER="pandoc/beamer-filter.lua"

while getopts ":pba" opt; do
  case $opt in
    p) output_pdf=true ;;
    b) output_beamer=true ;;
    a) output_pdf=true; output_beamer=true ;;
    *) echo "Usage: $0 [-p] [-b] [-a]"
       echo "  -p  Generate PDF output"
       echo "  -b  Generate Beamer output" 
       echo "  -a  Generate both PDF and Beamer outputs"
       exit 1 ;;
  esac
done

# Use Python's yaml module to parse the YAML front matter
python3 - <<'EOF'
import yaml
import re

with open('presentation.md', 'r', encoding='utf-8') as f:
    content = f.read()
    
# Extract YAML front matter
yaml_block = re.search(r'^---\n(.*?)\n---', content, re.DOTALL)
if yaml_block:
    yaml_content = yaml_block.group(1)
    metadata = yaml.safe_load(yaml_content)
    
    # Print variables for bash
    for key, value in metadata.get('beamer', {}).items():
        print(f"{key.upper()}=\"{value}\"")
EOF

# Generate article LaTeX output if requested
if $output_pdf; then
  pandoc -s --toc --listings \
    -f markdown -t latex \
    --pdf-engine=xelatex --lua-filter="${LUA_FILTER}" \
    -V mainfont:"STSong" \
    -V geometry:"a4paper" \
    -V documentclass:"article" \
    presentation.md -o presentation_article.pdf
    
  echo "Article PDF file generated: presentation_article.pdf"
fi

# Generate Beamer output if requested
if $output_beamer; then
  pandoc -s --dpi=300 --slide-level 3 --toc --listings --shift-heading-level=0 \
  --data-dir="${DATA_DIR}"\
  --template "${TEMPLATE}" -H "${PREAMBLE}"\
    -f markdown -t beamer \
    --pdf-engine=xelatex --lua-filter="${LUA_FILTER}" \
    -V mainfont:"STSong" \
    -V theme:"$THEME" \
    -V colortheme:"$COLORTHEME" \
    -V fonttheme:"$FONTTHEME" \
    -V aspectratio:"$ASPECTRATIO" \
    -V titlegraphic:"$TITLEGRAPHIC" \
    -V logo:"$LOGO" \
    -V classoption:aspectratio=169 \
    presentation.md -o presentation_beamer.pdf

  echo "Beamer PDF file generated: presentation_beamer.pdf"
fi
