return {
    "carlos-algms/agentic.nvim",
    keys = {
        -- Toggle and sessions
        { "<leader>at", function() require("agentic").toggle() end,           mode = { "n", "v", "i" }, desc = "Toggle Agentic" },
        { "<leader>an", function() require("agentic").new_session() end,      mode = { "n", "v", "i" }, desc = "New Session" },
        { "<leader>ar", function() require("agentic").restore_session() end,  mode = { "n", "v", "i" }, desc = "Restore Session" },

        -- Context
        { "<leader>af", function() require("agentic").add_file() end,                       desc = "Add File" },
        { "<leader>as", function() require("agentic").add_selection() end,                  mode = "v", desc = "Add Selection" },
        { "<leader>ad", function() require("agentic").add_current_line_diagnostics() end,   desc = "Add Line Diagnostic" },
        { "<leader>aD", function() require("agentic").add_buffer_diagnostics() end,         desc = "Add All Diagnostics" },

        -- Control
        { "<leader>ax", function() require("agentic").stop_generation() end, desc = "Stop Generation" },
        { "<leader>ap", function() require("agentic").switch_provider() end, desc = "Switch Provider" },
    },
    opts = {
        provider = "claude-agent-acp",
        windows = {
            position = "right",
            width = "40%",
        },
        keymaps = {
            diff_preview = {
                next_hunk = "]a",
                prev_hunk = "[a",
            },
        },
        diff_preview = {
            enabled = true,
            layout = "inline",
            center_on_navigate_hunks = true,
        },
    },
}
