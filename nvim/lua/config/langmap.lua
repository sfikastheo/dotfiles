------------------------------------------------------------
-- Lang-mappings for Colemak DHm
------------------------------------------------------------

-- Set Custom Keymaps
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

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

local colemak_mappings = {
    { { "n", "v", "o" }, "<C-n>", "4j" },
    { { "n", "v", "o" }, "<C-e>", "4k" },
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

local function generate_keymaps(mappings)
    for _, mapping in ipairs(mappings) do
        local modes, key, action = mapping[1], mapping[2], mapping[3]
        set(modes, key, action, opts)
    end
end

vim.opt.langmap = generate_langmap(colemak_langmap)
generate_keymaps(colemak_mappings)
