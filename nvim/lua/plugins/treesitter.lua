return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        lazy = false,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        },
        config = function()
            require("nvim-treesitter").install({
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "csv",
                "cuda",
                "diff",
                "dockerfile",
                "git_rebase",
                "gitcommit",
                "go",
                "html",
                "java",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "nix",
                "python",
                "rust",
                "scss",
                "toml",
                "typescript",
                "xml",
                "yaml",
                "zig",
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
            local select = require("nvim-treesitter-textobjects.select")
            local keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["as"] = "@class.outer",
                ["is"] = "@class.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ap"] = "@paragraph.outer",
                ["ip"] = "@paragraph.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["aa"] = "@assignment.outer",
                ["ia"] = "@assignment.inner",
                ["aj"] = "@assignment.lhs",
                ["ak"] = "@assignment.rhs",
            }
            for key, query in pairs(keymaps) do
                vim.keymap.set({ "x", "o" }, key, function()
                    select.select_textobject(query, "textobjects")
                end)
            end
        end,
    },
}
