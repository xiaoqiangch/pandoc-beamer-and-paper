---
<<<<<<< HEAD
title: "My wonderful presentation"
author: "Alexey Gumirov"
institute: "My home office"
topic: "Pandoc how-to"
theme: "Frankfurt"
colortheme: "beaver"
fontsize: 11pt
urlcolor: red
linkstyle: bold
aspectratio: 169
titlegraphic: img/themes/aleph0.png
logo: img/themes/aleph0-small.png
date:
section-titles: false
toc: true
system: mac
---

# Output Format Differences

## Beamer vs Article Output

This presentation demonstrates the differences between beamer (slide) and article (document) output formats:

- **Beamer Output**:
  - Content is split into slides
  - Columns appear side-by-side
  - Slide-specific formatting is preserved
  - Beamer-specific elements are visible

- **Article Output**:
  - Content flows continuously
  - Columns stack vertically
  - Beamer-specific elements are removed
  - More suitable for printed documents

::: beamer
This content will only appear in beamer output
:::

# General information


## Themes, fonts, etc.
=======
title: "一次编写；多变输出"
author: "CHEN, Xiaoqiang(陈孝强)"
institute: "粑粑柑革命共同体"
topic: "Pandoc的平板文档"
date: "2023-10-15"
mainfont: STSong
CJKmainfont: STSong
fontfamily: STSong
fontfamilyoptions:
  - BoldFont=SimHei # 设置粗体字体为黑体
  - ItalicFont=KaiTi # 设置斜体字体为楷体
  - AutoFakeBold=true # 自动模拟粗体
article:
    geometry: "a4paper"
    fontsize: "11pt"
    linestretch: "1.25"
    toc: true              # 添加目录
    numbersections: true  # 给章节编号
beamer:
  theme: "Frankfurt"
  colortheme: "beaver"
  fonttheme: "professionalfonts"
  aspectratio: "169"
  titlegraphic: "img/aleph0.png"
  logo: "img/aleph0-small.png"
  section-titles: "false"
---

# General information beamer

## Themes, fonts, etc. beamer
>>>>>>> b1440827d087a099fa4c956777f7078b5589dc60

- I use default **pandoc** themes.
- This presentation is made with **Frankfurt** theme and **beaver** color theme.
- I like **professionalfonts** font scheme. 

## Links beamer

- Matrix of beamer themes: [https://hartwork.org/beamer-theme-matrix/](https://hartwork.org/beamer-theme-matrix/)
- Font themes: [http://www.deic.uab.es/~iblanes/beamer_gallery/index_by_font.html](http://www.deic.uab.es/~iblanes/beamer_gallery/index_by_font.html)
- Nerd Fonts: [https://nerdfonts.com](https://nerdfonts.com)

# Formatting beamer
## Text formatting beamer

Normal text.
*Italic text* and **bold text**.
~~Strike out~~ is supported.

## Notes beamer

> This is a note.
> > Nested notes are not supported.
> And it continues.

## Blocks

### This is a block A

- Line A
- Line B

### 

New block without header.

### This is a block B. beamer

- Line C
- Line D

## Listings

Listings out of the block.

```sh
#!/bin/bash
echo "Hello world!"
echo "line"
```
### Listings in the block. beamer

```sh
#!/bin/bash
echo "Hello world!"
echo "line"
```

## Table beamer

**Item** | **Description** | **Q-ty**
:--------|-----------------:|:---:
Item A | Item A description | 2
Item B | Item B description | 5
Item C | N/A | 100

## Single picture 

This is how we insert picture. Caption is produced automatically from the alt text.

```
![Aleph 0](img/themes/aleph0.png) 
```

![Aleph 0](img/themes/aleph0.png) 

## Two or more pictures in a raw

Here are two pictures in the raw. We can also change two pictures size (height or width).

###
```
![](img/themes/aleph0.png){height=10%}\ ![](img/themes/aleph0.png){height=30%} 
```

![](img/themes/aleph0.png){ height=10% }\ ![](img/themes/aleph0.png){ height=30% }

## Lists

1. Idea 1
2. Idea 2
	- genius idea A
	- more genius 2
3. Conclusion


## Two columns of equal width

::: columns

:::: column

Left column text.

Another text line.

::::

:::: column

- Item 1.
- Item 2.
- Item 3.

::::

:::

## Two columns of with 40:60 split

::: columns

:::: {.column width=40%}

Left column text.

Another text line.

::::

:::: {.column width=60%}

- Item 1.
- Item 2.
- Item 3.

::::

:::

## Three columns with equal split

::: columns

:::: column

Left column text.

Another text line.

::::

:::: column

Middle column list:

1. Item 1.
2. Item 2.

::::

:::: column

Right column list:

- Item 1.
- Item 2.

::::

:::

## Three columns with 30:40:30 split

::: columns

:::: {.column width=30%}

Left column text.

Another text line.

::::

:::: {.column width=40%}

Middle column list:

1. Item 1.
2. Item 2.

::::

:::: {.column width=30%}

Right column list:

- Item 1.
- Item 2.

::::

:::

## Two columns: image and text

::: columns

:::: column

![](img/themes/aleph0.png){height=50%}

::::

:::: column

Text in the right column.  

List from the right column:

- Item 1.
- Item 2.
::::

:::

## Two columns: image and table

::: columns

:::: column

![](img/aleph0.png){height=50%}

::::

:::: column

| **Item** | **Option** |
|:---------|:----------:|
| Item 1   | Option 1   |
| Item 2   | Option 2   |

::::

:::

## Fancy layout beamer

### Proposal

- Point A
- Point B

::: columns

:::: column

### Pros

- Good
- Better
- Best

::::

:::: column

### Cons beamer

- Bad
- Worse
- Worst

::::

:::

### Conclusion beamer

- Let's go for it!
- No way we go for it!

## Article vs Beamer Differences

### Long Paragraph

This is a long paragraph that demonstrates how text flows differently in article mode versus beamer mode. In article mode, the text will flow naturally across the full page width, creating a more traditional document layout. In beamer mode, the text will be constrained to slide dimensions, often requiring manual line breaks or adjustments to fit within the slide boundaries.

### Mathematical Formulas

Here is an example of a mathematical formula:

$$
f(x) = \int_{-\infty}^\infty \hat f(\xi)\,e^{2 \pi i \xi x} \,d\xi
$$

In article mode, this formula will be centered on its own line with proper spacing. In beamer mode, it may need to be scaled down to fit within the slide.

### Block Quotes

> This is a block quote that will appear differently in article and beamer modes. In article mode, it will have proper indentation and spacing. In beamer mode, it may be styled according to the beamer theme.

### Footnotes

Here is some text with a footnote[^note].

[^note]: This is a footnote. In article mode, it will appear at the bottom of the page. In beamer mode, it may appear inline or at the bottom of the slide.
