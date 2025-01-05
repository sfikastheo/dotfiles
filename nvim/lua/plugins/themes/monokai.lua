-- lua/plugins/themes/monokai.lua

require("one_monokai").setup({
    transparent = true,
    colors = {},
    themes = function(colors)
        return {}
    end,
    italics = true,
})

vim.cmd.colorscheme("one_monokai")
