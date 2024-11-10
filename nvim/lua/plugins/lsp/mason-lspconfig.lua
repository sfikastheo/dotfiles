-- lua/plugins/mason-lspconfig.lua
require("mason-lspconfig").setup({
    -- Install LSPs that are setup via lspconfig
    automatic_installation = false,

    -- Install following LSPs:
    ensure_installed = {
        "bashls",
        "clangd",
        "html",
        "ts_ls",
        "lua_ls",
        "pylsp",
        "gopls",
        "rust_analyzer",
    },
})
