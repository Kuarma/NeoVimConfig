return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<S-tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
			["<A-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
		cmdline = {
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},
		completion = {
			trigger = {
				show_on_trigger_character = true,
			},
			ghost_text = {
				enabled = true,
			},
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{
							"label",
							"label_description",
							gap = 1,
						},
						{
							"kind_icon",
							"kind",
							gap = 1,
						},
					},
				},
				border = "single",
			},
			documentation = {
				auto_show = true,
			},
		},
		sources = {
			default = {
				"lsp",
				"easy-dotnet",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				["easy-dotnet"] = {
					name = "easy-dotnet",
					enabled = true,
					module = "easy-dotnet.completion.blink",
					score_offset = 1000,
					async = true,
				},
			},
		},
		fuzzy = {
			sorts = {
				"exact",
				"score",
				"sort_text",
			},
			implementation = "prefer_rust_with_warning",
		},
		signature = {
			enabled = true,
		},
	},
	opts_extend = { "sources.default" },
}
