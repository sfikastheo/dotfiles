-- lua/plugins/copilot.lua

local copilot = require("copilot")

copilot.setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
            accept = "<C-CR>",
            next = "<C-j>",
            prev = "<C-k>",
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
