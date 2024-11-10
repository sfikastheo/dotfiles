-- lua/plugins/floaty.lua
local floaty = require('floaty')

require("floaty").setup({
    width = 0.9,
    height = 0.9,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    winhl = "Normal:Normal,FloatBorder:Normal",
    runners = {},
})

local set = vim.keymap.set
set({ 'n', 't' }, '<C-w>t', floaty.toggle, { silent = true })
