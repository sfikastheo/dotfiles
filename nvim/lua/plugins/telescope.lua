-- lua/plugins/telescope.lua

local telescope = require("telescope")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

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
local function with(theme_name, cwd_path)
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
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!**/.git/*",
        },
        mappings = {
            i = {
                ["<C-c>"] = actions.close,
                ["<C-w>t"] = actions.select_tab,
                ["<C-w>v"] = actions.select_vertical,
                ["<C-w>s"] = actions.select_horizontal,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-e>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.results_scrolling_left,
                ["<C-k>"] = actions.results_scrolling_right,
            },
            n = {
                ["<C-c>"] = actions.close,
                ["<C-w>t"] = actions.select_tab,
                ["<C-w>v"] = actions.select_vertical,
                ["<C-w>s"] = actions.select_horizontal,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-e>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.results_scrolling_left,
                ["<C-k>"] = actions.results_scrolling_right,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob",
                "!**/.git/*"
            }
        },
        diagnostics = { layout_strategy = "vertical" },
        registers = { layout_strategy = "vertical" },
    },
    extensions = {
        ["ui-select"] = {
            themes.get_dropdown({
                layout_config = { width = 0.8 }
            })
        },
    },
})

-- Keybindings for Telescope without which-key
local set = vim.keymap.set
local base_opts = { noremap = true, silent = true }

local function set_opts(desc)
    local extended_opts = vim.tbl_extend("force", base_opts, { desc = desc })
    return extended_opts
end

-- General bindings
set("n", "<leader>fl", builtin.loclist, set_opts("[F]ind [L]ocation list"))
set("n", "<leader>fR", builtin.registers, set_opts("[F]ind [R]egisters"))
set("n", "<leader>fj", builtin.jumplist, set_opts("[F]ind [J]ump list"))
set("n", "<leader>fc", builtin.commands, set_opts("[F]ind [C]ommands"))
set("n", "<leader>fk", builtin.keymaps, set_opts("[F]ind [K]eymaps"))
set("n", "<leader>fh", builtin.help_tags, set_opts("[F]ind [H]elp"))
set("n", "<leader>fm", builtin.marks, set_opts("[F]ind [M]arks"))

set("n", "<leader>fF", function() builtin.find_files(with("default", vim.fn.getcwd())) end,
    set_opts("[F]ind [F]iles in CWD"))
set("n", "<leader>fG", function() builtin.live_grep(with("default", vim.fn.getcwd())) end,
    set_opts("[F]ind by [G]rep in CWD"))
set("n", "<leader>fq", function() builtin.quickfix(theme("dropdown")) end, set_opts("[F]ind [Q]uickfix list"))
set("n", "<leader>ff", function() builtin.find_files(with("default")) end, set_opts("[F]ind [F]iles"))
set("n", "<leader>fg", function() builtin.live_grep(with("default")) end, set_opts("[F]ind by [G]rep"))
set("n", "<leader>.", function() builtin.find_files(with("ivy")) end, set_opts("Find Files"))
set("n", "<leader>,", function() builtin.buffers(theme("ivy")) end, set_opts("Find Buffers"))

-- LSP-related
set("n", "<leader>fi", builtin.lsp_incoming_calls, set_opts("[F]ind [I]ncoming calls"))
set("n", "<leader>fo", builtin.lsp_outgoing_calls, set_opts("[F]ind [O]utgoing calls"))
set("n", "<leader>fr", builtin.lsp_references, set_opts("[F]ind [R]eferences"))
set("n", "<leader>fd", builtin.diagnostics, set_opts("[F]ind [D]iagnostics"))

-- Load extensions
telescope.load_extension("ui-select")
