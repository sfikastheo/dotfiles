-- lua/plugins/none-ls.lua
local null = require("null-ls")
local formatter = null.builtins.formatting
local diagnostics = null.builtins.diagnostics

-- LSP intergration to Linters-Formatters
null.setup({
    sources = {
        formatter.stylua,
        formatter.prettier,
        formatter.isort,
        formatter.black,
        diagnostics.mypy,
    },
})
