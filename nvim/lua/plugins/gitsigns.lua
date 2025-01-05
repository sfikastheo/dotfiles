-- lua/plugins/gitsigns.lua
local gitsigns = require("gitsigns")

local base_opts = { noremap = true, silent = true }

local function set_opts(desc)
    local extended_opts = vim.tbl_extend("force", base_opts, { desc = desc })
    return extended_opts
end

gitsigns.setup({
    signs                        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged                 = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true,
    numhl                        = false,
    linehl                       = false,
    word_diff                    = false,
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false,
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 10,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = "\t  <author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,
    max_file_length              = 40000,
    preview_config               = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },

    on_attach                    = function(bufnr)
        local gs = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk navigation
        map("n", "]h", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "[h", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Previous Git Hunk" })

        -- Actions
        map("n", "<leader>hr", gs.reset_hunk, set_opts("[H]unk [R]eset"))
        map("n", "<leader>hR", gs.reset_buffer, set_opts("[H]unk [R]eset Buffer"))
        map("n", "<leader>hs", gs.stage_hunk, set_opts("[H]unk [S]tage"))
        map("n", "<leader>hS", gs.stage_buffer, set_opts("[H]unk [S]tage Buffer"))
        map("n", "<leader>hu", gs.undo_stage_hunk, set_opts("[H]unk [U]n-stage"))
        map("n", "<leader>hp", gs.preview_hunk, set_opts("[H]unk [P]review"))
        map("n", "<leader>hd", gs.diffthis, set_opts("[H]unk [D]iff"))
        map("n", "<leader>tb", gs.toggle_current_line_blame, set_opts("[T]oggle [B]lame"))
        map('n', '<leader>td', gs.toggle_deleted, set_opts("[T]oggle [D]eleted"))

        map("n", "<leader>hD", function()
            gs.diffthis("~")
        end, { desc = "[H]unk [D]iff [~]" })

        -- Text object for hunks
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "[I]n [H]unk" })
    end,
})
