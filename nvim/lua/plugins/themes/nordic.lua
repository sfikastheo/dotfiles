-- lua/plugins/nordic.lua

require 'nordic'.setup {
    on_palette = function(palette)
        palette.black0 = '#181818'
        palette.black1 = '#1a1a1a'
        palette.black2 = '#1c1c1c'
        palette.gray0 = '#1e1e1e'
        palette.gray1 = '#2e2e2e'
        palette.gray2 = '#3e3e3e'
        palette.gray3 = '#4e4e4e'
        palette.gray4 = '#7e7e7e'
        return palette
    end,
    bold_keywords = false,
    italic_comments = true,
    transparent = {
        bg = false,
        float = false,
    },
    bright_border = false,
    reduced_blue = true,
    swap_backgrounds = false,
    on_highlight = function(highlights, palette)
        highlights.Visual = { bg = palette.gray1 }
        highlights.VisualNOS = { bg = palette.gray2 }
        highlights.CursorLine = { bg = palette.black1 }
        highlights.FloatBorder = { fg = palette.gray4 }
    end,
    cursorline = {
        bold = false,
        bold_number = true,
        theme = 'dark',
        blend = 0.85,
    },
    telescope = {
        style = 'classic',
    },
}

vim.cmd.colorscheme("nordic")

-- {
--     "AlexvZyl/nordic.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("plugins.themes.nordic")
--     end,
-- }
