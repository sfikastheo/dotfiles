return {
    setup = function(opts)
        vim.lsp.config('clangd', {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("clangd")
    end
}
