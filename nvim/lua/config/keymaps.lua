------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------

local set = vim.keymap.set
local base_opts = { noremap = true, silent = true }

-- Helper function to extend options with description
local function set_opts(desc)
    local extended_opts = vim.tbl_extend("force", base_opts, { desc = desc })
    return extended_opts
end

-- Leader key setup
set("n", "<Space>", "<Nop>", base_opts)
vim.g.mapleader = " "

-- Clear search highlights
set("n", "<leader>/", "<Cmd>noh<CR>", set_opts("Clear highlights"))

-- Escape mappings
set({ "n", "v", "o", "i" }, "<C-c>", "<Esc>", set_opts("Esc"))
set({ "v", "o", "i" }, ",,", "<Esc>", set_opts("Esc"))
set("t", ",,", "<C-\\><C-n>", set_opts("Esc"))

-- Delete w/o yanking
set({ "n", "v" }, "d", '"_d', set_opts("Delete"))
set({ "n", "v" }, "x", '"_x', set_opts("Delete char"))
set({ "n", "v" }, "D", '"_D', set_opts("Delete line"))

-- Cutting with leader key
set({ "n", "v" }, "<leader>d", "d", set_opts("Cut"))
set({ "n", "v" }, "<leader>x", "x", set_opts("Cut char"))
set({ "n", "v" }, "<leader>D", 'D', set_opts("Cut line"))

-- Enhanced navigation
set({ "n", "v", "o" }, "<C-u>", "<C-u>zz", set_opts("Up"))
set({ "n", "v", "o" }, "<C-d>", "<C-d>zz", set_opts("Down"))
set({ "n", "v", "o" }, "gm", "%", set_opts("Go Matching"))

-- Window resizing
set("n", "<c-w><", "20<c-w><", set_opts("< width"))
set("n", "<c-w>>", "20<c-w>>", set_opts("> width"))
set("n", "<c-w>-", "20<c-w>-", set_opts("- height"))
set("n", "<c-w>+", "20<c-w>+", set_opts("+ height"))

-- LSP
set("n", "<leader>ll", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
    set_opts("Inlay Hints"))
