-- lua/plugins/flash.lua
local flash = require("flash")

require("flash").setup({
    -- labels = "asdfghjklqwertyuiopzxcvbnm",
    labels = "arstgmneiqwfpbjoluyzxcdvkh",
    search = {
        multi_window = true,
        forward = true,
        wrap = true,  -- bidirectional search
        mode = "exact",
        incremental = true, -- behave like `incsearch`
        exclude = {
            "notify",
            "cmp_menu",
            "noice",
            "flash_prompt",
            function(win)
                -- exclude non-focusable windows
                return not vim.api.nvim_win_get_config(win).focusable
            end,
        },
        max_length = false,
    },
    jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
        nohlsearch = true,
        autojump = false,
        inclusive = nil,
        offset = nil,
    },
    label = {
        uppercase = true,
        exclude = "",
        current = true,
        after = true,
        before = false,
        style = "overlay",
        reuse = "lowercase",
        distance = true,
        min_pattern_length = 0,
        rainbow = {
            enabled = false,
            shade = 4,
        },
        format = function(opts)
            return { { opts.match.label, opts.hl_group } }
        end,
    },
    highlight = {
        backdrop = false,
        matches = true,
        priority = 5000,
        groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            backdrop = "FlashBackdrop",
            label = "FlashLabel",
        },
    },
    action = nil, -- initial pattern to use when opening flash
    pattern = "",
    continue = false,
    modes = {
        -- a regular search with `/` or `?`
        search = {
            enabled = true,
            highlight = { backdrop = false },
            jump = { history = true, register = true, nohlsearch = true },
            search = {},
        },
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
            enabled = false,
        },
        treesitter = {
            -- labels = "abcdefghijklmnopqrstuvwxyz",
            labels = "arstgmneiqwfpbjoluyzxcdvkh",
            jump = { pos = "range", autojump = false },
            search = { incremental = false },
            label = { before = true, after = true, style = "inline" },
            highlight = {
                backdrop = false,
                matches = false,
            },
        },
        treesitter_search = {
            jump = { pos = "range" },
            search = { multi_window = true, wrap = true, incremental = false },
            remote_op = { restore = true },
            label = { before = true, after = true, style = "inline" },
        },
        remote = {
            remote_op = { restore = true, motion = true },
        },
    },
    -- options for the floating window that shows the prompt,
    prompt = {
        enabled = true,
        prefix = { { " Flash: ", "FlashPromptIcon" } },
        win_config = {
            relative = "editor",
            width = 1, -- <=1: percentage of the editor width
            height = 1,
            row = -1, -- <0: offset from the bottom
            col = 1, -- <0: offset from the right
            zindex = 1000,
        },
    },
    remote_op = {
        restore = false,
        motion = false,
    },
})

-- Keybindings:
local set = vim.keymap.set
local base_opts = { noremap = true, silent = true }

local function set_opts(desc)
    local extended_opts = vim.tbl_extend("force", base_opts, { desc = desc })
    return extended_opts
end

set({"n", "x"}, "<leader>ft", function() flash.jump() end, set_opts("[F]lash [T]o"))
set({"n", "x"}, "<leader>fs", function() flash.treesitter() end, set_opts("[F]lash [S]elect"))
