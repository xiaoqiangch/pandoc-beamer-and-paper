-- 简单文本替换示例
function Str(elem)
    -- 将所有"示例"替换为"DEMO"
    if elem.text == "示例" then
        return pandoc.Str("DEMO")
    end
end

-- 复杂文档转换示例
function Div(elem)
    -- 为所有div添加class="highlight"
    local has_highlight = false
    for _, class in ipairs(elem.classes) do
        if class == "highlight" then
            has_highlight = true
            break
        end
    end
    if has_highlight then
        elem.attributes["style"] = "background-color: yellow;"
        return elem
    end
end

-- 元数据处理示例
function Meta(meta)
    -- 添加自定义元数据
    meta.date = os.date("%Y-%m-%d")
    return meta
end

local function walk_blocks(blocks)
    local new_blocks = {}
    local mark_next_para = false
    
    for i, block in ipairs(blocks) do
        if block.t == "Header" and block.level == 3 then
            mark_next_para = true
            table.insert(new_blocks, block)
        elseif block.t == "Para" and mark_next_para then
            -- 在段落前后添加"oooo"
            local new_content = {
                pandoc.Str("oooo "),
                table.unpack(block.content),
                pandoc.Str(" oooo")
            }
            table.insert(new_blocks, pandoc.Para(new_content))
            mark_next_para = false
        else
            table.insert(new_blocks, block)
        end
    end
    
    return new_blocks
end

function Pandoc(doc)
    return pandoc.Pandoc(walk_blocks(doc.blocks), doc.meta)
end

-- 返回filter集合
return {
    {Str = Str, Div = Div, Meta = Meta, Pandoc = Pandoc}
}
