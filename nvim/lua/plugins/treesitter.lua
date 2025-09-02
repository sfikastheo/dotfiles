return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        lazy = false,
        branch = 'master',
        config = function()
            require("nvim-treesitter.configs").setup({
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
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "rust" }
                },
                auto_install = true,
                sync_install = false,
                indent = { enable = true },
                autopairs = { enable = true },
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
                        }
                    },
                    lsp_interop = {
                        enable = true,
                        border = {
                            { "╭", "floatborder" },
                            { "─", "floatborder" },
                            { "╮", "floatborder" },
                            { "│", "floatborder" },
                            { "╯", "floatborder" },
                            { "─", "floatborder" },
                            { "╰", "floatborder" },
                            { "│", "floatborder" },
                        },
                        floating_preview_opts = {},
                    }
                }
            })
        end
    }
}
