local null = require("null-ls")
local formatter = null.builtins.formatting
local diagnostics = null.builtins.diagnostics

-- LSP intergration to Linters-Formatters
null.setup({
    sources = {
        formatter.stylua,
        formatter.prettier,
        diagnostics.mypy,
    },
})
