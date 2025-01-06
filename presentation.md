---
title: "一次输入，多重输出"
author: "CHEN,Xiaoqiang(陈孝强)"
institute: "粑粑柑共同体"
topic: "以MD为中心的写作和交流"
fontsize: 11pt
urlcolor: red
linkstyle: bold
date: 2024-01-01
toc: true
beamer:
  theme: "Frankfurt"
  colortheme: "beaver"
  fonttheme: "professionalfonts"
  aspectratio: 169
  titlegraphic: "img/aleph0.png"
  logo: "img/aleph0-small.png"
  section-titles: true
article:
  geometry: "a4paper,margin=2cm"
  fontsize: 12pt
  linestretch: 1.5
---

# 一级标题

## 二级标题

### 这是一个幻灯片

- 阿福水电费水电费
-  阿娇事件发生

# 介绍 

## Themes, fonts, etc. 

- I use default **pandoc** themes.
- This presentation is made with **Frankfurt** theme and **beaver** color theme.
- I like **professionalfonts** font scheme.

### b三级标题 beamer

- 这是一个三级标题大短发短发
-  发似懂非懂 


## Links 

- Matrix of beamer themes: [https://hartwork.org/beamer-theme-matrix/](https://hartwork.org/beamer-theme-matrix/)
- Font themes: [http://www.deic.uab.es/~iblanes/beamer_gallery/index_by_font.html](http://www.deic.uab.es/~iblanes/beamer_gallery/index_by_font.html)
- Nerd Fonts: [https://nerdfonts.com](https://nerdfonts.com)

# Formatting 

## Text formatting 

Normal text.
*Italic text* and **bold text**.

## Notes 

> This is a note.
>
>> Nested notes are not supported.
>> And it continues.
>>

### b又有一个三级标题 beamer
- 有些内容
- 又有戏额内容

## Blocks

### bThis is a block A beamer

- Line A
- Line B

New block without header.

### bThis is a block B. beamer

- Line C
- Line D

## Listings

Listings out of the block.

```sh
#!/bin/bash
echo "Hello world!"
echo "line"
```

### bListings in the block. beamer

```sh
#!/bin/bash
echo "Hello world!"
echo "line"
```
### b test frame beamer
- A
- B


## Table


### b test frame beamer
- Caption
- Description

| **Item** | **Description** | **Q-ty** |
| :------------- | --------------------: | :------------: |
| Item A         |    Item A description |       2       |
| Item B         |    Item B description |       5       |
| Item C         |                   N/A |      100      |

## Single picture

This is how we insert picture. Caption is produced automatically from the alt text.

```
![Aleph 0](img/aleph0.png) 
```

![Aleph 0](img/aleph0.png)

## Two or more pictures in a raw

Here are two pictures in the raw. We can also change two pictures size (height or width).

```
![](img/aleph0.png){height=10%}\ ![](img/aleph0.png){height=30%} 
```

![](img/aleph0.png){ height=10% }\ ![](img/aleph0.png){ height=30% }

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

![](img/aleph0.png){height=50%}

::::

:::: column

Text in the right column.

List from the right column:

- Item 1.
- Item 2.
::::

:::

## Two columns: image and table beamer

::: columns

:::: column

![](img/aleph0.png){height=50%}

::::

:::: column

| **Item** | **Option** |
| :------------- | :--------------: |
| Item 1         |     Option 1     |
| Item 2         |     Option 2     |

::::

:::

## Fancy layout

### bProposal beamer

::: columns

:::: column

- Good
- Better
- Best

::::

:::: column

- Point A
- Point B

::::

:::

### Cons beamer

- Bad
- Worse
- Worst



### Conclusion beamer

- Let's go for it!
- No way we go for it!
