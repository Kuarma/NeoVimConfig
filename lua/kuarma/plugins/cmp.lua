return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"xzbdmw/colorful-menu.nvim",
	},

	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "default",
			["<S-tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			["<A-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		cmdline = {
			keymap = {
				preset = "inherit",
			},
			completion = {
				menu = {
					auto_show = true,
				},
			},

			enabled = true,
		},

		completion = {
			keyword = {
				range = "full",
			},

			accept = {
				auto_brackets = {
					enabled = true,
				},
			},

			list = {
				selection = {
					preselect = false,

					auto_insert = true,
				},
			},

			menu = {
				draw = {
					columns = {
						{
							"label",
							gap = 1,
						},
						{
							"kind_icon",
							"kind",
							gap = 2,
						},
					},

					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},

				auto_show = true,
			},

			documentation = {
				auto_show = true,
			},

			ghost_text = {
				enabled = true,
			},
		},

		sources = {
			default = {
				"lsp",
				"easy-dotnet",
				"path",
				"snippets",
			},

			providers = {
				["easy-dotnet"] = {
					name = "easy-dotnet",
					enabled = true,
					module = "easy-dotnet.completion.blink",
					score_offset = 10000,
					async = true,
				},
			},
		},

		signature = { enabled = true },

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			sorts = {
				"score",
				"sort_text",
				"label",
			},
		},
	},

	opts_extend = {
		"sources.default",
	},
}
