-- lua/plugins/mini-files.lua
local wk = require("which-key")
local mf = require("mini.files")

mf.setup({
    content = {
        filter = nil,
        prefix = nil,
        sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
        close       = 'q',
        go_in       = 'l',
        go_in_plus  = '<CR>',
        go_out      = 'h',
        go_out_plus = 'H',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<DEL>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
    },

    options = {
        permanent_delete = true,
        use_as_default_explorer = true,
    },

    windows = {
        max_number = 6,
        preview = false,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
    },
})

wk.add({
    mode = { "n" },
    { "<leader>op", function() mf.open() end, desc = "Mini-Files" },
})
