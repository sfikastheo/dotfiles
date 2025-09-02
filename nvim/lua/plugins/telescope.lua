return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },

        -- compact defaults + pickers (single source of truth)
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

            return {
                defaults = {
                    layout_config = {
                        width      = 0.9,
                        height     = 0.9,
                        horizontal = { preview_width = 0.6 },
                        vertical   = { preview_height = 0.6 },
                    },
                    vimgrep_arguments = {
                        "rg", "--color=never", "--no-heading", "--with-filename",
                        "--line-number", "--column", "--smart-case", "--hidden",
                        "--glob", "!**/.git/*",
                    },
                    mappings = { i = common, n = common },
                },
                pickers = {
                    find_files  = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                    diagnostics = { layout_strategy = "vertical" },
                    registers   = { layout_strategy = "vertical" },
                },
            }
        end,

        config = function(_, opts)
            local telescope = require("telescope")
            local themes    = require("telescope.themes")
            local builtin   = require("telescope.builtin")

            -- helpers
            local function git_root()
                if vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true" then
                    return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
                end
            end

            local function theme(name)
                if name == "ivy" then
                    return themes.get_ivy()
                elseif name == "dropdown" then
                    return themes.get_dropdown({ layout_config = { width = 0.8 } })
                else
                    return {}
                end
            end

            local function opts_for(name, cwd)
                local o = theme(name)
                o.cwd = cwd or git_root() or vim.fn.getcwd()
                return o
            end

            telescope.setup(opts)

            -- define all mappings declaratively
            local maps = {
                -- General
                { "n", "<leader>fl", builtin.loclist,                                                         "Find Location list" },
                { "n", "<leader>fR", builtin.registers,                                                       "Find Registers" },
                { "n", "<leader>fj", builtin.jumplist,                                                        "Find Jump list" },
                { "n", "<leader>fc", builtin.commands,                                                        "Find Commands" },
                { "n", "<leader>fk", builtin.keymaps,                                                         "Find Keymaps" },
                { "n", "<leader>fh", builtin.help_tags,                                                       "Find Help" },
                { "n", "<leader>fm", builtin.marks,                                                           "Find Marks" },

                { "n", "<leader>,",  function() builtin.buffers(theme("ivy")) end,                            "Find Buffers (ivy)" },
                { "n", "<leader>fF", function() builtin.find_files(opts_for("default", vim.fn.getcwd())) end, "Find Files in CWD" },
                { "n", "<leader>.",  function() builtin.find_files(opts_for("ivy")) end,                      "Find Files (ivy)" },
                { "n", "<leader>fq", function() builtin.quickfix(theme("dropdown")) end,                      "Find Quickfix" },
                { "n", "<leader>fg", function() builtin.live_grep(opts_for("default")) end,                   "Find by Grep" },
                { "n", "<leader>fG", function() builtin.live_grep(opts_for("default", vim.fn.getcwd())) end,  "Grep in CWD" },
                { "n", "<leader>ff", function() builtin.find_files(opts_for("default")) end,                  "Find Files" },

                -- LSP
                { "n", "gS",         builtin.lsp_workspace_symbols,                                           "Workspace Symbols" },
                { "n", "gs",         builtin.lsp_document_symbols,                                            "Document Symbols" },
                { "n", "gy",         builtin.lsp_type_definitions,                                            "Type Definition" },
                { "n", "gi",         builtin.lsp_implementations,                                             "Implementation" },
                { "n", "gI",         builtin.lsp_incoming_calls,                                              "Incoming calls" },
                { "n", "gO",         builtin.lsp_outgoing_calls,                                              "Outgoing calls" },
                { "n", "gd",         builtin.lsp_definitions,                                                 "Definition" },
                { "n", "gr",         builtin.lsp_references,                                                  "References" },
                { "n", "<leader>fd", builtin.diagnostics,                                                     "Diagnostics" },
            }

            local function desc(d) return { noremap = true, silent = true, desc = d } end
            for _, m in ipairs(maps) do vim.keymap.set(m[1], m[2], m[3], desc(m[4])) end
        end,
    },
}
