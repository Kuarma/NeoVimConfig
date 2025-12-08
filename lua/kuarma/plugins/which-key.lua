return {
	"folke/which-key.nvim",
	opts = {},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>s", group = "Telescope: Search" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>g", group = "Go ..." },
			{ "<leader>q", group = "Quickfix: Movement" },
			{ "<leader>S", group = "Sessions" },
			{ "<leader>t", group = "Todo" },
		})
	end,
}
