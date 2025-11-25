return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
		columns = {
			"permissions",
			"size",
			"mtime",
			"icon",
		},
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		skip_confirm_for_simple_edits = true,
		promt_save_on_select_new_entry = false,
		cleanup_delay = 2000,
		use_default_keymaps = true,
		float = {
			padding = 0,
			max_width = 0,
			max_height = 0,
			win_options = {
				winblend = 0,
			},
		},
	},
	dependencies = {
		{
			"nvim-mini/mini.icons",
			opts = {},
		},
	},
}
