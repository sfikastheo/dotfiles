return {
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("oldworld").setup({
                styles = {
                    booleans = { italic = true, bold = true },
                },
                integrations = {
                    telescope = false,
                }
            })
            vim.cmd.colorscheme("oldworld")
        end
    },
    {
        "savq/melange-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme("melange")
        end
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup({
                telescope = {
                    style = 'classic',
                },
                bright_border = true,
            })
            --vim.cmd.colorscheme('nordic')
        end
    }
}
