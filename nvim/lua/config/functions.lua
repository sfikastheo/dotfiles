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
        vim.api.nvim_exec([[ %s/\s\+$//e ]], false)
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
    local file = vim.api.nvim_buf_get_name(0)
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end

vim.api.nvim_create_user_command("Fmt", format_buffer, {})

-- Toggle background
local function toggle_background()
  vim.o.background = (vim.o.background == "dark") and "light" or "dark"
end

vim.api.nvim_create_user_command("ToggleBG", toggle_background, {})
