return {
    "stevearc/conform.nvim",
    event = { "BufreadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                css = { "prettierd" },
                graphql = { "prettierd" },
                html = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                json = { "prettierd" },
                jsonc = { "prettierd" },
                liquid = { "prettierd" },
                lua = { "stylua" },
                markdown = { "prettierd" },
                nix = { "nixfmt" },
                python = { "ruff_organize_imports", "ruff_format" },
                roc = { "roc" },
                rust = { "rustfmt" },
                svelte = { "prettierd" },
                toml = { "taplo" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                yaml = { "prettierd" },
            }
        })
    end
}
