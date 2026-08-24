return {
    setup = function(opts)
        vim.lsp.config('nil_ls', {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("nil_ls")
    end
}
