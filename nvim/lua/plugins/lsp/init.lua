-- lua/plugins/lsp/init.lua
local lspconfig = require("lspconfig")

-- Utility function for common setup tasks
local on_attach = function(_, bufnr)
    local set = vim.keymap.set

    -- LSP Key mappings
    set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation", buffer = bufnr })
    set("n", "gh", vim.lsp.buf.hover, { desc = "Hover documentation", buffer = bufnr })
    set("n", "gH", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })
    set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
    set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
    set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
    set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = bufnr })
    set("n", "gI", vim.lsp.buf.incoming_calls, { desc = "Incoming calls", buffer = bufnr })
    set("n", "gO", vim.lsp.buf.outgoing_calls, { desc = "Outgoing calls", buffer = bufnr })

    set("n", "gr", vim.lsp.buf.references, { desc = "Find references", buffer = bufnr })
    set("n", "gs", vim.lsp.buf.document_symbol, { desc = "Document symbols", buffer = bufnr })
    set("n", "gS", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbols", buffer = bufnr })
    set("n", "gR", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
    set("n", "gc", vim.lsp.buf.code_action, { desc = "Code actions", buffer = bufnr })
    set("n", "g=", vim.lsp.buf.format, { desc = "Format document", buffer = bufnr })

    set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics", buffer = bufnr })
    set("n", "gL", vim.diagnostic.setloclist, { desc = "Send Diagnostics to Loclist", buffer = bufnr })
    set("n", "gQ", vim.diagnostic.setqflist, { desc = "Send Diagnostics to Quickfix", buffer = bufnr })
    set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = bufnr })
    set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = bufnr })
end

local servers = {
    asm_lsp = {},
    lua_ls = {},
    gopls = {},
    ts_ls = {},
    html = {},
    ocamllsp = {},
    clangd = require("plugins.lsp.clangd"),
    pylsp = require("plugins.lsp.pylsp"),
    rust_analyzer = require("plugins.lsp.rust_analyzer"),
}

for name, config in pairs(servers) do
    config.on_attach = on_attach
    lspconfig[name].setup(config)
end

-- Diagnostic settings
vim.diagnostic.config({
    virtual_text = {},
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        focusable = false,
        border = "rounded",
        source = "always",
        prefix = "● ",
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})
