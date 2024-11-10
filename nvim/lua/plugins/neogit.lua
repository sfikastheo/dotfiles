-- lua/plugins/neogit.lua

local neogit = require("neogit")

local set = vim.keymap.set
local default_set = { noremap = true, silent = true }

neogit.setup({
    disable_hint = false,
    disable_context_highlighting = false,
    disable_signs = false,
    disable_insert_on_commit = "auto",
    filewatcher = {
        interval = 1000,
        enabled = true,
    },
    graph_style = "unicode",
    git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        -- ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        -- ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
    },
    remember_settings = true,
    use_per_project_settings = true,
    ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitRevertPopup--no-edit",
    },
    highlight = {
        italic = true,
        bold = true,
        underline = true,
    },
    use_default_keymaps = true,
    auto_refresh = true,
    sort_branches = "-committerdate",
    kind = "tab",
    disable_line_numbers = true,
    console_timeout = 2000,
    auto_show_console = true,
    status = {
        recent_commit_count = 10,
    },
    commit_editor = {
        kind = "auto",
    },
    commit_select_view = {
        kind = "tab",
    },
    commit_view = {
        kind = "vsplit",
        verify_commit = os.execute("which gpg") == 0,
        -- Can be set to true or false, otherwise we try to find the binary
    },
    log_view = {
        kind = "tab",
    },
    rebase_editor = {
        kind = "auto",
    },
    reflog_view = {
        kind = "tab",
    },
    merge_editor = {
        kind = "auto",
    },
    tag_editor = {
        kind = "auto",
    },
    preview_buffer = {
        kind = "split",
    },
    popup = {
        kind = "split",
    },
    signs = {
        -- { CLOSED, OPENED }
        hunk = { "", "" },
        item = { ">", "v" },
        section = { ">", "v" },
    },
    sections = {
        -- Reverting/Cherry Picking
        sequencer = {
            folded = false,
            hidden = false,
        },
        untracked = {
            folded = false,
            hidden = false,
        },
        unstaged = {
            folded = false,
            hidden = false,
        },
        staged = {
            folded = false,
            hidden = false,
        },
        stashes = {
            folded = true,
            hidden = false,
        },
        unpulled_upstream = {
            folded = true,
            hidden = false,
        },
        unmerged_upstream = {
            folded = false,
            hidden = false,
        },
        unpulled_pushRemote = {
            folded = true,
            hidden = false,
        },
        unmerged_pushRemote = {
            folded = false,
            hidden = false,
        },
        recent = {
            folded = true,
            hidden = false,
        },
        rebase = {
            folded = true,
            hidden = false,
        },
    },
    mappings = {
        commit_editor = {
            ["q"] = "Close",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
        },
        rebase_editor = {
            ["p"] = "Pick",
            ["r"] = "Reword",
            ["e"] = "Edit",
            ["s"] = "Squash",
            ["f"] = "Fixup",
            ["x"] = "Execute",
            ["d"] = "Drop",
            ["b"] = "Break",
            ["q"] = "Close",
            ["<cr>"] = "OpenCommit",
            ["gk"] = "MoveUp",
            ["gj"] = "MoveDown",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
        },
        finder = {
            ["<cr>"] = "Select",
            ["<c-c>"] = "Close",
            ["<esc>"] = "Close",
            ["<c-n>"] = "Next",
            ["<c-p>"] = "Previous",
            ["<down>"] = "Next",
            ["<up>"] = "Previous",
            ["<tab>"] = "MultiselectToggleNext",
            ["<s-tab>"] = "MultiselectTogglePrevious",
            ["<c-j>"] = "NOP",
        },
        popup = {
            ["?"] = "HelpPopup",
            ["A"] = "CherryPickPopup",
            ["D"] = "DiffPopup",
            ["M"] = "RemotePopup",
            ["P"] = "PushPopup",
            ["X"] = "ResetPopup",
            ["Z"] = "StashPopup",
            ["b"] = "BranchPopup",
            ["c"] = "CommitPopup",
            ["f"] = "FetchPopup",
            ["l"] = "LogPopup",
            ["m"] = "MergePopup",
            ["p"] = "PullPopup",
            ["r"] = "RebasePopup",
            ["v"] = "RevertPopup",
            ["w"] = "WorktreePopup",
        },
        status = {
            ["k"] = "MoveUp",
            ["j"] = "MoveDown",
            ["q"] = "Close",
            ["o"] = "OpenTree",
            ["I"] = "InitRepo",
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["<tab>"] = "Toggle",
            ["x"] = "Discard",
            ["s"] = "Stage",
            ["S"] = "StageUnstaged",
            ["<c-s>"] = "StageAll",
            ["K"] = "Untrack",
            ["u"] = "Unstage",
            ["U"] = "UnstageStaged",
            ["$"] = "CommandHistory",
            ["Y"] = "YankSelected",
            ["<c-r>"] = "RefreshBuffer",
            ["<enter>"] = "GoToFile",
            ["<c-v>"] = "VSplitOpen",
            ["<c-x>"] = "SplitOpen",
            ["<c-t>"] = "TabOpen",
            ["{"] = "GoToPreviousHunkHeader",
            ["}"] = "GoToNextHunkHeader",
            ["[c"] = "OpenOrScrollUp",
            ["]c"] = "OpenOrScrollDown",
        },
    },
})

set("n", "<leader>og", "<cmd>Neogit<cr>", default_set)
