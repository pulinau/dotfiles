local bufnr = 0 -- 0 means the current file
local parser = vim.treesitter.get_parser(bufnr, "lua")
local tree = parser:parse()[1]
local root = tree:root()

-- This is the "Search" pattern
local query = vim.treesitter.query.parse("lua", "((string) @str)")

-- We will store the changes here and apply them at once
local changes = {}

for id, node in query:iter_captures(root, bufnr) do
    local text = vim.treesitter.get_node_text(node, bufnr)

    -- Logic: Starts/ends with ' AND does not contain "
    if text:sub(1, 1) == "'" and not text:find('"', 1, true) then
        local s_row, s_col, e_row, e_col = node:range()
        local new_text = '"' .. text:sub(2, -2) .. '"'
        table.insert(changes, { s_row, s_col, e_row, e_col, new_text })
    end
end

-- Apply changes in reverse order so line numbers don't shift
for i = #changes, 1, -1 do
    local c = changes[i]
    vim.api.nvim_buf_set_text(bufnr, c[1], c[2], c[3], c[4], { c[5] })
end
