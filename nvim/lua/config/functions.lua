------------------------------------------------------------
-- Custom Functions & AutoCommands
------------------------------------------------------------

local set = vim.keymap.set
local base_opts = { noremap = true, silent = true }

-- Helper function to extend options with description
local function set_opts(desc)
    local extended_opts = vim.tbl_extend("force", base_opts, { desc = desc })
    return extended_opts
end


-- Make created terminals modifiable & Enter on Insert
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.bo.modifiable = true
        vim.cmd("startinsert")
    end,
})

-- Remove trailing whitespaces & Ensure the last line is empty
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function()
        -- Remove trailing whitespaces
        vim.cmd([[%s/\s\+$//e]])
    end,
})

-- Write file with elevated permisisons
local function sudo_write_buffer()
    local filename = vim.fn.expand('%:p')
    local temp_filename = vim.fn.tempname()
    assert(io.open(temp_filename, "w+"), "Failed to create temporary file")
    vim.cmd('write!' .. temp_filename)

    local sudo_password = vim.fn.inputsecret("Enter sudo password: ")
    local cmd = 'echo ' .. vim.fn.shellescape(sudo_password) ..
        ' | sudo -S tee ' .. vim.fn.shellescape(filename) ..
        ' < ' .. vim.fn.shellescape(temp_filename) .. ' > /dev/null'

    vim.fn.system(cmd)
    vim.cmd('edit!')
end

vim.api.nvim_create_user_command("SudoWrite", sudo_write_buffer, {})

-- Format current buffer
local function format_buffer()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end

vim.api.nvim_create_user_command("Fmt", format_buffer, {})

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})


-- Copy file path
local function copy_file_path()
    local file = vim.fn.expand("%:p")
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

    if git_root and git_root ~= "" then
        file = file:gsub("^" .. vim.pesc(git_root) .. "/", "")
    end

    vim.fn.setreg("+", file)
    print("Copied: " .. file)
end

-- keymaps
set("n", "yp", copy_file_path, set_opts("Yank relative file path"))

-- Toggle background
local function toggle_background()
    vim.o.background = (vim.o.background == "dark") and "light" or "dark"
end

vim.api.nvim_create_user_command("ToggleBG", toggle_background, {})
