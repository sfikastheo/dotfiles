return {
	"echasnovski/mini.files",
	opts = {
		windows = {
            preview = false,
            max_number = 6,
            width_focus = 50,
            width_nofocus = 15,
            width_preview = 25,
		},
		options = {
            permanent_delete = true,
			use_as_default_explorer = true,
		},
        content = {
            filter = nil,
            prefix = nil,
            sort = nil,
        },
        mappings = {
            close       = '<C-c>',
            go_in       = 'l',
            go_in_plus  = '<CR>',
            go_out      = 'h',
            go_out_plus = 'H',
            mark_goto   = "mg",
            mark_set    = 'ms',
            reset       = '<DEL>',
            reveal_cwd  = '@',
            show_help   = 'g?',
            synchronize = '=',
            trim_left   = '>',
            trim_right  = '<',
        },
	},
	keys = {
		{
			"<leader>p",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "mini.files (current file)",
		},
		{
			"<leader>P",
			function()
				require("mini.files").open(vim.loop.cwd(), true)
			end,
			desc = "mini.files (cwd)",
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)
	end
}
