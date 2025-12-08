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
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
			kind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰎠",
				Enum = "ℰ",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󱥚",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "",
				Struct = "𝓢",
				Event = "",
				Operator = "󱓉",
				TypeParameter = "󰬛",
			},
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
				border = "rounded",
				winblend = 0,
				scrollbar = false,
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
				window = {
					border = "rounded",
					winblend = 0,
					scrollbar = true,
				},
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
				"buffer",
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
		signature = {
			enabled = true,
			window = {
				border = "rounded",
				winblend = 0,
				scrollbar = false,
			},
		},
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
