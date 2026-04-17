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

-- Create a `daily_journal` entry

--- @param journal_dir string
--- @param today string
--- @return string | nil
local function get_previous_journal_file(journal_dir, today)
    local files = vim.fn.glob(journal_dir .. "/*.md", false, true)
    table.sort(files)

    local last = files[#files]
    if not last then return end

    if vim.fn.fnamemodify(last, ":t:r") == today then
        return #files > 1 and files[#files - 1] or nil
    end

    return last
end

--- @param file string
--- @return string[]
local function get_uncompleted_tasks(file)
    local tasks = {}
    local in_task = false

    for _, line in ipairs(vim.fn.readfile(file)) do
        if line:match("^%- %[[^xX]%]") then
            table.insert(tasks, line)
            in_task = true
        elseif line:match("^%s+") and in_task then
            table.insert(tasks, line)
        else
            in_task = false
        end
    end

    return tasks
end

--- @param file string
--- @param heading string
--- @param tasks string[]
local function insert_tasks(file, heading, tasks)
    local lines = vim.fn.readfile(file)
    local result = {}

    for _, line in ipairs(lines) do
        table.insert(result, line)
        if line:match("^" .. vim.pesc(heading) .. "$") then
            table.insert(result, "")
            vim.list_extend(result, tasks)
        end
    end

    vim.fn.writefile(result, file)
    vim.cmd("checktime")
end

local function daily_journal()
    local journal_dir = vim.fn.expand("~/Projects/vault/journal")
    local today = tostring(os.date("%Y-%m-%d-%a"))
    local today_file = string.format("%s/%s.md", journal_dir, today)
    local create_today_file = vim.fn.filereadable(today_file) == 0

    local uncompleted_tasks = {}
    if create_today_file then
        local prev_file = get_previous_journal_file(journal_dir, today)
        if prev_file then
            uncompleted_tasks = get_uncompleted_tasks(prev_file)
        end
    end

    vim.cmd.Obsidian("today")

    if create_today_file and #uncompleted_tasks > 0 then
        vim.schedule(function()
            insert_tasks(today_file, "## Tasks", uncompleted_tasks)
        end)
    end
end

vim.api.nvim_create_user_command("Journal", daily_journal, {})

-- Tree-sitter auto-command on markdown
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
        vim.treesitter.start(args.buf)
    end,
})
