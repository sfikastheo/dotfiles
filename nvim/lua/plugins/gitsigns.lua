return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")

        local sign_chars = {
            add          = { text = "┃" },
            change       = { text = "┃" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
        }

        gitsigns.setup({
            signs                        = sign_chars,
            signs_staged                 = sign_chars,
            signs_staged_enable          = true,
            signcolumn                   = true,
            numhl                        = false,
            linehl                       = false,
            word_diff                    = false,
            watch_gitdir                 = { follow_files = true },
            auto_attach                  = true,
            attach_to_untracked          = false,

            current_line_blame           = false,
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = "eol",
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
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },

            on_attach                    = function(bufnr)
                local gs = require("gitsigns")

                local maps = {
                    -- Hunk navigation (expr)
                    { "n", "]h", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(gs.next_hunk)
                        return "<Ignore>"
                    end, "Next Git Hunk", { expr = true } },

                    { "n", "[h", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(gs.prev_hunk)
                        return "<Ignore>"
                    end, "Previous Git Hunk", { expr = true } },

                    -- Actions
                    { "n",          "<leader>hr", gs.reset_hunk,                    "Hunk Reset" },
                    { "n",          "<leader>hR", gs.reset_buffer,                  "Hunk Reset Buffer" },
                    { "n",          "<leader>hs", gs.stage_hunk,                    "Hunk Stage" },
                    { "n",          "<leader>hS", gs.stage_buffer,                  "Hunk Stage Buffer" },
                    { "n",          "<leader>hu", gs.undo_stage_hunk,               "Hunk Un-stage" },
                    { "n",          "<leader>hp", gs.preview_hunk,                  "Hunk Preview" },
                    { "n",          "<leader>hd", gs.diffthis,                      "Hunk Diff" },
                    { "n",          "<leader>tb", gs.toggle_current_line_blame,     "Toggle Blame" },
                    { "n",          "<leader>td", gs.toggle_deleted,                "Toggle Deleted" },

                    -- Text object
                    { { "o", "x" }, "ih",         ":<C-U>Gitsigns select_hunk<CR>", "Select Inside Hunk" },
                }

                local function opts(desc, extra)
                    local opt = { noremap = true, silent = true, buffer = bufnr, desc = desc }
                    if extra then for k, v in pairs(extra) do opt[k] = v end end
                    return opt
                end

                for _, m in ipairs(maps) do
                    vim.keymap.set(m[1], m[2], m[3], opts(m[4], m[5]))
                end
            end
        })
    end
}
