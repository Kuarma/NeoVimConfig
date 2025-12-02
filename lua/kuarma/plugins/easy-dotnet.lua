return {
	"GustavEikaas/easy-dotnet.nvim",
	-- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
	-- are highly recommended for a better experience
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local dotnet = require("easy-dotnet")
		-- Options are not required
		dotnet.setup({
			lsp = {
				enabled = true, -- Enable builtin roslyn lsp
				roslynator_enabled = true, -- Automatically enable roslynator analyzer
				analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
				config = {},
			},
			debugger = {
				bin_path = "netcoredbg",
				auto_register_dap = true,
				mappings = {
					open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
				},
			},
			---@type TestRunnerOptions
			test_runner = {
				---@type "split" | "vsplit" | "float" | "buf"
				viewmode = "float",
				---@type number|nil
				vsplit_width = nil,
				---@type string|nil "topleft" | "topright"
				vsplit_pos = nil,
				enable_buffer_test_execution = true,
				noBuild = true,
				icons = {
					passed = "",
					skipped = "",
					failed = "",
					success = "",
					reload = "",
					test = "",
					sln = "󰘐",
					project = "󰘐",
					dir = "",
					package = "",
				},
				mappings = {
					run_test_from_buffer = { lhs = "<leader><leader>r", desc = "run test from buffer" },
					peek_stack_trace_from_buffer = { lhs = "<leader><leader>p", desc = "peek stack trace from buffer" },
					filter_failed_tests = { lhs = "<leader><leader>fe", desc = "filter failed tests" },
					debug_test = { lhs = "<leader><leader>d", desc = "debug test" },
					debug_test_from_buffer = { lhs = "<leader><leader>d", desc = "debug test" },
					go_to_file = { lhs = "<leader><leader>g", desc = "go to file" },
					run_all = { lhs = "<leader><leader>R", desc = "run all tests" },
					run = { lhs = "<leader><leader>r", desc = "run test" },
					peek_stacktrace = { lhs = "<leader><leader>p", desc = "peek stacktrace of failed test" },
					expand = { lhs = "<leader><leader>o", desc = "expand" },
					expand_node = { lhs = "<leader><leader>E", desc = "expand node" },
					expand_all = { lhs = "<leader><leader>-", desc = "expand all" },
					collapse_all = { lhs = "<leader><leader>W", desc = "collapse all" },
					close = { lhs = "<leader><leader>q", desc = "close testrunner" },
					refresh_testrunner = { lhs = "<leader><leader><C-r>", desc = "refresh testrunner" },
				},
				additional_args = {},
			},
			new = {
				project = {
					prefix = "sln",
				},
			},
			---@param action "test" | "restore" | "build" | "run"
			terminal = function(path, action, args)
				args = args or ""
				local commands = {
					run = function()
						return string.format("dotnet run --project %s %s", path, args)
					end,
					test = function()
						return string.format("dotnet test %s %s", path, args)
					end,
					restore = function()
						return string.format("dotnet restore %s %s", path, args)
					end,
					build = function()
						return string.format("dotnet build %s %s", path, args)
					end,
					watch = function()
						return string.format("dotnet watch --project %s %s", path, args)
					end,
				}
				local command = commands[action]()
				if require("easy-dotnet.extensions").isWindows() == true then
					command = command .. "\r"
				end
				vim.cmd("vsplit")
				vim.cmd("term " .. command)
			end,
			csproj_mappings = true,
			fsproj_mappings = true,
			auto_bootstrap_namespace = {
				type = "block_scoped",
				enabled = true,
				use_clipboard_json = {
					behavior = "prompt",
					register = "+",
				},
			},
			server = {
				---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
				log_level = "All",
			},
			picker = "telescope",
			background_scanning = true,
			notifications = {
				--Set this to false if you have configured lualine to avoid double logging
				handler = function(start_event)
					local spinner = require("easy-dotnet.ui-modules.spinner").new()
					spinner:start_spinner(start_event.job.name)
					---@param finished_event JobEvent
					return function(finished_event)
						spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
					end
				end,
			},
			diagnostics = {
				default_severity = "error",
				setqflist = false,
			},
		})

		-- Example command
		vim.api.nvim_create_user_command("Secrets", function()
			dotnet.secrets()
		end, {})

		-- Example keybinding
		vim.keymap.set("n", "<C-p>", function()
			dotnet.run_project()
		end)
	end,
}
