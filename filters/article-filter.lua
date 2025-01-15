-- 文章过滤器
-- 作者：chenxiaoqiang
-- 版本：1.0
-- 最后更新：2023-10-01

local function process_math(block)
    -- 处理数学公式
    if block.text:match("^%$%$") then
        block.text = block.text:gsub("^%$%$", "\\[")
        block.text = block.text:gsub("%$%$$", "\\]")
    elseif block.text:match("^%$") then
        block.text = block.text:gsub("^%$", "\\(")
        block.text = block.text:gsub("%$$", "\\)")
    end
    return block
end

local function process_image(el)
    -- 处理图片
    if el.src:match("%.svg$") then
        el.src = el.src:gsub("%.svg$", ".png")
    end
    return el
end

local function process_code(block)
    -- 处理代码块
    if block.classes[1] == "python" then
        block.attributes["caption"] = "Python代码示例"
    elseif block.classes[1] == "bash" then
        block.attributes["caption"] = "Shell命令示例"
    end
    return block
end

return {
    {
        Math = process_math,
        Image = process_image,
        CodeBlock = process_code
    }
}
