-- lua/plugins/neogit.lua

local neogit = require("neogit")

local set = vim.keymap.set
local default_set = { noremap = true, silent = true }

neogit.setup({
    disable_hint = false,
    disable_context_highlighting = false,
    disable_signs = false,
    disable_insert_on_commit = "auto",
    filewatcher = {
        interval = 1000,
        enabled = true,
    },
    graph_style = "unicode",
    git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
    },
    remember_settings = true,
    use_per_project_settings = true,
    highlight = {
        italic = true,
        bold = true,
        underline = true,
    },
    use_default_keymaps = true,
    auto_refresh = true,
    sort_branches = "-committerdate",
    kind = "tab",
    disable_line_numbers = true,
    console_timeout = 2000,
    auto_show_console = true,
})

set("n", "<leader>og", "<cmd>Neogit<cr>", default_set)
