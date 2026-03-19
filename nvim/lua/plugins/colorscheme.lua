return {
    {
        "dgox16/oldworld.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            require("oldworld").setup({
                styles = {
                    booleans = { italic = true, bold = true },
                },
                integrations = {
                    telescope = false,
                }
            })
            vim.cmd.colorscheme("oldworld")
        end
    },
    {
        "savq/melange-nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("melange")
        end
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            require("nordic").setup({
                telescope = {
                    style = "classic",
                },
                bright_border = true,
            })
            vim.cmd.colorscheme("nordic")
        end
    },
    {
        "vague-theme/vague.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("vague")
        end
    },
    {
        "f4z3r/gruvbox-material.nvim",
        name = "gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox-material").setup({
                contrast = "hard",
                float = {
                    background_color = nil,
                },
                customize = function(group, options)
                    -- darker bg: replace bg0 (#1d2021) everywhere
                    local darker_bg = "#141617"
                    if options.bg == "#1d2021" then
                        options.bg = darker_bg
                    end
                    -- fix blink & mini.files
                    if group:find("Pmenu") or group:find("Float") then
                        options.bg = nil
                        if group == "PmenuSel" then
                            options.fg = "#ebdbb2"
                            options.bg = "#32302f"
                        end
                    end
                    return options
                end,
            })
            vim.cmd.colorscheme("gruvbox-material")
        end
    },
    {
        "wtfox/jellybeans.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            flat_ui = false,
            on_colors = function(c)
                c.background = "#f7dfc5"
            end,
        },
        config = function(_, opts)
            require("jellybeans").setup(opts)
            vim.cmd.colorscheme("jellybeans-light")
        end
    }
}
