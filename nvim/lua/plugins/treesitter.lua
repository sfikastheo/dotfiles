-- lua/plugins/treesitter.lua
require("nvim-treesitter.configs").setup({
    -- Parsers to install:
    ensure_installed = {
        "c",
        "go",
        "lua",
        "nix",
        "zig",
        "cpp",
        "bash",
        "make",
        "rust",
        "cuda",
        "cmake",
        "java",
        "python",

        "css",
        "xml",
        "html",
        "scss",
        "javascript",
        "typescript",

        "ini",
        "rasi",
        "yaml",
        "toml",
        "dockerfile",

        "csv",
        "json",
        "diff",
        "comment",
        "markdown",
        "gitcommit",
        "gitignore",
        "git_config",
        "git_rebase",
        "markdown_inline",
    },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true, -- Tree-sitter highlighting
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
    },

    autopairs = {
        enable = true,
    },

    incremental_selection = {
        enable = false,
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            selection_modes = {},
            keymaps = {
                ["if"] = "@function.inner",
                ["af"] = "@function.outer",
                ["is"] = "@class.inner",
                ["as"] = "@class.outer",
                ["ic"] = "@conditional.inner",
                ["ac"] = "@conditional.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["ip"] = "@paragraph.inner",
                ["ap"] = "@paragraph.outer",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer",
                ["ia"] = "@assignment.inner",
                ["aa"] = "@assignment.outer",
                ["aj"] = "@assignment.lhs",
                ["ak"] = "@assignment.rhs"
            },
        },
        lsp_interop = {
            enable = true,
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            },
            floating_preview_opts = {},
        },
    },
})
