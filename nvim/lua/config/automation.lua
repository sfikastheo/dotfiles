-- Automations

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

        -- Ensure the last line is empty (adds a new line if the last line is not empty)
        -- local bufnr = vim.api.nvim_get_current_buf()
        -- local line_count = vim.api.nvim_buf_line_count(bufnr)
        -- local last_line = vim.api.nvim_buf_get_lines(bufnr, line_count-1, line_count, false)[1]

        -- if last_line ~= "" then
        --     vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, {""})
        -- end
    end,
})

-- Execute shellcheck & populate the location list
local function shellcheck_current_buffer()
    local filepath = vim.api.nvim_buf_get_name(0)
    local shellcheck_cmd = "shellcheck -a -f gcc " .. filepath
    local result = vim.fn.systemlist(shellcheck_cmd)
    if #result == 0 then
        vim.notify("shellcheck: nothing to be done", vim.log.levels.INFO)
        return
    end
    local loclist = {}
    for _, line in ipairs(result) do
        -- gcc output format: file:line:col: message
        local parts = vim.split(line, ":")
        if #parts >= 4 then
            local lnum = tonumber(parts[2])
            local col = tonumber(parts[3])
            local text = table.concat(vim.list_slice(parts, 4), ":")
            local type = string.sub(parts[4], 1, 1)

            local status = (type == "E") and vim.log.levels.ERROR or vim.log.levels.INFO
            vim.notify(line, status)

            table.insert(loclist, {
                bufnr = vim.api.nvim_get_current_buf(),
                lnum = lnum,
                col = col,
                text = text,
                type = type,
            })
        end
    end

    vim.fn.setloclist(0, loclist)
    vim.cmd("Telescope loclist")
end

vim.api.nvim_create_user_command("ShellCheck", shellcheck_current_buffer, {})
