-- lua/plugins/lsp/init.lua
local lspconfig = require("lspconfig")

-- workaround
-- Suppress specific rust-analyzer errors
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

-- Utility function for common setup tasks
local on_attach = function(_, bufnr)
    local set = vim.keymap.set

    -- LSP Key mappings
    set("n", "gh", vim.lsp.buf.hover, { desc = "[G]o to [H]Hover Docs", buffer = bufnr })
    set("n", "gH", vim.lsp.buf.signature_help, { desc = "[G]o to [S]ignature help", buffer = bufnr })
    set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = bufnr })
    set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration", buffer = bufnr })
    set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementation", buffer = bufnr })
    set("n", "go", vim.lsp.buf.type_definition, { desc = "[G]o to type definition", buffer = bufnr })
    set("n", "gI", vim.lsp.buf.incoming_calls, { desc = "[G]o to [I]ncoming calls", buffer = bufnr })
    set("n", "gO", vim.lsp.buf.outgoing_calls, { desc = "[G]o to [O]utgoing calls", buffer = bufnr })

    set("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences", buffer = bufnr })
    set("n", "gR", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
    set("n", "gc", vim.lsp.buf.code_action, { desc = "[G]o to [C]ode Actions", buffer = bufnr })
    set("n", "g=", vim.lsp.buf.format, { desc = "Format document", buffer = bufnr })

    set("n", "gl", vim.diagnostic.open_float, { desc = "[G]o to [L]ine Diagnostics", buffer = bufnr })
    set("n", "gL", vim.diagnostic.setloclist, { desc = "Send Diagnostics to [L]oclist", buffer = bufnr })
    set("n", "gQ", vim.diagnostic.setqflist, { desc = "Send Diagnostics to [Q]uickfix", buffer = bufnr })
    set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", buffer = bufnr })
    set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = bufnr })
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
