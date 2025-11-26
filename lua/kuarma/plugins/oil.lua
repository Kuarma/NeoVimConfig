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
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		float = {
			padding = 0,
			max_width = 0,
			max_height = 0,
			win_options = {
				winblend = 0,
			},
		},
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 1000,
			autosave_changes = false,
		},
		keymaps = {
			["<C-h>"] = "<CMD>TmuxNavigateLeft<cr>",
			["<C-j>"] = "<CMD>TmuxNavigateDown<cr>",
			["<C-k>"] = "<CMD>TmuxNavigateUp<cr>",
			["<C-l>"] = "<CMD>TmuxNavigateRight<cr>",
			["<C-\\>"] = "<CMD>TmuxNavigatePrevious<cr>",
		},
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		promt_save_on_select_new_entry = false,
		cleanup_delay_ms = 2000,
		use_default_keymaps = true,
		watch_for_changes = true,
		delete_to_trash = true,
	},
	dependencies = {
		{
			"nvim-mini/mini.icons",
			opts = {},
		},
	},
}
