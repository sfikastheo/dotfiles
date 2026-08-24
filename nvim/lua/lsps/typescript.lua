return {
    setup = function(opts)
        vim.lsp.config('ts_ls', {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("ts_ls")
    end
}
