return {
    'saghen/blink.cmp',
    dependencies = {
        "rafamadriz/friendly-snippets",
        "giuxtaposition/blink-cmp-copilot",
        "Kaiser-Yang/blink-cmp-avante"
    },
    version = "1.*",
    opts = {
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = "mono"
        },
        completion = {
            accept = { dot_repeat = false },
            documentation = { auto_show = false },
        },
        sources = {
            default = { "avante", "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
                avante = {
                    module = "blink-cmp-avante",
                    name = "Avante",
                    opts = {}
                }
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
