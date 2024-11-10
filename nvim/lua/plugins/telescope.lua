local telescope = require("telescope")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local wk = require("which-key")

-- Utility function to select Telescope theme
local function theme(theme_name)
    local theme_map = {
        ivy = themes.get_ivy(),
        dropdown = themes.get_dropdown({
            layout_config = {
                width = 0.8,
            },
        }),
        cursor = themes.get_cursor(),
        default = {},
    }
    return theme_map[theme_name]
end

-- Helper function to get git root directory
local function get_git_root()
    if vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true" then
        return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    end
end

-- Function to set dynamic options for Telescope
local function set_opts(theme_name, cwd_path)
    local opts = theme(theme_name)
    opts.cwd = cwd_path or get_git_root() or vim.fn.getcwd()
    return opts
end

-- Telescope setup
telescope.setup({
    defaults = {
        layout_config = {
            width = 0.9,
            height = 0.9,
            horizontal = { preview_width = 0.6 },
            vertical = { preview_height = 0.6 },
        },
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column", "--smart-case", "--hidden", "--glob", "!**/.git/*",
        },
        mappings = {
            i = {
                ["<C-c>"] = actions.close,
                ["<C-w>t"] = actions.select_tab,
                ["<C-w>v"] = actions.select_vertical,
                ["<C-w>s"] = actions.select_horizontal,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-e>"] = actions.move_selection_previous,
            },
            n = {
                ["<C-c>"] = actions.close,
                ["<C-w>t"] = actions.select_tab,
                ["<C-w>v"] = actions.select_vertical,
                ["<C-w>s"] = actions.select_horizontal,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-e>"] = actions.move_selection_previous,
            },
        },
    },
    pickers = {
        find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } },
        diagnostics = { layout_strategy = "vertical" },
        registers = { layout_strategy = "vertical" },
    },
    extensions = {
        ["ui-select"] = { themes.get_dropdown({ layout_config = { width = 0.8 } }) },
    },
})

wk.add({
    mode = "n",
    { "<leader>f",  group = "Telescope" },

    { "<leader>ff", function() builtin.find_files(set_opts("default")) end,                  desc = "Files" },
    { "<leader>fg", function() builtin.live_grep(set_opts("default")) end,                   desc = "Grep" },
    { "<leader>fF", function() builtin.find_files(set_opts("default", vim.fn.getcwd())) end, desc = "Files in CWD" },
    { "<leader>fG", function() builtin.live_grep(set_opts("default", vim.fn.getcwd())) end,  desc = "Grep in CWD" },
    { "<leader>.",  function() builtin.find_files(set_opts("ivy")) end,                      desc = "Files (ivy)" },

    { "<leader>fm", function() builtin.marks(theme("dropdown")) end,                         desc = "Marks" },
    { "<leader>fc", function() builtin.commands(theme("dropdown")) end,                      desc = "Commands" },
    { "<leader>fR", function() builtin.registers(theme("dropdown")) end,                     desc = "Registers" },
    { "<leader>,",  function() builtin.buffers(theme("ivy")) end,                            desc = "Buffers" },

    -- Lists with dropdown theme
    { "<leader>fl", function() builtin.loclist(theme("dropdown")) end,                       desc = "Location list" },
    { "<leader>fj", function() builtin.jumplist(theme("dropdown")) end,                      desc = "Jump list" },
    { "<leader>fq", function() builtin.quickfix(theme("dropdown")) end,                      desc = "Quickfix list" },

    -- LSP-related
    { "<leader>fi", function() builtin.lsp_incoming_calls(theme("dropdown")) end,            desc = "Incoming calls" },
    { "<leader>fo", function() builtin.lsp_outgoing_calls(theme("dropdown")) end,            desc = "Outgoing calls" },
    { "<leader>fr", function() builtin.lsp_references(theme("dropdown")) end,                desc = "References" },
    { "<leader>fd", function() builtin.diagnostics(theme("default")) end,                    desc = "Diagnostics" },
})

-- Load extensions
telescope.load_extension("ui-select")
