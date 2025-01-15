# Pandoc Beamer 和 Paper 项目

这是一个使用 Pandoc 生成 Beamer 演示文稿和学术论文的项目模板。

## 主要功能

- 使用 Markdown 编写内容，自动生成 LaTeX/PDF
- 支持 Beamer 演示文稿和学术论文两种格式
- 提供多种预定义布局和主题
- 包含示例文件和测试脚本
- 自动化图片处理和格式转换
- 支持 Zotero 参考文献管理

## 安装步骤

### macOS
1. 安装依赖：
   ```bash
   # 安装 Pandoc
   brew install pandoc

   # 安装 LaTeX 发行版 (MacTeX)
   brew install --cask mactex

   # 安装 Lua
   brew install lua

   # 安装 draw.io
   brew install --cask drawio
   ```

### Linux
1. 安装依赖：
   ```bash
   # 安装 Pandoc
   sudo apt install pandoc

   # 安装 LaTeX 发行版 (TeX Live)
   sudo apt install texlive-full

   # 安装 Lua
   sudo apt install lua5.3

   # 安装 draw.io
   sudo snap install drawio
   ```

### Windows
1. 安装依赖：
   - 下载并安装 [Pandoc](https://pandoc.org/installing.html)
   - 下载并安装 [MiKTeX](https://miktex.org/download)
   - 下载并安装 [Lua for Windows](https://github.com/rjpcomputing/luaforwindows/releases)
   - 下载并安装 [draw.io Desktop](https://github.com/jgraph/drawio-desktop/releases)

2. 克隆项目：
   ```bash
   git clone https://github.com/yourusername/pandoc-beamer-and-paper.git
   cd pandoc-beamer-and-paper
   ```

3. 安装 Python 依赖（可选）：
   ```bash
   pip install -r requirements.txt
   ```

## 使用方法

### 基本命令

```bash
# 生成演示文稿
make presentation

# 生成学术论文  
make article

# 生成所有格式文档
make all

# 清理生成的文件
make clean
```

### 配置选项

在 `Makefile` 中可以配置以下选项：

- `INPUT_MD`: 输入 Markdown 文件路径（默认：presentation.md）
- `BUILD_DIR`: 输出目录（默认：build）
- `PDF_ENGINE`: PDF 生成引擎（默认：xelatex）
- `FORCE_REBUILD`: 强制重新生成所有文件（默认：false）

### 自定义模板

项目提供以下模板文件，位于 `templates/` 目录：

- `article.tex`: 学术论文模板
- `beamer.tex`: 演示文稿模板
- `article-preamble.tex`: 论文前置内容
- `beamer-preamble.tex`: 演示文稿前置内容

## 布局和主题

### 布局
项目提供多种预定义布局，位于 `img/layouts/` 目录下：

- 两栏布局（40-60，等宽）
- 三栏布局（30-40-30，等宽）  
- 图文混排布局
- 表格布局

### 主题
项目提供多种主题，位于 `img/themes/` 目录下：

- Aleph0 主题
- 简约主题
- 学术主题

## 示例

`lab/` 目录包含示例文件和测试脚本：

- `example.md`: 示例 Markdown 文件
- `run-example.sh`: 运行示例的脚本
- `md2beamer.sh`: Markdown 转 Beamer 的脚本

## 平台兼容性

项目支持以下平台：
- macOS
- Linux
- Windows

主要差异：
1. 路径分隔符：macOS/Linux使用`/`，Windows使用`\`
2. 命令行工具：macOS/Linux使用bash，Windows使用PowerShell/CMD
3. 依赖安装方式：macOS使用Homebrew，Linux使用apt/snap，Windows使用安装包

## 常见问题

### 1. 图片无法显示？
- 确保图片路径正确
- 使用 `make convert_svg` 转换 SVG 图片
- 检查图片文件权限

### 2. 参考文献无法生成？
- 确保 Zotero 已安装并运行
- 检查 `references.bib` 文件是否存在
- 确认 Zotero 端口配置正确

## 许可证

本项目采用 MIT 许可证，详见 LICENSE 文件。
