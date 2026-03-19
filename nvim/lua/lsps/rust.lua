return {
  setup = function(opts)
    vim.lsp.enable("rust_analyzer")
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = true,
            experimental = { enable = true },
          },
          cargo = {
            allFeatures = true,
            buildScripts = { enable = true },
          },
          check = {
            enable = true,
            command = "check",
          },
          inlayHints = {
            chainingHints = { enable = true },
            parameterHints = { enable = true },
            typeHints = { enable = true },
          },
          procMacro = {
            enable = true,
            ignored = {
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
        }
      },
      capabilities = opts.capabilities,
    })
  end
}
