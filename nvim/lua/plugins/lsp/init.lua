-- lua/plugins/lsp/init.lua
local lspconfig = require("lspconfig")

-- Utility function for common setup tasks
local on_attach = function(_, bufnr)
    local set = vim.keymap.set

    -- LSP Key mappings
    set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover help", buffer = bufnr })
    set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })

    set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = bufnr })
    set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration", buffer = bufnr })
    set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementation", buffer = bufnr })
    set("n", "gy", vim.lsp.buf.type_definition, { desc = "[G]o to type definition", buffer = bufnr })
    set("n", "gI", vim.lsp.buf.incoming_calls, { desc = "[G]o to [I]ncoming calls", buffer = bufnr })
    set("n", "gO", vim.lsp.buf.outgoing_calls, { desc = "[G]o to [O]utgoing calls", buffer = bufnr })

    set("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences", buffer = bufnr })
    set("n", "ga", vim.lsp.buf.code_action, { desc = "[G]o to code [A]ctions", buffer = bufnr })

    set("n", "gl", vim.diagnostic.open_float, { desc = "[G]o to [L]ine Diagnostics", buffer = bufnr })
    set("n", "gL", vim.diagnostic.setloclist, { desc = "Send Diagnostics to [L]oclist", buffer = bufnr })
    set("n", "gQ", vim.diagnostic.setqflist, { desc = "Send Diagnostics to [Q]uickfix", buffer = bufnr })
    set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", buffer = bufnr })
    set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = bufnr })
end

local servers = {
    lua_ls = {},
    gopls = {},
    clangd = require("plugins.lsp.clangd"),
    pylsp = require("plugins.lsp.pylsp"),
    rust_analyzer = require("plugins.lsp.rust_analyzer"),
}

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
    virtual_text = false, -- Disabled due to inline-diagnostic plugin
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

-- Function to toggle Bash LSP
function ToggleBashLanguageServer()
    local clients = vim.lsp.get_active_clients()
    local bashls_id = nil

    -- Check if bashls is running
    for _, client in ipairs(clients) do
        if client.name == "bashls" then
            bashls_id = client.id
            break
        end
    end

    if bashls_id then
        vim.lsp.stop_client(bashls_id)
        vim.notify("Bash LSP disabled", vim.log.levels.INFO)
    else
        lspconfig.bashls.setup({
            on_attach = function()
                vim.notify("Bash LSP Enabled", vim.log.levels.INFO)
            end,
        })
    end
end

-- Define `:Ebash` command to toggle Bash LSP
vim.api.nvim_create_user_command("Tbashls", ToggleBashLanguageServer, { desc = "[T]oggle [B]ash [L]SP" })
