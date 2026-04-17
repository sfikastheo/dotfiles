------------------------------------------------------------
-- Options
------------------------------------------------------------

-- Disable matchit (conflicts with langremap)
vim.g.loaded_matchit = 1

-- StatusLine
vim.opt.cmdheight = 0
vim.g.VM_set_statusline = 0
vim.g.VM_silent_exit = 1

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Cursor
vim.opt.cursorline = true

-- Windows
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.pumheight = 10

-- Interface
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = true
vim.o.winborder = "rounded"

-- Indentation
local indent = 4
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent
vim.opt.tabstop = indent
vim.opt.list = false
vim.opt.listchars = {
    eol = '$',      -- `$` at the end of each line
    space = '·',    -- `·` for space characters
    tab = '>-',     -- `>-` for tab characters
    extends = '>',  -- `>` when text extends beyond the window
    precedes = '<', -- `<` when text precedes the window
    nbsp = '%',     -- `%` for non-breaking spaces
}

-- Search
vim.opt.grepprg = "rg --vimgrep"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Completion
vim.opt.completeopt = { "menu", "noselect" }

-- Behavior
vim.opt.termguicolors = true
vim.opt.concealcursor = ''
vim.opt.swapfile = false
vim.opt.conceallevel = 0
vim.opt.undofile = true
vim.opt.hidden = false
vim.opt.laststatus = 3
vim.opt.wrap = true

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

local function use_osc52()
  return vim.env.SSH_CONNECTION ~= nil
      or vim.env.NVIM_USE_OSC52 ~= nil
end

if use_osc52() then
  vim.g.clipboard = "osc52"
end
