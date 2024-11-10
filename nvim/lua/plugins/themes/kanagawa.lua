-- lua/plugins/kanagawa.lua

--	{
--		"rebelot/kanagawa.nvim",
--		lazy = false,
--		priority = 1000,
--		config = function()
--			require("plugins.kanagawa")
--		end,
--	},
--

require("kanagawa").setup({
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    colors = {
        palette = {
            dragonBlack0 = "#181717",
            dragonBlack1 = "#1d1d1a",
            dragonBlack2 = "#272624",
            dragonBlack3 = "#232121",
        },
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = { bg_gutter = "none" },
            },
        },
    },
    overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
    end,
})

-- Comes in 3 versions: wave, lotus, dragon
vim.cmd("colorscheme kanagawa-dragon")
