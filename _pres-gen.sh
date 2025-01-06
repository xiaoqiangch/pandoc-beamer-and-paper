#!/bin/sh

# 获取当前日期
DATE_COVER=$(date "+%d %B %Y")

# 定义源格式
SOURCE_FORMAT="markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs"


# 定义常量路径和选项
DATA_DIR="pandoc"
PDF_ENGINE="xelatex"
TEMPLATE="pandoc/templates/default.latex"
PREAMBLE="pandoc/templates/preamble.tex"
BEAMER_FILTER="pandoc/beamer-filter.lua"
ARTICLE_FILTER="pandoc/article-filter.lua"

# 从配置文件中读取选项
ARTICLE_GEOMETRY=$(yq '.article.geometry' presentation.md)
ARTICLE_FONTSIZE=$(yq '.article.fontsize' presentation.md)
ARTICLE_LINESTRETCH=$(yq '.article.linestretch' presentation.md)

BEAMER_THEME=$(yq '.beamer.theme' presentation.md)
BEAMER_COLORTHEME=$(yq '.beamer.colortheme' presentation.md) 
BEAMER_FONTTHEME=$(yq '.beamer.fonttheme' presentation.md)
BEAMER_ASPECTRATIO=$(yq '.beamer.aspectratio' presentation.md)
BEAMER_TITLEGRAPHIC=$(yq '.beamer.titlegraphic' presentation.md)
BEAMER_LOGO=$(yq '.beamer.logo' presentation.md)
BEAMER_SECTION_TITLES=$(yq '.beamer.section-titles' presentation.md)

# 生成文章PDF
generate_article() {
    pandoc -s --dpi=300 --data-dir="${DATA_DIR}" --pdf-engine "${PDF_ENGINE}" \
    --lua-filter="${ARTICLE_FILTER}"\
        -f "${SOURCE_FORMAT}" -M date="${DATE_COVER}" \
        -V geometry="${ARTICLE_GEOMETRY}" \
        -V fontsize="${ARTICLE_FONTSIZE}" \
        -V linestretch="${ARTICLE_LINESTRETCH}" \
        -t latex presentation.md -o presentation_article.pdf
}

# 生成Beamer PDF
generate_beamer() {
    pandoc -s --dpi=300 --slide-level 3 --toc --listings --shift-heading-level=0 \
        --data-dir="${DATA_DIR}" --template "${TEMPLATE}" -H "${PREAMBLE}" \
        --pdf-engine "${PDF_ENGINE}" -f "${SOURCE_FORMAT}" -M date="${DATE_COVER}" \
        --lua-filter="${BEAMER_FILTER}"\
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
    *)
        echo "Usage: $0 [-a|-b|-ab|-preamble]"
        echo "  -a         Generate article PDF"
        echo "  -b         Generate beamer PDF"
        echo "  -ab        Generate both article and beamer PDFs"
        exit 1
        ;;
esac
