-- lua/plugins/copilot.lua

local copilot = require("copilot")

copilot.setup({
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-x>"
        },
        layout = {
            position = "right",
            ratio = 0.4
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
            accept = "<C-y>",
            next = "<C-n>",
            prev = "<C-p>",
            accept_line = "<C-l>",
            dismiss = "<C-c>"
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
    },
    copilot_node_command = 'node',
    server_opts_overrides = {},
})
