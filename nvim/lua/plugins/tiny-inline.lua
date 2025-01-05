-- lua/plugins/tiny-inline.lua

local tiny = require("tiny-inline-diagnostic")

tiny.setup({
    preset = "powerline",
    hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "None",
    },
    options = {
        show_source = true,

        use_icons_from_diagnostic = false,

        -- Add messages to the diagnostic when multilines is enabled
        add_messages = true,
        throttle = 10,
        softwrap = 40,
        multiple_diag_under_cursor = true,

        multilines = {
            enabled = true,
            always_show = true,
        },

        show_all_diags_on_cursorline = true,
        enable_on_insert = false,

        overflow = {
            mode = "wrap",
        },

        format = nil,

        break_line = {
            enabled = false,
            after = 30,
        },

        virt_texts = {
            priority = 2048,
        },

        -- Filter by severity.
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },
        overwrite_events = nil,
    },
})
