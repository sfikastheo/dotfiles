-- lua/plugins/nordic.lua

local sidebar_bg = '#1a1a1a'

require 'nordic'.setup {
    on_palette = function(palette)
        palette.black0 = '#121212'
        palette.black1 = '#141414'
        palette.black2 = '#161616'
        palette.gray0 = '#1e1e1e'
        palette.gray1 = '#424242'
        palette.gray2 = '#525252'
        palette.gray3 = '#626262'
        palette.gray4 = '#727272'
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
    -- Override the styling of any highlight group.
    on_highlight = function(highlights, palette)
        -- Overrides similar to what you did with `override`
        highlights.Visual = { bg = '#424242' }
        highlights.VisualNOS = { bg = '#424242' }
        highlights.CursorLine = { bg = '#161616' }
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

vim.cmd.colorscheme 'nordic'
