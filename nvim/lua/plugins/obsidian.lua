return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    cmd = "Obsidian",
    opts = {
        workspaces = {
            {
                name = "vault",
                path = "~/Projects/vault",
            },
            {
                name = "no-vault",
                path = function()
                    return assert(vim.fn.getcwd())
                end,
                overrides = {
                    notes_subdir = vim.NIL,
                    new_notes_location = vim.NIL,
                    daily_notes = {
                        folder = vim.NIL,
                    },
                    templates = {
                        folder = vim.NIL,
                    },
                },
            },
        },
        legacy_commands = false,
        daily_notes = {
            folder = "journal",
            date_format = "%Y-%m-%d-%a",
            template = "daily",
        },
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        checkbox = {
            order = { " ", "~", "!", ">", "x" },
        },
        ui = { enable = false },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)
    end
}
