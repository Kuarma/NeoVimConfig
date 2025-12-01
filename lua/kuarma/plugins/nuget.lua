return {
	"MonsieurTib/neonuget",
	config = function()
		require("neonuget").setup({
			dotnet_path = "dotnet",
			default_project = nil,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
