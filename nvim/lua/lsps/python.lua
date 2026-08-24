return {
    setup = function(opts)
        vim.lsp.config("pyright", {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("pyright")
        vim.lsp.config("ruff", {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("ruff")
    end
}
