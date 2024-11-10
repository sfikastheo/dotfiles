-- lua/plugins/gitsigns.lua
local gitsigns = require("gitsigns")

gitsigns.setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 10,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = "\t  <author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },

    on_attach = function(bufnr)
        local gs = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk navigation
        map("n", "]g", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "[g", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Previous Git Hunk" })

        -- Actions
        map("n", "<leader>gr", gs.reset_hunk)
        map("n", "<leader>gR", gs.reset_buffer)
        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Git Hunk" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Git Hunk" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Git Hunk" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Git Diff" })
        map("n", "<leader>gb", gs.toggle_current_line_blame)

        map("n", "<leader>gD", function()
            gs.diffthis("~")
        end, { desc = "Git Diff ~" })

        -- Text object for hunks
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Git Hunk" })
    end,
})
