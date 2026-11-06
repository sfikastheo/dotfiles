return {
    setup = function(opts)
        vim.lsp.config("ty", {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("ty")
        vim.lsp.config("ruff", {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("ruff")
    end
}
