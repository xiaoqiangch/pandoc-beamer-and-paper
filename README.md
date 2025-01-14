# Pandoc Beamer 和 Paper 项目

这是一个使用 Pandoc 生成 Beamer 演示文稿和学术论文的项目模板。

## 主要功能

- 使用 Markdown 编写内容，自动生成 LaTeX/PDF
- 支持 Beamer 演示文稿和学术论文两种格式
- 提供多种预定义布局和主题
- 包含示例文件和测试脚本

## 使用方法

1. 安装依赖：
   - Pandoc
   - LaTeX
   - Lua

2. 生成文档：
   ```bash
   make presentation  # 生成演示文稿
   make article       # 生成学术论文
   ```

3. 查看输出：
   - 演示文稿：presentation_beamer.pdf
   - 学术论文：presentation_article.pdf

## 自定义选项

### 布局
项目提供多种预定义布局，位于 `img/layouts/` 目录下。可以通过修改模板文件选择不同布局。

### 主题
项目提供多种主题，位于 `img/themes/` 目录下。可以通过修改模板文件选择不同主题。

## 示例

`lab/` 目录包含示例文件和测试脚本：
- `example.md`: 示例 Markdown 文件
- `run-example.sh`: 运行示例的脚本
- `md2beamer.sh`: Markdown 转 Beamer 的脚本

## 许可证

本项目采用 MIT 许可证，详见 LICENSE 文件。
