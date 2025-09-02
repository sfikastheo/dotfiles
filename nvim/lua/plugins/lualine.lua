return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            "yavorski/lualine-macro-recording.nvim"
        },
        opts = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            winbar = {},
            tabline = {},
            ignore_focus = {},
            inactive_winbar = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        shorting_target = 40,
                    },
                    "macro_recording",
                },
                lualine_x = { "selectioncount", "searchcount", "encoding", "filetype" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        shorting_target = 40,
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            }
        }
    }
}
