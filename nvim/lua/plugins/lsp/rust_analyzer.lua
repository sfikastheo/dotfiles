-- lua/plugins/lsp/rust_analyzer.lua

return {
    ["rust-analyzer"] = {
        cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
        },
    },
}
