-- lua/plugins/themes/monokai.lua

require("one_monokai").setup({
    transparent = true,
    colors = {},
    italics = true,
})

vim.cmd.colorscheme("one_monokai")

-- {
--     "cpea2506/one_monokai.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("plugins.themes.monokai")
--     end,
-- }
