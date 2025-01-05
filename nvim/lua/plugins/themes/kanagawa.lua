-- lua/plugins/themes/kanagawa.lua

require("kanagawa-paper").setup({
    undercurl = true,
    transparent = false,
    gutter = false,
    -- background for diagnostic virtual text
    diag_background = true,
    dim_inactive = true,
    terminal_colors = true,
    cache = false,

    styles = {
        comment = { italic = true },
        functions = { italic = false },
        keyword = { italic = false, bold = false },
        statement = { italic = false, bold = false },
        type = { italic = false },
    },
    -- override default palette and theme colors
    colors = {
        palette = {},
        theme = {
            ink = {},
            canvas = {},
        },
    },
    -- adjust overall color balance for each theme [-1, 1]
    color_offset = {
        ink = { brightness = 0, saturation = 0 },
        canvas = { brightness = 0, saturation = 0 },
    },
    -- override highlight groups
    overrides = function(colors)
        return {}
    end,

    -- uses lazy.nvim, if installed, to automatically enable needed plugins
    auto_plugins = true,
    -- enable highlights for all plugins (disabled if using lazy.nvim)
    all_plugins = package.loaded.lazy == nil,
    -- manually enable/disable individual plugins.
    -- check the `groups/plugins` directory for the exact names
    plugins = {
        -- examples:
        -- rainbow_delimiters = true
        -- which_key = false
    },

    -- enable integrations with other applications
    integrations = {
        -- automatically set wezterm theme to match the current neovim theme
        wezterm = {
            enabled = false,
            -- neovim will write the theme name to this file
            -- wezterm will read from this file to know which theme to use
            path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme",
        },
    },
})

vim.cmd.colorscheme("kanagawa-paper")

{
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("plugins.themes.kanagawa")
    end,
}
