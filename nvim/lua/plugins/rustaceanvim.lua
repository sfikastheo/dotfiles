return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    init = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function(_, bufnr)
                    local function opts(desc)
                        return { noremap = true, silent = true, desc = desc, buffer = bufnr }
                    end
                    local maps = {
                        -- ovewritting default nvim actions
                        { "n", "<leader>k",  function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, "Hover Actions" },
                        { "n", "g.",         function() vim.cmd.RustLsp('codeAction') end,           "Code Action" },
                        { "n", "J",          function() vim.cmd.RustLsp('joinLines') end,            "Join Lines" },
                        -- additional rustaceanvim nvim actions
                        { "n", "<leader>rm", function() vim.cmd.RustLsp('expandMacro') end,          "Rust Expand Macro" },
                        { "n", "<leader>re", function() vim.cmd.RustLsp('explainError') end,         "Rust Explain Error" },
                        { "n", "<leader>rp", function() vim.cmd.RustLsp('parentModule') end,         "Rust Open Parent Module" },
                        { "n", "<leader>rC", function() vim.cmd.RustLsp('openCargo') end,            "Rust Open Cargo.toml" },
                        { "n", "<leader>rD", function() vim.cmd.RustLsp('openDocs') end,             "Rust Open Docs" },
                    }
                    for _, m in ipairs(maps) do
                        vim.keymap.set(m[1], m[2], m[3], opts(m[4]))
                    end

                    -- there is a bug with the setup in which after
                    -- RustLsp('renderDiagnostic'), mode changes to insert
                    vim.keymap.set("n", "<leader>rd", function()
                        vim.cmd.RustLsp('renderDiagnostic')
                        vim.schedule(function() vim.cmd('stopinsert') end)
                    end, opts("Rust Open Diagnostic"))
                end,
                default_settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = true,
                            experimental = { enable = true },
                        },
                        cargo = {
                            allFeatures = true,
                            buildScripts = { enable = true },
                            loadOutDirsFromCheck = true,
                        },
                        check = {
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                        checkOnSave = true,
                        procMacro = {
                            enable = true,
                            attributes = { enable = true },
                        },
                    }
                },
                flags = {
                    debounce_text_changes = 150,
                },
            },
        }
    end,
}
