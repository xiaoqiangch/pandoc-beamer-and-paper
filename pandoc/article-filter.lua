-- beamer-remove-filter.lua
-- 移除包含"beamer"的标题及其内容

local keep_content = true  -- 标记是否保留内容

-- 判断标题是否包含"beamer"关键字
function is_beamer_header(header)
  return header.content:find('beamer') ~= nil
end

-- 处理标题元素
function Header(el)
  if is_beamer_header(el) then
    keep_content = false
    return {}  -- 移除标题
  else
    keep_content = true
    return el
  end
end

-- 处理内容元素
function handle_content(el)
  -- 始终保留表格和图片
  if el.t == "Table" or el.t == "Image" then
    return el
  end
  
  -- 其他内容根据keep_content标志处理
  if keep_content then
    return el
  else
    return {}  -- 移除内容
  end
end

-- 定义各种内容类型的处理函数
function Para(el) return handle_content(el) end
function BulletList(el) return handle_content(el) end
function OrderedList(el) return handle_content(el) end
function BlockQuote(el) return handle_content(el) end
function CodeBlock(el) return handle_content(el) end
function Div(el) return handle_content(el) end
function Plain(el) return handle_content(el) end
function Str(el) return handle_content(el) end
function Space() return handle_content(pandoc.Space()) end
function SoftBreak() return handle_content(pandoc.SoftBreak()) end
function LineBreak() return handle_content(pandoc.LineBreak()) end
function Emph(el) return handle_content(pandoc.Emph(el)) end
function Strong(el) return handle_content(pandoc.Strong(el)) end
function Link(el)
  if el.target then
    return handle_content(pandoc.Link(el.content, el.target))
  else
    return {}
  end
end
function Image(el)
  if el.src then
    return handle_content(pandoc.Image(el.caption, el.src, el.title))
  else
    return {}
  end
end
function Note(el) return handle_content(pandoc.Note(el)) end
function Table(el)
  -- 确保所有参数都有默认值
  local caption = el.caption or {}
  local aligns = el.aligns or {}
  local widths = el.widths or {}
  local headers = el.headers and pandoc.utils.to_table_head(el.headers) or {}
  local rows = el.rows or {}
  return handle_content(pandoc.Table(caption, aligns, widths, headers, rows))
end

-- 导出过滤器函数
return {
  {
    Header = Header,
    Para = Para,
    BulletList = BulletList,
    OrderedList = OrderedList,
    BlockQuote = BlockQuote,
    CodeBlock = CodeBlock,
    Div = Div,
    Plain = Plain,
    Str = Str,
    Space = Space,
    SoftBreak = SoftBreak,
    LineBreak = LineBreak,
    Emph = Emph,
    Strong = Strong,
    Link = Link,
    Image = Image,
    Note = Note,
    Table = Table
  }
}
