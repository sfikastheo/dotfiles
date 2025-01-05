require('gruvbox-material').setup({
    italics = true,
    contrast = "hard",
    comments = {
        italics = true,
    },
    background = {
        transparent = false,
    },
    float = {
        force_background = false,
        background_color = nil,

    },
    signs = {
        highlight = true,
    },
    customize = nil,
})

vim.cmd("colorscheme gruvbox-material")

-- override defaults
local colors = require("gruvbox-material.colors").get(vim.o.background, "hard")

vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.bg0 })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg0 })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.grey1 })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = colors.bg0 })
