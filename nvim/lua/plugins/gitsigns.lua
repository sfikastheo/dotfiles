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
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end

                -- Hunk navigation
                map("n", "]c", function()
                    if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gitsigns.nav_hunk('next') end
                end, "Next Git Hunk")
                map("n", "[c", function()
                    if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gitsigns.nav_hunk('prev') end
                end, "Previous Git Hunk")

                -- Actions
                map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Hunk")
                map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Hunk")
                map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Buffer")
                map("n", "<leader>gS", gitsigns.stage_buffer, "Stage Buffer")
                map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Toggle Blame")
                map("n", "<leader>gd", gitsigns.preview_hunk_inline, "Preview Hunk Diff")
                map("n", "<leader>gD", gitsigns.diffthis, "Diff This")
                map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Hunk")


                map("n", "<leader>gu", function() gitsigns.reset_hunk { staged = true } end, "Unstage Hunk")
                map("v", "<leader>gr", function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    "Reset Selection")
                map("v", "<leader>gs", function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    "Stage Selection")

                -- Text objects
                map({ "o", "x" }, "ih", gitsigns.select_hunk, "Inside Hunk")
                map({ "o", "x" }, "ah", gitsigns.select_hunk, "Around Hunk")
            end
        })
    end
}
