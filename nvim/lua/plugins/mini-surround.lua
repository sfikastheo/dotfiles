-- lua/plugins/mini-surround.lua

local mini_surround = require("mini.surround")

mini_surround.setup({
    custom_surroundings = nil,
    highlight_duration = nil,

    mappings = {
        add = "sa",
        delete = "ds",
        replace = "cs",
    },

    -- Number of lines within which surrounding is searched
    n_lines = 20,
    respect_selection_type = false,
    search_method = "cover",
    silent = false,
})
