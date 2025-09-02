return {
    {
        "cpea2506/one_monokai.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            --require("one_monokai").setup({
            --    transparent = true,
            --    colors = {},
            --    italics = true,
            --})
            --vim.cmd.colorscheme("one_monokai")
        end
    },
    {
        "vague2k/vague.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            --vim.cmd.colorscheme("vague")
        end
    },
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
    }
}
