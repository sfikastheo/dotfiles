return {
    "stevearc/conform.nvim",
    event = { "BufreadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                python = { "isort", "black" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                markdown = { "prettierd" },
                graphql = { "prettierd" },
                svelte = { "prettierd" },
                liquid = { "prettierd" },
                jsonc = { "prettierd" },
                yaml = { "prettierd" },
                html = { "prettierd" },
                json = { "prettierd" },
                css = { "prettierd" },
                rust = { "rustfmt" },
                toml = { "taplo" },
                nix = { "nixfmt" },
                lua = { "stylua" },
                roc = { "roc" },
            }
        })
    end
}
