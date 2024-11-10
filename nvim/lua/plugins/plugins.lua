-- lua/plugins/plugins.lua

return {
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.themes.nordic")
        end,
    },
    --
    -- Core Utilities
    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
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
            require("plugins.lsp.mason-lspconfig")
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
    --
    -- Completions
    -- nvim-cmp
    {
        -- Completion Engine
        "hrsh7th/nvim-cmp",
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
    -- Debuggers
    -- nvim-dap
    --    {
    --        "rcarriga/nvim-dap-ui",
    --        dependencies = {
    --            "mfussenegger/nvim-dap",
    --            "nvim-neotest/nvim-nio",
    --            "theHamsta/nvim-dap-virtual-text",
    --    },
    --        config = function()
    --            require("plugins.dap")
    --        end,
    --    },
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
    -- Neogit
    {
        "TimUntersberger/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
        },
        config = function()
            require("plugins.neogit")
        end,
    },
    --
    -- Language Specific Plugins
    --
    -- Org Mode
    -- Orgmode.nvim
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require("plugins.nvim-org")
        end,
    },
    -- Org-bullets
    {
        "akinsho/org-bullets.nvim",
        ft = { "org" },
        dependencies = {
            "nvim-orgmode/orgmode",
        },
    },
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
    --
    -- AI Plugins
    -- Avante
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {},
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
        config = function()
            require("plugins.avante")
        end,
    },
}
