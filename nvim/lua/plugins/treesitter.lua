-- lua/plugins/treesitter.lua
require("nvim-treesitter.configs").setup({
    -- Parsers to install:
    ensure_installed = {
        -- Assembly
        "asm",
        "disassembly",
        -- Linux
        "devicetree",
        "bash",
        "jq",
        "make",
        "pem",
        "strace",
        -- Programming
        "c",
        "cpp",
        "cuda",
        "cmake",
        "go",
        "lua",
        "java",
        "nix",
        "python",
        "rust",
        "ron",
        "zig",
        -- Programming adjacent
        "json",
        "csv",
        -- Web
        "css",
        "html",
        "javascript",
        "scss",
        "typescript",
        "xml",
        -- Configuration files
        "ini",
        "dockerfile",
        "rasi",
        "yaml",
        "toml",
        -- Other
        "comment",
        "diff",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        -- Notes
        "markdown",
        "markdown_inline",
        -- Plugins
        "jsonc", -- JSON with comments
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
