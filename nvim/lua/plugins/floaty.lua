-- lua/plugins/floaty.lua
local floaty = require('floaty')

local base_opts = { noremap = true, silent = true }
local function set_opts(desc)
    local extended_opts = vim.tbl_extend("force", base_opts, { desc = desc })
    return extended_opts
end

require("floaty").setup({
    width = 0.9,
    height = 0.9,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    winhl = "Normal:Normal,FloatBorder:Normal",
    runners = {},
})

local set = vim.keymap.set
set({ 'n' }, '<leader>tt', floaty.toggle, set_opts('[T]oggle [T]erminal'))
