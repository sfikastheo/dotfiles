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
                local function map(mode, lhs, rhs, desc, extra)
                    local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
                    opts = vim.tbl_extend("force", opts, extra or {})
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Hunk Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>gs', gitsigns.stage_hunk)
                map('n', '<leader>gr', gitsigns.reset_hunk)

                map('v', '<leader>gs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>gr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>gS', gitsigns.stage_buffer)
                map('n', '<leader>gR', gitsigns.reset_buffer)
                map('n', '<leader>gp', gitsigns.preview_hunk)
                map('n', '<leader>gi', gitsigns.preview_hunk_inline)

                map('n', '<leader>gb', function()
                    gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>gd', gitsigns.diffthis)

                map('n', '<leader>gD', function()
                    gitsigns.diffthis('~')
                end)

                map('n', '<leader>gQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>gq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>gb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>gw', gitsigns.toggle_word_diff)

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
            end
        })
    end
}
