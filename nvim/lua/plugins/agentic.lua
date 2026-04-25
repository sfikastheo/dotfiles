return {
    "carlos-algms/agentic.nvim",
    keys = {
        -- Toggle and sessions
        { "<leader>at", function() require("agentic").toggle() end,                       mode = { "n", "v" }, desc = "Toggle Agentic" },
        { "<leader>an", function() require("agentic").new_session() end,                  mode = { "n", "v" }, desc = "New Session" },
        { "<leader>ar", function() require("agentic").restore_session() end,              mode = { "n", "v" }, desc = "Restore Session" },

        -- Context
        { "<leader>af", function() require("agentic").add_file() end,                     mode = { "n" },      desc = "Add File" },
        { "<leader>as", function() require("agentic").add_selection() end,                mode = { "v" },      desc = "Add Selection" },
        { "<leader>ad", function() require("agentic").add_current_line_diagnostics() end, mode = { "n" },      desc = "Add Line Diagnostic" },
        { "<leader>aD", function() require("agentic").add_buffer_diagnostics() end,       mode = { "n" },      desc = "Add All Diagnostics" },

        -- Control
        { "<leader>ax", function() require("agentic").stop_generation() end,              mode = { "n" },      desc = "Stop Generation" },
    },
    opts = {
        provider = "claude-agent-acp",
        windows = {
            position = "right",
            width = "40%",
        },
        keymaps = {
            widget = {
                change_thought_level = "<leader>aw",
                switch_model = "<leader>af",
                switch_provider = "<leader>ap",
            },
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
