-- lua/plugins/mini-files.lua

local set = vim.keymap.set
local mf = require("mini.files")


local base_opts = { noremap = true, silent = true }
local function set_opts(desc)
  return vim.tbl_extend("force", base_opts, { desc = desc })
end

mf.setup({
    content = {
        filter = nil,
        prefix = nil,
        sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
        close       = '<C-c>',
        go_in       = 'l',
        go_in_plus  = '<CR>',
        go_out      = 'h',
        go_out_plus = 'H',
        mark_goto   = "mg",
        mark_set    = 'ms',
        reset       = '<DEL>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '>',
        trim_right  = '<',
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

set("n", "<leader>op", function() mf.open() end, set_opts("Mini-files"))
