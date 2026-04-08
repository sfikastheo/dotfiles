return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },

        opts = function()
            local actions = require("telescope.actions")
            local common = {
                ["<C-c>"]  = actions.close,
                ["<C-w>t"] = actions.select_tab,
                ["<C-w>v"] = actions.select_vertical,
                ["<C-w>s"] = actions.select_horizontal,
                ["<C-n>"]  = actions.move_selection_next,
                ["<C-p>"]  = actions.move_selection_previous,
            }
            local rg_common = {
                "--glob", "!**/.git/*",
                "--hidden",
                "--no-config",
            }
            return {
                defaults = {
                    path_display = { "truncate" },
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
                        horizontal = { preview_width = 0.6 },
                        vertical = { preview_height = 0.6 },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--column",
                        "--line-number",
                        "--no-heading",
                        "--smart-case",
                        "--with-filename",
                        unpack(rg_common),
                    },
                    mappings = { i = common, n = common },
                },
                extensions = {
                    ["ui-select"] = require("telescope.themes").get_dropdown(),
                },
                pickers = {
                    find_files  = {
                        find_command = {
                            "rg",
                            "--files",
                            unpack(rg_common),
                        },
                    },
                    diagnostics = { layout_strategy = "vertical" },
                    registers   = { layout_strategy = "vertical" },
                },
            }
        end,

        config = function(_, opts)
            local telescope = require("telescope")
            local themes = require("telescope.themes")
            local builtin = require("telescope.builtin")

            telescope.setup(opts)
            telescope.load_extension("ui-select")

            local function root()
                local r = vim.system(
                    { "git", "rev-parse", "--show-toplevel" },
                    { text = true }
                ):wait()

                if r.code == 0 and r.stdout then
                    return vim.trim(r.stdout)
                end

                return vim.fn.getcwd()
            end

            local maps = {
                { "n", "<leader>fl", builtin.loclist,   "Find Location list" },
                { "n", "<leader>fR", builtin.registers, "Find Registers" },
                { "n", "<leader>fj", builtin.jumplist,  "Find Jump list" },
                { "n", "<leader>fc", builtin.commands,  "Find Commands" },
                { "n", "<leader>fk", builtin.keymaps,   "Find Keymaps" },
                { "n", "<leader>fh", builtin.help_tags, "Find Help" },
                { "n", "<leader>fm", builtin.marks,     "Find Marks" },

                { "n", "<leader>,", function()
                    builtin.buffers(themes.get_ivy())
                end, "Buffers" },

                { "n", "<leader>ff", function()
                    builtin.find_files({ cwd = root() })
                end, "Find Files" },

                { "n", "<leader>fF", function()
                    builtin.find_files({ cwd = vim.fn.getcwd() })
                end, "Find Files in CWD" },

                { "n", "<leader>.", function()
                    builtin.find_files(themes.get_ivy())
                end, "Find Files (ivy)" },

                { "n", "<leader>fq", function()
                    builtin.quickfix(themes.get_dropdown({ layout_config = { width = 0.8 } }))
                end, "Quickfix" },

                { "n", "<leader>fg", function()
                    builtin.live_grep({ search_dirs = { root() } })
                end, "Grep" },

                { "n", "<leader>fG", function()
                    builtin.live_grep({ search_dirs = { vim.fn.getcwd() } })
                end, "Grep in CWD" },

                { "n", "gS",         builtin.lsp_workspace_symbols, "Workspace Symbols" },
                { "n", "gs",         builtin.lsp_document_symbols,  "Document Symbols" },
                { "n", "gy",         builtin.lsp_type_definitions,  "Type Definition" },
                { "n", "gi",         builtin.lsp_implementations,   "Implementation" },
                { "n", "gI",         builtin.lsp_incoming_calls,    "Incoming calls" },
                { "n", "gO",         builtin.lsp_outgoing_calls,    "Outgoing calls" },
                { "n", "gd",         builtin.lsp_definitions,       "Definition" },
                { "n", "gr",         builtin.lsp_references,        "References" },
                { "n", "<leader>fd", builtin.diagnostics,           "Diagnostics" },
            }

            for _, m in ipairs(maps) do
                vim.keymap.set(m[1], m[2], m[3], {
                    noremap = true,
                    silent = true,
                    desc = m[4],
                })
            end
        end,
    },
}
