return {
    'saghen/blink.cmp',
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
        enabled = function()
            return not vim.tbl_contains({ "AgenticInput" }, vim.bo.filetype)
        end,
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = "mono"
        },
        completion = {
            accept = { dot_repeat = false },
            documentation = { auto_show = false },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {},
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
