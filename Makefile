# Makefile for pandoc-beamer presentation

# Variables
DATE_COVER=$(shell date "+%d %B %Y")
SOURCE_FORMAT=markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs
DATA_DIR=pandoc
PDF_ENGINE=xelatex
INPUT=presentation.md
OUTPUT=presentation.pdf
OUTPUT_NICE=presentation_nice_formatting.pdf
ARTICLE_OUTPUT=article.pdf

# Default target
all: $(OUTPUT) $(OUTPUT_NICE) $(ARTICLE_OUTPUT)

# Standard PDF generation
$(OUTPUT): $(INPUT)
	pandoc -s --dpi=300 --slide-level 2 --toc --listings --shift-heading-level=0 \
	--data-dir=$(DATA_DIR) --template default_mod.latex \
	--pdf-engine $(PDF_ENGINE) -f "$(SOURCE_FORMAT)" -M date="$(DATE_COVER)" \
	-V classoption:aspectratio=169 -t beamer $< -o $@

# PDF with preamble
$(OUTPUT_NICE): $(INPUT)
	pandoc -s --dpi=300 --slide-level 2 --toc --listings --shift-heading-level=0 \
	--data-dir=$(DATA_DIR) --template default_mod.latex -H pandoc/templates/preamble.tex \
	--pdf-engine $(PDF_ENGINE) -f "$(SOURCE_FORMAT)" -M date="$(DATE_COVER)" \
	-V classoption:aspectratio=169 -t beamer $< -o $@

# Article PDF generation
$(ARTICLE_OUTPUT): $(INPUT)
	pandoc -s --dpi=300 --toc --listings --shift-heading-level=0 \
	--data-dir=$(DATA_DIR) --template default_mod.latex \
	--lua-filter=pandoc/filters/beamer_filter.lua \
	--pdf-engine $(PDF_ENGINE) -f "$(SOURCE_FORMAT)" -M date="$(DATE_COVER)" \
	-t latex $< -o $@

# Watch mode using inotifywait
watch:
	@echo "Watching for changes in markdown files..."
	@while true; do \
		inotifywait -q -e modify $(INPUT); \
		make; \
	done

# Clean up generated files
clean:
	rm -f $(OUTPUT) $(OUTPUT_NICE) $(ARTICLE_OUTPUT)

.PHONY: all watch clean
