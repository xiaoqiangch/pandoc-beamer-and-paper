#!/bin/bash

DATE_COVER=$(date "+%d %B %Y")

SOURCE_FORMAT="markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs"

DATA_DIR="pandoc"
PDF_ENGINE="xelatex"

case "$1" in
    "-preamble")
        pandoc -s --dpi=300 --slide-level 2 --toc --listings --shift-heading-level=0 --data-dir="${DATA_DIR}" --template default_mod.latex -H pandoc/templates/preamble.tex --pdf-engine "${PDF_ENGINE}" -f "$SOURCE_FORMAT" -M date="$DATE_COVER" -V classoption:aspectratio=169 -t beamer --lua-filter=beamer_filter.lua presentation.md -o presentation_nice_formatting.pdf
        ;;
    "-tex")
        pandoc -s --dpi=300 --slide-level 2 --toc --listings --shift-heading-level=0 --data-dir="${DATA_DIR}" --template default_mod.latex -H pandoc/templates/preamble.tex --pdf-engine "${PDF_ENGINE}" -f "$SOURCE_FORMAT" -M date="$DATE_COVER" -V classoption:aspectratio=169 -t beamer --lua-filter=beamer_filter.lua presentation.md -o presentation.tex
        ;;
    *)
        pandoc -s --dpi=300 --slide-level 2 --toc --listings --shift-heading-level=0 --data-dir="${DATA_DIR}" --template default_mod.latex --pdf-engine "${PDF_ENGINE}" -f "$SOURCE_FORMAT" -M date="$DATE_COVER" -V classoption:aspectratio=169 -t beamer --lua-filter=beamer_filter.lua presentation.md -o presentation.pdf
        ;;
esac
