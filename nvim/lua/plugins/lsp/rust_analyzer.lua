-- lua/plugins/lsp/rust_analyzer.lua

-- rust-analyzer fucks up
local function setup_rust_analyzer_diagnostics()
    for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and (err.code == -32802 or err.code == -32603) then
                return
            end
            return default_diagnostic_handler(err, result, context, config)
        end
    end
end
setup_rust_analyzer_diagnostics()

return {
    cmd = { "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
        },
    },
}
