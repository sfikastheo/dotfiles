-- lua/plugins/avante.lua

local avante = require("avante")

avante.setup({
    provider = "claude", -- Recommend using Claude
    auto_suggestions_provider = "copilot",
    claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20240620",
        temperature = 0,
        max_tokens = 4096,
    },
    behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
    },
    mappings = {
        diff = {
            ours = "co",
            theirs = "ct",
            all_theirs = "ca",
            both = "cb",
            cursor = "cc",
            next = "]s",
            prev = "[s",
            autojump = true,
        },
        suggestion = {
            accept = "<leader>sa",
            next = "<leader>sj",
            prev = "<leader>sk",
            dismiss = "<leader>sd",
        },
        jump = {
            next = "]]",
            prev = "[[",
        },
        submit = {
            normal = "<CR>",
            insert = "<C-s>",
        },
        sidebar = {
            switch_windows = "<Tab>",
            reverse_switch_windows = "<S-Tab>",
        },
    },
    hints = { enabled = false },
    windows = {
        position = "right",
        wrap = true,
        width = 40,
        sidebar_header = {
            align = "center",
            rounded = true,
        },
    },
    highlights = {
        diff = {
            current = "DiffText",
            incoming = "DiffAdd",
        },
    },
    diff = {
        autojump = true,
        list_opener = "copen",
    },
})
