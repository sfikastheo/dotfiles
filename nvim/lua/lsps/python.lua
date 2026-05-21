return {
  setup = function(opts)
    vim.lsp.enable("pyright")
    vim.lsp.config("pyright", {
      capabilities = opts.capabilities
    })
    vim.lsp.enable("ruff")
    vim.lsp.config("ruff", {
      capabilities = opts.capabilities
    })
  end
}
