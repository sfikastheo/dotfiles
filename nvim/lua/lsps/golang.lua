return {
    setup = function(opts)
        vim.lsp.config('gopls', {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("gopls")
    end
}
