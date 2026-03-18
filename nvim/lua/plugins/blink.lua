return {
    'saghen/blink.cmp',
    dependencies = {
        "rafamadriz/friendly-snippets",
        "giuxtaposition/blink-cmp-copilot",
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
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
             providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
