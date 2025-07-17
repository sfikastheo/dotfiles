return {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                    ignore = { "W391" },
                },
                mypy = { enabled = true },
            },
        },
    },
}
