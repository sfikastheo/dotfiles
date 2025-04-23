-- lua/plugins/copilot.lua

local copilot = require("copilot")

copilot.setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 250,
        keymap = {
            accept = "<C-y>",
            next = "<C-n>",
            prev = "<C-e>",
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
