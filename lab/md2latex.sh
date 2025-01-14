#!/bin/bash

# Extract YAML metadata using yq
THEME=$(yq '.beamer.theme' presentation.md)
COLORTHEME=$(yq '.beamer.colortheme' presentation.md)
FONTTHEME=$(yq '.beamer.fonttheme' presentation.md)
ASPECTRATIO=$(yq '.beamer.aspectratio' presentation.md)
TITLEGRAPHIC=$(yq '.beamer.titlegraphic' presentation.md)
LOGO=$(yq '.beamer.logo' presentation.md)

# Convert to LaTeX with beamer settings
pandoc -s --slide-level 2 --toc --listings --shift-heading-level=0 \
    -f markdown -t beamer \
    -V theme:"$THEME" \
    -V colortheme:"$COLORTHEME" \
    -V fonttheme:"$FONTTHEME" \
    -V aspectratio:"$ASPECTRATIO" \
    -V titlegraphic:"$TITLEGRAPHIC" \
    -V logo:"$LOGO" \
    -V classoption:aspectratio=169 \
    presentation.md -o presentation.tex

echo "LaTeX file generated: presentation.tex"
