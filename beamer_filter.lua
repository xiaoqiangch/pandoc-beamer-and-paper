function Header(el)
  if el.level == 3 then
    for _, part in ipairs(el.content) do
      if part.text and string.find(part.text, "beamer") then
        return el
      end
    end
    return {}
  end
  return el
end

function Strikeout(el)
  if el.content and el.content[1] and el.content[1].text then
    return pandoc.RawInline('latex', '\\st{' .. el.content[1].text .. '}')
  end
  return el
end

return {{
  Header = Header,
  Strikeout = Strikeout,
}}