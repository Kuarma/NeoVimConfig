return {
  'stevearc/conform.nvim',
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" }
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
	},
}
