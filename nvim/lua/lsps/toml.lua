return {
    setup = function(opts)
        vim.lsp.config('taplo', {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("taplo")
    end
}
