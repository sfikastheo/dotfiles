return {
    setup = function(opts)
        vim.lsp.config("jdtls", {
            capabilities = opts.capabilities
        })
        vim.lsp.enable("jdtls")
    end
}
