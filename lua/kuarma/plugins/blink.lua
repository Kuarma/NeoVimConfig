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
			["<C-e>"] = { "show", "show_documentation", "hide_documentation" },
			["<A-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
		appearance = {
			nerd_font_variant = "normal",
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
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
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
				"path",
				"snippets",
				"buffer",
			},
		},
		fuzzy = {
			sorts = {
				"exact",
				"score",
				"sort_text",
			},
			implementation = "prefer_rust",
		},
		signature = {
			enabled = true,
		},
	},
	opts_extend = { "sources.default" },
}
