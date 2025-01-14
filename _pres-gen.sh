#!/bin/bash

# 是否使用lua-filter (1:启用, 0:禁用)
USE_LUA_FILTER=0

# 是否使用preamble (1:启用, 0:禁用) 
USE_PREAMBLE=0

# 是否使用模板 (1:启用, 0:禁用)
USE_TEMPLATE=1

# 定义模板路径
ARTICLE_TEMPLATE="pandoc/templates/article.latex"
BEAMER_TEMPLATE="pandoc/templates/beamer.latex"

# 获取当前日期
DATE_COVER=$(date "+%d %B %Y")

SOURCE_FORMAT="markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs"

# 定义常量路径和选项
DATA_DIR="pandoc"
PDF_ENGINE="xelatex"
TEMPLATE="pandoc/templates/default_mod.latex"
ARTICLE_PREAMBLE="pandoc/templates/article-preamble.tex"
BEAMER_PREAMBLE="pandoc/templates/beamer-preamble.tex"
BEAMER_FILTER="pandoc/beamer-filter.lua"
ARTICLE_FILTER="pandoc/article-filter.lua"

# 从配置文件中读取选项

# 通用配置

TITLE=$(yq '.title' presentation.md)
AUTHOR=$(yq '.author' presentation.md)
INSTITUTE=$(yq '.institute' presentation.md)
TOPIC=$(yq '.topic' presentation.md)
MAINFONT=$(yq '.mainfont' presentation.md)
CJKMAINFONT=$(yq '.CJKmainfont' presentation.md)
FONTFAMILY=$(yq '.fontfamily' presentation.md)
FONTFAMILYOPTIONS=$(yq '.fontfamilyoptions' presentation.md)

# 文章专有配置

ARTICLE_GEOMETRY=$(yq '.article.geometry' presentation.md)
ARTICLE_FONTSIZE=$(yq '.article.fontsize' presentation.md)
ARTICLE_LINESTRETCH=$(yq '.article.linestretch' presentation.md)
ARTICLE_TOC=$(yq '.article.toc' presentation.md)
ARTICLE_NUMBERSECTIONS=$(yq '.article.numbersections' presentation.md)

# Beamer专有配置

BEAMER_THEME=$(yq '.beamer.theme' presentation.md)
BEAMER_COLORTHEME=$(yq '.beamer.colortheme' presentation.md) 
BEAMER_FONTTHEME=$(yq '.beamer.fonttheme' presentation.md)
BEAMER_ASPECTRATIO=$(yq '.beamer.aspectratio' presentation.md)
BEAMER_TITLEGRAPHIC=$(yq '.beamer.titlegraphic' presentation.md)
BEAMER_LOGO=$(yq '.beamer.logo' presentation.md)
BEAMER_SECTION_TITLES=$(yq '.beamer.section-titles' presentation.md)

# 生成文章PDF
generate_article() {
    # 生成tex文件
    pandoc -s --dpi=300 --data-dir="${DATA_DIR}" \
    $([ $USE_LUA_FILTER -eq 1 ] && echo "--lua-filter=${ARTICLE_FILTER}")\
        -f "${SOURCE_FORMAT}" -M date="${DATE_COVER}" \
        $([ $USE_PREAMBLE -eq 1 ] && echo "-H ${ARTICLE_PREAMBLE}")\
        $([ $USE_TEMPLATE -eq 1 ] && echo "--template=${ARTICLE_TEMPLATE}")\
        -V geometry="${ARTICLE_GEOMETRY}" \
        -V fontsize="${ARTICLE_FONTSIZE}" \
        -V linestretch="${ARTICLE_LINESTRETCH}" \
        -V fontfamily="${ARTICLE_FONTFAMILY}" \      
        -V beamer=0 \  
        -t latex presentation.md -o presentation_article.tex

    # 生成pdf文件
    pandoc -s --dpi=300 --data-dir="${DATA_DIR}" --pdf-engine "${PDF_ENGINE}" \
    $([ $USE_LUA_FILTER -eq 1 ] && echo "--lua-filter=${ARTICLE_FILTER}")\
        -f "${SOURCE_FORMAT}" -M date="${DATE_COVER}" \
        $([ $USE_PREAMBLE -eq 1 ] && echo "-H ${ARTICLE_PREAMBLE}")\
        $([ $USE_TEMPLATE -eq 1 ] && echo "--template=${ARTICLE_TEMPLATE}")\
        -V geometry="${ARTICLE_GEOMETRY}" \
        -V fontsize="${ARTICLE_FONTSIZE}" \
        -V linestretch="${ARTICLE_LINESTRETCH}" \
        -V fontfamily="${ARTICLE_FONTFAMILY}" \
        -V beamer=0 \
    -t latex presentation.md -o presentation_article.pdf
}

# 生成Beamer PDF
generate_beamer() {
    # 生成tex文件
    pandoc -s --dpi=300 --slide-level 3 --toc --listings --shift-heading-level=0 \
        --data-dir="${DATA_DIR}" \
        $([ $USE_TEMPLATE -eq 1 ] && echo "--template=${BEAMER_TEMPLATE}")\
        $([ $USE_PREAMBLE -eq 1 ] && echo "-H ${BEAMER_PREAMBLE}")\
        -f "${SOURCE_FORMAT}" -M date="${DATE_COVER}" \
        $([ $USE_LUA_FILTER -eq 1 ] && echo "--lua-filter=${BEAMER_FILTER}")\
        -V theme="${BEAMER_THEME}" \
        -V colortheme="${BEAMER_COLORTHEME}" \
        -V fonttheme="${BEAMER_FONTTHEME}" \
        -V aspectratio="${BEAMER_ASPECTRATIO}" \
        -V titlegraphic="${BEAMER_TITLEGRAPHIC}" \
        -V logo="${BEAMER_LOGO}" \
        -V section-titles="${BEAMER_SECTION_TITLES}" \
        -V classoption:aspectratio=169 \
        -t beamer presentation.md -o presentation_beamer.tex

    # 生成pdf文件
    pandoc -s --dpi=300 --slide-level 3 --toc --listings --shift-heading-level=0 \
        --data-dir="${DATA_DIR}" \
        $([ $USE_TEMPLATE -eq 1 ] && echo "--template=${BEAMER_TEMPLATE}")\
        $([ $USE_PREAMBLE -eq 1 ] && echo "-H ${BEAMER_PREAMBLE}")\
        --pdf-engine "${PDF_ENGINE}" -f "${SOURCE_FORMAT}" -M date="${DATE_COVER}" \
        $([ $USE_LUA_FILTER -eq 1 ] && echo "--lua-filter=${BEAMER_FILTER}")\
        -V theme="${BEAMER_THEME}" \
        -V colortheme="${BEAMER_COLORTHEME}" \
        -V fonttheme="${BEAMER_FONTTHEME}" \
        -V aspectratio="${BEAMER_ASPECTRATIO}" \
        -V titlegraphic="${BEAMER_TITLEGRAPHIC}" \
        -V logo="${BEAMER_LOGO}" \
        -V section-titles="${BEAMER_SECTION_TITLES}" \
        -V classoption:aspectratio=169 \
        -t beamer presentation.md -o presentation_beamer.pdf
}

# 处理命令行参数
case "$1" in
    "-a")
        generate_article
        ;;
    "-b")
        generate_beamer
        ;;
    "-ab")
        generate_article
        generate_beamer
        ;;
    "-no-lua")
        USE_LUA_FILTER=0
        generate_article
        generate_beamer
        ;;
    "-no-preamble")
        USE_PREAMBLE=0
        generate_article
        generate_beamer
        ;;
    "-no-template")
        USE_TEMPLATE=0
        generate_article
        generate_beamer
        ;;
    *)
        echo "Usage: $0 [-a|-b|-ab|-no-lua|-no-preamble|-no-template]"
        echo "  -a           Generate article PDF"
        echo "  -b           Generate beamer PDF"
        echo "  -ab          Generate both article and beamer PDFs"
        echo "  -no-lua      Generate PDFs without lua filters"
        echo "  -no-preamble Generate PDFs without preamble"
        echo "  -no-template Generate PDFs without templates"
        exit 1
        ;;
esac
