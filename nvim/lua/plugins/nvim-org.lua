-- lua/plugins/org-nvim.lua

local org = require("orgmode")
local org_bullets = require("org-bullets")

org.setup({
    org_agenda_files = "~/org/**/*",
    org_default_notes_file = "~/org/index.org",
    org_startup_folded = "showeverything",
})

org_bullets.setup({})

-- Function to generate inital org metadata
--
-- Used template:
-- #+title: <filename>
-- #+author: @SfikasTeo
-- #+filetags:<dirs/from/org/until/file>:
-- #+PRIORITIES: 1 10 5
--
-- The filetags are extracted from the file path
-- if ~org~ exists in the path
local function generate_org_template()
    local filename = vim.fn.expand("%:t:r")  -- Get the current file name without extension
    local filepath = vim.fn.expand("%:p:h")  -- Get the current file path
    local tags = filepath:match(".*/org/(.+)") -- Extract the tags from the file path

    local template = string.format(
        "#+title: %s\n#+author: @SfikasTeo\n#+filetags:%s:\n#+PRIORITIES: 1 10 5\n",
        filename, tags and tags:gsub("/", ":") or ""
    )

    return template
end

-- Function to insert the template into the buffer
local function insert_org_template()
    local template = generate_org_template()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
end

vim.api.nvim_create_user_command("OrgInsertTemplate", insert_org_template, {})
