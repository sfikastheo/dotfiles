local lspconfig = require("lspconfig")

-- Set up LSPs + keymaps
local set = vim.keymap.set
local base_opts = { noremap = true, silent = true }
local function set_opts(desc, bufnr)
    return vim.tbl_extend("force", base_opts, { desc = desc, buffer = bufnr })
end

local on_attach = function(_, bufnr)
    set("n", "<leader>j", vim.diagnostic.open_float, set_opts("Hover Diagnostics", bufnr))
    set("n", "<leader>r", vim.lsp.buf.references, set_opts("Go to References", bufnr))
    set("n", "<leader>k", vim.lsp.buf.hover, set_opts("Hover help", bufnr))

    set("n", "gq", vim.diagnostic.setqflist, set_opts("Send Diagnostics to Quickfix", bufnr))
    set("n", "g.", vim.lsp.buf.code_action, set_opts("Code Actions", bufnr))
    set("n", "gD", vim.lsp.buf.declaration, set_opts("Go to Declaration", bufnr))
    set("n", "[d", vim.diagnostic.goto_prev, set_opts("Previous Diagnostic", bufnr))
    set("n", "]d", vim.diagnostic.goto_next, set_opts("Next Diagnostic", bufnr))
end

local servers = {
    ruff = {},
    gopls = {},
    ts_ls = {},
    lua_ls = {},
    pylsp = require("plugins.lsp.pylsp"),
    clangd = require("plugins.lsp.clangd"),
    rust_analyzer = require("plugins.lsp.rust_analyzer"),
}

-- Add borders to floating windows
local orig_open = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = vim.tbl_extend("force", opts or {}, { border = "rounded" })
    return orig_open(contents, syntax, opts, ...)
end

-- Setup LSP servers
for name, config in pairs(servers) do
    config.on_attach = on_attach
    lspconfig[name].setup(config)
end

-- Beautiful diagnostic signs
local signs = { Error = "●", Warn = "▲", Hint = "◆", Info = "●" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnostic settings
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        focusable = true,
        border = "rounded",
        source = "always",
        prefix = "",
        style = "minimal",
    },
})

-- Autocommand to enable inlay hints (if supported)
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

-- Command to format the entire document
vim.api.nvim_create_user_command(
    "Fmt",
    function()
        vim.lsp.buf.format({ async = true })
    end,
    { desc = "Format document" }
)
