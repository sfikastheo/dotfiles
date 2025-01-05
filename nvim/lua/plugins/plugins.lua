-- lua/plugins/plugins.lua

return {
    --
    -- Themes
    --
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            --require("plugins.themes.nordic")
        end,
    },
    {
        'f4z3r/gruvbox-material.nvim',
        name = 'gruvbox-material',
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            --vim.cmd("set background=light")
            require("plugins.themes.gruvbox")
        end,
    },
    --
    -- Core Utilities
    -- Which-key
    {
        "folke/which-key.nvim",
        version = "^3",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            require("plugins.telescope")
        end,
    },
    -- Tree-sitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("plugins.treesitter")
        end,
    },
    -- mini-files
    {
        "echasnovski/mini.files",
        version = "*",
        config = function()
            require("plugins.mini-files")
        end,
    },
    -- mini.pairs
    {
        "echasnovski/mini.pairs",
        config = function()
            require("mini.pairs").setup()
        end,
        event = "InsertEnter",
    },
    -- mini.surround
    {
        "echasnovski/mini.surround",
        config = function()
            require("plugins.mini-surround")
        end,
    },
    -- Floating Terminal
    {
        "devkvlt/floaty.nvim",
        config = function()
            require("plugins.floaty")
        end,
    },
    --  Flash
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.flash")
        end,
    },
    --
    -- LSPs - Formatters - Linters
    -- Mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("plugins.lsp.mason")
        end,
    },
    -- Mason LSP Config
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = false,
                ensure_installed = {
                    "lua_ls",
                    "pylsp",
                },
            })
        end,
    },
    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp.init")
        end,
    },
    -- none-ls
    {
        "nvimtools/none-ls.nvim",
        event = "InsertEnter",
        config = function()
            require("plugins.none-ls")
        end,
    },
    -- fidget
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    -- tiny-inline-diagnostic
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        priority = 1000,
        config = function()
            require('plugins.tiny-inline')
        end
    },
    --
    -- Completions
    -- nvim-cmp
    {
        -- Completion Engine
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            -- Connects cmp to LSP
            "hrsh7th/cmp-nvim-lsp",
            {
                -- Snipset Engine
                "L3MON4D3/LuaSnip",
                dependencies = {
                    -- Connects cmp with sources
                    "saadparwaiz1/cmp_luasnip",
                    -- Snipset Provider
                    "rafamadriz/friendly-snippets",
                },
            },
            {
                "Saecki/crates.nvim",
                event = { "BufRead Cargo.toml" },
                opts = {
                    completion = {
                        cmp = { enabled = true },
                    },
                },
            },
        },
        config = function()
            require("plugins.nvim-cmp")
        end,
    },
    --
    -- Code Completion
    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("plugins.copilot")
        end,
    },
    --
    -- Git Integration
    -- Git Signs
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    },
    --
    -- UI plugins
    -- lua-line
    {
        -- Cannot be lazy loaded
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            { "yavorski/lsp-progress.nvim",            config = true },
            { "yavorski/lualine-macro-recording.nvim", config = true },
        },
        config = function()
            require("plugins.lualine")
        end,
    },
    -- Mini Indent Scope
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.mini-indent")
        end,
    },
}
