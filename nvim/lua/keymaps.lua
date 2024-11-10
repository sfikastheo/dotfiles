------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------

-- Notable default bindings:
-- <C-w>h, <C-w>j, <C-w>k, <C-w>l -- window navigation
-- <C-w>H, <C-w>J, <C-w>K, <C-w>L -- move window
-- <C-w>s, <C-w>v -- horizontal and vertical split
-- <C-w>o -- Leave only current window
-- <C-w>c, <C-w>q -- close window

-- Set Custom Keymaps
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key setup
set("n", "<Space>", "<Nop>", opts, { desc = "" })
vim.g.mapleader = " "

-- Clear search highlights
set("n", "<leader>/", "<Cmd>noh<CR>", opts, { desc = "Clear highlights" })

-- Escape mappings
set({ "n", "v", "o" }, "<C-c>", "<Esc>", opts, { desc = "Esc" })
set({ "v", "o", "i" }, ",,", "<Esc>", opts, { desc = "Esc" })
set("t", ",,", "<C-\\><C-n>", opts, { desc = "Term Esc" })

-- Delete w/o yanking
set({ "n", "v" }, "d", '"_d', opts, { desc = "Del" })
set({ "n", "v" }, "x", '"_x', opts, { desc = "Del char" })
set({ "n", "v" }, "D", '"_D', opts, { desc = "Del line" })

-- Cutting with leader key
set({ "n", "v" }, "<leader>d", "d", opts, { desc = "Cut" })
set({ "n", "v" }, "<leader>x", "x", opts, { desc = "Cut char" })
set({ "n", "v" }, "<leader>D", 'D', opts, { desc = "Cut line" })

-- Enhanced navigation
set({ "n", "v", "o" }, "<C-u>", "<C-u>zz", opts, { desc = "Page up" })
set({ "n", "v", "o" }, "<C-d>", "<C-d>zz", opts, { desc = "Page down" })

-- Window resizing
set("n", "<c-w><", "20<c-w><", opts, { desc = "Inc width" })
set("n", "<c-w>-", "20<c-w>-", opts, { desc = "Dec height" })
set("n", "<c-w>+", "20<c-w>+", opts, { desc = "Inc height" })
set("n", "<c-w>>", "20<c-w>>", opts, { desc = "Dec width" })

-- Miscellaneous
set("n", "<leader>fp", ':lua print(vim.fn.expand("%:p"))<CR>', opts, { desc = "Print file path" })
set("n", "<leader>tv", ":vsplit | term<CR>", opts, { desc = "Term vertical split" })
set("n", "<leader>ts", ":split | term<CR>", opts, { desc = "Term horizontal split" })
