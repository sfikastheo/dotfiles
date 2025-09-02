------------------------------------------------------------
-- Nvim Configuration
------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=main",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("config.langmap")
require("config.keymaps")
require("config.options")
require("config.functions")

local loader = require("lazy.core.loader")
loader.check_rtp = function() end
require("lazy").setup({
    spec = { { import = "plugins" } },
    experimental = { check_rtp = false, check_rtp_message = false },
})
