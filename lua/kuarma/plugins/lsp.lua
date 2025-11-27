return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{
					path = "LazyVim",
					words = {
						"LazyVim",
					},
				},
			},
		},
	},
}
