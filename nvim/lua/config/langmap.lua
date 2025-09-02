------------------------------------------------------------
-- Lang-mappings for Colemak DHm
------------------------------------------------------------

-- Set Custom Keymaps
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Enhanced navigation
-- Use arrow keys to bypass langmap completely
set({ "n", "v", "o" }, "<C-n>", "4<Down>", opts)
set({ "n", "v", "o" }, "<C-e>", "4<Up>", opts)

local colemak_langmap = {
    { "m", "h" },
    { "n", "j" },
    { "e", "k" },
    { "i", "l" },
    { "h", "i" },
    { "j", "m" },
    { "k", "n" },
    { "l", "e" },
}

-- Function to generate the langmap string
local function generate_langmap(mappings)
    -- Mappings include the base, capital, and control variations
    local full_mappings = {}

    for _, mapping in ipairs(mappings) do
        local from, to = mapping[1], mapping[2]
        table.insert(full_mappings, string.format("%s%s", from, to))
        table.insert(full_mappings, string.format("%s%s", from:upper(), to:upper()))
    end

    -- Concatenate all mappings into a single string
    return table.concat(full_mappings, ",")
end

vim.opt.langmap = generate_langmap(colemak_langmap)
vim.opt.langremap = true -- fixes macros
