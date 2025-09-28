return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        local neogit = require("neogit")
        neogit.setup({
            graph_style = "unicode",
            kind = "floating",
            floating = {
                relative = "editor",
                width = 1,
                height = 1,
                style = "minimal",
                border = "rounded",
            },
            mappings = {
                rebase_editor = {
                    ["gk"] = nil,
                    ["gj"] = nil,
                    ["gn"] = "MoveUp",
                    ["ge"] = "MoveDown",
                },
                finder = {
                    ["<c-e>"] = "Previous",
                },
                status = {
                    ["k"] = nil,
                    ["j"] = nil,
                    ["e"] = "MoveUp",
                    ["n"] = "MoveDown",
                    ["<c-e>"] = "PreviousSection",
                },
            },
        })
    end
}
