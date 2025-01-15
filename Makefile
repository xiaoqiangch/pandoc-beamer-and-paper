# Makefile for generating presentation PDFs

# 工具路径
YQ := yq
PANDOC := pandoc

# 配置路径
DATA_DIR := pandoc
PDF_ENGINE := xelatex
SOURCE_FORMAT := markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs

# 模板路径
ARTICLE_TEMPLATE := $(DATA_DIR)/templates/article.latex
BEAMER_TEMPLATE := $(DATA_DIR)/templates/beamer.latex
ARTICLE_PREAMBLE := $(DATA_DIR)/templates/article-preamble.tex
BEAMER_PREAMBLE := $(DATA_DIR)/templates/beamer-preamble.tex
ARTICLE_FILTER := $(DATA_DIR)/article-filter.lua
BEAMER_FILTER := $(DATA_DIR)/beamer-filter.lua

# 获取当前日期
DATE_COVER := $(shell date "+%d %B %Y")

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

presentation_article.pdf: presentation_article.tex
	$(PANDOC) -s --dpi=300 --data-dir=$(DATA_DIR) --pdf-engine $(PDF_ENGINE) \
	$(if $(filter 1,$(USE_LUA_FILTER)),--lua-filter=$(ARTICLE_FILTER)) \
	-f $(SOURCE_FORMAT) -M date="$(DATE_COVER)" \
	$(if $(filter 1,$(USE_PREAMBLE)),-H $(ARTICLE_PREAMBLE)) \
	$(if $(filter 1,$(USE_TEMPLATE)),--template=$(ARTICLE_TEMPLATE)) \
	-V geometry="$(ARTICLE_GEOMETRY)" \
	-V fontsize="$(ARTICLE_FONTSIZE)" \
	-V linestretch="$(ARTICLE_LINESTRETCH)" \
	-V fontfamily="$(FONTFAMILY)" \
	-V beamer=0 \
	-t latex presentation.md -o $@

# 生成Beamer PDF
beamer: presentation_beamer.pdf

presentation_beamer.tex: presentation.md
	$(PANDOC) -s --dpi=300 --slide-level 3 --toc --listings --shift-heading-level=0 \
	--data-dir=$(DATA_DIR) \
	$(if $(filter 1,$(USE_TEMPLATE)),--template=$(BEAMER_TEMPLATE)) \
	$(if $(filter 1,$(USE_PREAMBLE)),-H $(BEAMER_PREAMBLE)) \
	-f $(SOURCE_FORMAT) -M date="$(DATE_COVER)" \
	$(if $(filter 1,$(USE_LUA_FILTER)),--lua-filter=$(BEAMER_FILTER)) \
	-V theme="$(BEAMER_THEME)" \
	-V colortheme="$(BEAMER_COLORTHEME)" \
	-V fonttheme="$(BEAMER_FONTTHEME)" \
	-V aspectratio="$(BEAMER_ASPECTRATIO)" \
	-V titlegraphic="$(BEAMER_TITLEGRAPHIC)" \
	-V logo="$(BEAMER_LOGO)" \
	-V section-titles="$(BEAMER_SECTION_TITLES)" \
	-V classoption:aspectratio=169 \
	-t beamer $< -o $@

presentation_beamer.pdf: presentation_beamer.tex
	$(PANDOC) -s --dpi=300 --slide-level 3 --toc --listings --shift-heading-level=0 \
	--data-dir=$(DATA_DIR) \
	$(if $(filter 1,$(USE_TEMPLATE)),--template=$(BEAMER_TEMPLATE)) \
	$(if $(filter 1,$(USE_PREAMBLE)),-H $(BEAMER_PREAMBLE)) \
	--pdf-engine $(PDF_ENGINE) -f $(SOURCE_FORMAT) -M date="$(DATE_COVER)" \
	$(if $(filter 1,$(USE_LUA_FILTER)),--lua-filter=$(BEAMER_FILTER)) \
	-V theme="$(BEAMER_THEME)" \
	-V colortheme="$(BEAMER_COLORTHEME)" \
	-V fonttheme="$(BEAMER_FONTTHEME)" \
	-V aspectratio="$(BEAMER_ASPECTRATIO)" \
	-V titlegraphic="$(BEAMER_TITLEGRAPHIC)" \
	-V logo="$(BEAMER_LOGO)" \
	-V section-titles="$(BEAMER_SECTION_TITLES)" \
	-V classoption:aspectratio=169 \
	-t beamer presentation.md -o $@

# 组合目标
all: article beamer

# 选项控制
no-lua:
	$(MAKE) USE_LUA_FILTER=0 all

no-preamble:
	$(MAKE) USE_PREAMBLE=0 all

no-template:
	$(MAKE) USE_TEMPLATE=0 all

# 清理
clean:
	rm -f presentation_article.* presentation_beamer.*

.PHONY: article beamer all no-lua no-preamble no-template clean
