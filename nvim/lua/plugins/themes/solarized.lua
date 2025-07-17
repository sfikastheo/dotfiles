return {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1200,
    opts = {},
    config = function(_, opts)
        require("solarized").setup(opts)
        vim.cmd.colorscheme("solarized")
    end
}
