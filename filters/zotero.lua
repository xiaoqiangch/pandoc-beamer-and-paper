-- Zotero参考文献过滤器
-- 作者：chenxiaoqiang
-- 版本：1.0
-- 最后更新：2023-10-01

local function process_citation(cite)
    -- 处理引用
    local citation = {
        prefix = cite.prefix,
        suffix = cite.suffix,
        id = cite.id,
        locator = cite.locator,
        label = cite.label
    }
    
    -- 添加Zotero特定处理
    if citation.id then
        citation.id = "zotero-" .. citation.id
    end
    
    -- 处理页码引用
    if citation.locator and citation.label == "page" then
        citation.prefix = citation.prefix or "第"
        citation.suffix = citation.suffix or "页"
    end
    
    return citation
end

local function process_bibliography(bib)
    -- 处理参考文献
    bib.attributes["style"] = "chinese-gb7714-2005-numeric"
    bib.attributes["locale"] = "zh-CN"
    return bib
end

return {
    {
        Cite = process_citation,
        Div = function(el)
            if el.identifier == "refs" then
                return process_bibliography(el)
            end
            return el
        end
    }
}
