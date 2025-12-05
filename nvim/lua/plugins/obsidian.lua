return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Projects/vault",
            },
        },
        legacy_commands = false,
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        ui = {
            -- use `render-markdown` instead
            checkboxes = {
                order = { " ", "~", "!", ">", "x" },
            },
            bullets = {},
            external_link_icon = {},
        },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)
    end
}
