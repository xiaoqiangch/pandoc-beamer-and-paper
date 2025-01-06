function Header(el)
    if el.level == 1 then
        -- Convert to \part{Title}
        local title = pandoc.utils.stringify(el.content)
        local part_cmd = pandoc.RawBlock("latex", [[\part{]] .. title .. [[}]] )
        return part_cmd
    elseif el.level == 2 then
        -- Convert to \section{Title}
        local title = pandoc.utils.stringify(el.content)
        local section_cmd = pandoc.RawBlock("latex", [[\section{]] .. title .. [[}]] )
        return section_cmd
    elseif el.level == 3 then
        -- Process level 3 headers based on title
        local title = pandoc.utils.stringify(el.content)
        if title:match("beamer$") then
            -- Remove "beamer" from title
            local new_title = title:gsub("beamer$", "")
            -- Wrap header and content in a Div for frame processing
            return pandoc.Div({el}, { attr = { classes = {'beamer-slide'} } })
        else
            -- Skip this header and its content
            return nil
        end
    end
    return el
end

function Blocks(blocks)
    local new_blocks = {}
    local in_slide = false
    local slide_content = {}
    local current_header = nil

    for _, block in ipairs(blocks) do
        if block.t == "Div" and block.attributes and block.attributes.classes and pandoc.utils.includes(block.attributes.classes, 'beamer-slide') then
            if in_slide then
                -- Close the previous slide and add to new_blocks
                local frame = create_frame(current_header, slide_content)
                table.insert(new_blocks, frame)
                slide_content = {}
            end
            -- Set the new slide header
            if block.content and #block.content > 0 and block.content[1].t == "Header" then
                current_header = block.content[1]
                in_slide = true
            end
            -- Continue to collect content for this slide
        elseif block.t == "Header" then
            if in_slide then
                -- Close the current slide before a new header
                local frame = create_frame(current_header, slide_content)
                table.insert(new_blocks, frame)
                slide_content = {}
                in_slide = false
            end
            -- Add the header directly if not in a slide
            table.insert(new_blocks, block)
        else
            if in_slide then
                -- Collect content for the current slide
                table.insert(slide_content, block)
            else
                -- Add block directly to new_blocks
                table.insert(new_blocks, block)
            end
        end
    end
    if in_slide then
        -- Close the last slide
        local frame = create_frame(current_header, slide_content)
        table.insert(new_blocks, frame)
    end
    return new_blocks
end

function create_frame(header, content)
    if not header then
        return nil -- or handle as needed
    end
    local title = pandoc.utils.stringify(header.content)
    local content_str = pandoc.write(content, 'latex')
    local frame = pandoc.RawBlock("latex", [[
\begin{frame}
\frametitle{]] .. title .. [[}
]] .. content_str .. [[
\end{frame}
]])
    return frame
end

return {
    {Header = Header},
    {Blocks = Blocks}
}