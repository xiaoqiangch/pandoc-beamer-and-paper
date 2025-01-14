local in_beamer_section = false

function is_beamer_title(el)
  -- 检查标题是否包含beamer
  if el.content then
    for _, part in ipairs(el.content) do
      if part.text and string.find(part.text, "beamer") then
        return true
      end
    end
  end
  return false
end

function Header(el)
  -- 处理标题元素
  if is_beamer_title(el) then
    in_beamer_section = true
    return el
  else
    in_beamer_section = false
    return {}
  end
end

function BlockFilter(el)
  -- 处理所有块级元素
  if in_beamer_section then
    return el
  end
  return {}
end

return {
  {
    Header = Header,
    Div = BlockFilter,
    BlockQuote = BlockFilter,
    CodeBlock = BlockFilter,
    Para = BlockFilter,
    BulletList = BlockFilter,
    OrderedList = BlockFilter
  }
}
