-- lua/plugins/nordic.lua

local sidebar_bg = '#1a1a1a'

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
        highlights.NvimTreeCursorLine = { bg = '#242424' }
        highlights.NvimTreeNormal = { bg = sidebar_bg }
        highlights.NvimTreeNormalNC = { bg = sidebar_bg }
    end,
    cursorline = {
        bold = false,
        bold_number = true,
        theme = 'dark',
        blend = 0.85,
    },
    noice = {
        style = 'classic',
    },
    telescope = {
        style = 'classic',
    },
    leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
    },
    ts_context = {
        dark_background = true,
    }
}

vim.cmd("colorscheme nordic")
