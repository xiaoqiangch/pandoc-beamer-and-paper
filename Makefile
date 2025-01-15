# Makefile for generating presentation PDFs
# 作者：chenxiaoqiang
# 版本：1.0
# 最后更新：2023-10-01

# ====================
# 1. 基本配置
# ====================

# 作者：chenxiaoqiang
# 版本：2.0
# 最后更新：2023-10-01

# 工具路径
YQ := yq
PANDOC := pandoc
LATEXMK := latexmk

# 平台检测
UNAME := $(shell uname)

# Draw.io 路径配置
ifeq ($(UNAME), Darwin)
DRAWIO := /Applications/draw.io.app/Contents/MacOS/draw.io
else ifeq ($(UNAME), Linux)
DRAWIO := drawio
else ifeq ($(UNAME), Windows_NT)
DRAWIO := "C:\Program Files\draw.io\draw.io.exe"
endif

# 输入输出配置
INPUT_MD ?= presentation.md
BUILD_DIR := build
LOG_DIR := log
FIGURE_DIR := figure
TEMP_FILE := preprocessed_markdown.md
YAML_FILE := document_metadata.yaml

# 文档输出
ARTICLE_OUTPUT := $(BUILD_DIR)/presentation_article.pdf
BEAMER_OUTPUT := $(BUILD_DIR)/presentation_beamer.pdf
LATEX_OUTPUT := $(BUILD_DIR)/thesis.tex
DOCX_OUTPUT := $(BUILD_DIR)/thesis.docx

# Pandoc配置
PDF_ENGINE := xelatex
SOURCE_FORMAT := markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs

# 模板路径
TEMPLATE_DIR := templates
ARTICLE_TEMPLATE := $(TEMPLATE_DIR)/article.tex
BEAMER_TEMPLATE := $(TEMPLATE_DIR)/beamer.tex
ARTICLE_PREAMBLE := $(TEMPLATE_DIR)/article-preamble.tex
BEAMER_PREAMBLE := $(TEMPLATE_DIR)/beamer-preamble.tex
LATEX_TEMPLATE := $(TEMPLATE_DIR)/njuthesis.tex
LATEX_HEADER := $(TEMPLATE_DIR)/xqHeader.tex
YAML_TEMPLATE := $(TEMPLATE_DIR)/extract_yaml.txt
WORD_REF := $(TEMPLATE_DIR)/exportreference.docx

# 过滤器路径
ARTICLE_FILTER := filters/article-filter.lua
BEAMER_FILTER := filters/beamer-filter.lua
ZOTERO_LUA := filters/zotero.lua

# 参考文献配置
ZOTERO_BIB_FILE := references.bib
ZOTERO_HOST := 127.0.0.1
ZOTERO_PORT := 23119

# 其他配置
FORCE_REBUILD := false
TIMESTAMP := $(shell date +%Y%m%d%H%M%S)
LOG_FILE := $(LOG_DIR)/conversion_$(TIMESTAMP).log

# ====================
# 2. 初始化
# ====================

init:
	@echo "初始化构建目录结构..." | tee -a $(LOG_FILE)
	@mkdir -p $(BUILD_DIR) $(LOG_DIR) $(FIGURE_DIR)

# ====================
# 3. 预处理
# ====================

preprocess: init
	@echo "预处理Markdown文件..." | tee -a $(LOG_FILE)
	@if [ -z "$(INPUT_MD)" ]; then \
		echo "错误：未设置INPUT_MD"; \
		exit 1; \
	fi
	@cp "$(INPUT_MD)" $(TEMP_FILE)
ifeq ($(UNAME), Darwin)
	@sed -i '' -E 's/!\[\[([^]]+)\]\]/![](\1)/g' $(TEMP_FILE)
	@sed -i '' -E 's/!\[\]\(([^)]*\.svg)\)/![](\1)/g' $(TEMP_FILE)
	@sed -i '' -E 's/%20/ /g' $(TEMP_FILE)
else
	@sed -i -E 's/!\[\[([^]]+)\]\]/![](\1)/g' $(TEMP_FILE)
	@sed -i -E 's/!\[\]\(([^)]*\.svg)\)/![](\1)/g' $(TEMP_FILE)
	@sed -i -E 's/%20/ /g' $(TEMP_FILE)
endif

# ====================
# 4. 图片处理
# ====================

copy_images: preprocess
	@echo "复制图片到figure目录..." | tee -a $(LOG_FILE)
	@INPUT_ABS_PATH=$$(realpath "$(INPUT_MD)"); \
	INPUT_DIR="$$(dirname "$$INPUT_ABS_PATH")"; \
	ATTACHMENTS_DIR=$$(echo "$$INPUT_DIR" | sed 's|Obsidian_Brain/|Obsidian_Brain/attachments/|'); \
	@grep -o '!\[\]([^)]*)' $(TEMP_FILE) | \
	sed -E 's/!\[\]\(([^)]+)\)/\1/' | \
	while read -r IMG; do \
		IMG_PATH="$$ATTACHMENTS_DIR/$$IMG"; \
		IMG_BASENAME="$$(basename "$$IMG_PATH")"; \
		TARGET_PATH="$(FIGURE_DIR)/$$IMG_BASENAME"; \
		if [ -f "$$IMG_PATH" ]; then \
			if [ "$(FORCE_REBUILD)" = "true" ] || [ ! -f "$$TARGET_PATH" ]; then \
				cp "$$IMG_PATH" "$$TARGET_PATH"; \
			fi; \
		fi; \
	done

convert_svg: copy_images
	@echo "转换SVG图片为PNG..." | tee -a $(LOG_FILE)
	@for SVG_FILE in $(FIGURE_DIR)/*.svg; do \
		if [ -f "$$SVG_FILE" ]; then \
			PNG_FILE="$${SVG_FILE%.svg}.png"; \
			if [ "$(FORCE_REBUILD)" = "true" ] || [ ! -f "$$PNG_FILE" ]; then \
				"$(DRAWIO)" -x -f png -o "$$PNG_FILE" "$$SVG_FILE"; \
			fi; \
			sed -i '' -E "s|!\[\]\(([^)]*)$$(basename "$$SVG_FILE")\)|![](\1$$(basename "$$PNG_FILE"))|g" $(TEMP_FILE); \
		fi; \
	done

# ====================
# 5. 文档生成
# ====================

# 生成文章格式PDF
$(ARTICLE_OUTPUT): preprocess convert_svg
	$(PANDOC) $(TEMP_FILE) -o $@ \
		--template=$(ARTICLE_TEMPLATE) \
		--pdf-engine=$(PDF_ENGINE) \
		-f $(SOURCE_FORMAT) \
		--filter=$(ARTICLE_FILTER) \
		--include-in-header=$(ARTICLE_PREAMBLE)

# 生成Beamer格式PDF
$(BEAMER_OUTPUT): preprocess convert_svg
	$(PANDOC) $(TEMP_FILE) -o $@ \
		--template=$(BEAMER_TEMPLATE) \
		--pdf-engine=$(PDF_ENGINE) \
		-f $(SOURCE_FORMAT) \
		--filter=$(BEAMER_FILTER) \
		--include-in-header=$(BEAMER_PREAMBLE) \
		-t beamer

# 生成LaTeX文件
$(LATEX_OUTPUT): preprocess convert_svg
	$(PANDOC) $(TEMP_FILE) -o $@ \
		--template=$(LATEX_TEMPLATE) \
		--bibliography=$(ZOTERO_BIB_FILE) \
		--filter pandoc-crossref \
		--biblatex \
		--include-in-header=$(LATEX_HEADER)

# 生成Word文档
$(DOCX_OUTPUT): preprocess convert_svg
	$(PANDOC) $(TEMP_FILE) -o $@ \
		--bibliography=$(ZOTERO_BIB_FILE) \
		--citeproc \
		--filter pandoc-crossref \
		--lua-filter=$(ZOTERO_LUA) \
		--reference-doc=$(WORD_REF)

# ====================
# 6. 组合目标
# ====================

all: $(ARTICLE_OUTPUT) $(BEAMER_OUTPUT) $(LATEX_OUTPUT) $(DOCX_OUTPUT)

# ====================
# 7. 清理
# ====================

clean:
	@echo "清理生成的文件..." | tee -a $(LOG_FILE)
	@rm -rf $(BUILD_DIR) $(LOG_DIR) $(FIGURE_DIR) $(TEMP_FILE) $(YAML_FILE)

.PHONY: all clean init preprocess copy_images convert_svg
