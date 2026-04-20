return {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
        -- UI changes
        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "●",
                    [vim.diagnostic.severity.WARN] = "▲",
                    [vim.diagnostic.severity.HINT] = "◆",
                    [vim.diagnostic.severity.INFO] = "●",
                },
            },
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = {
                focusable = true,
                border = "rounded",
                prefix = "",
                style = "minimal",
            },
        })

        -- Keymaps
        local maps = {
            { "n", "<leader>j", vim.diagnostic.open_float, "Hover Diagnostics" },
            { "n", "<leader>fr", vim.lsp.buf.references, "Find References" },
            { "n", "<leader>k", vim.lsp.buf.hover, "Hover help" },
            { "n", "gq", vim.diagnostic.setqflist, "Diagnostics → Quickfix" },
            { "n", "g.", vim.lsp.buf.code_action, "Code Actions" },
            { "n", "gD", vim.lsp.buf.declaration, "Go to Declaration" },
        }

        local function opts(desc, extra)
            local opt = { noremap = true, silent = true, desc = desc }
            if extra then for k, v in pairs(extra) do opt[k] = v end end
            return opt
        end

        for _, m in ipairs(maps) do
            vim.keymap.set(m[1], m[2], m[3], opts(m[4]))
        end

        -- LSP servers
        local lsps = {
            "c",
            "fsharp",
            "golang",
            "lua",
            "markdown",
            "nix",
            "python",
            "terraform",
            "toml",
            "typescript",
        }

        for _, lsp in ipairs(lsps) do
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local import = "lsps." .. lsp

            require(import).setup({ capabilities = capabilities })
        end
    end
}
