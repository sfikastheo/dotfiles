-- lua/plugins/mini-indentscope.lua

local mini_indent = require("mini.indentscope")

mini_indent.setup({
    mappings = {
        object_scope = "",
        object_scope_with_border = "",
        goto_top = "",
        goto_bottom = "",
    },

    -- Options which control scope computation
    options = {
        border = "both",
        indent_at_cursor = true,
        try_as_border = false,
    },

    -- Which character to use for drawing scope indicator
    symbol = "│",
})
