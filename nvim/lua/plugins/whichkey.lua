return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    version = "^3",

    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end
}
