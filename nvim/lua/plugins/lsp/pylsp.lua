-- lua/plugins/lsp/pylsp.lua

return {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                    ignore = { "W391" },
                },
                -- Need to be installed separately
                isort = { enabled = true },
                black = { enabled = true },
                mypy = { enabled = true },
            },
        },
    },
}
