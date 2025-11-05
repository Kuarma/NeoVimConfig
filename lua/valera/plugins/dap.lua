return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()

      K("", "<space><space>?", function()
        require("dapui").eval(nil, { enter = true })
      end, { desc = "Inspect var under cursor" })

      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' }
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net', 'file')
          end,
        }
      }

      K("n", "<space>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      K("n", "<space>rb", dap.run_to_cursor, { desc = "Run to cursor" })

      K("n", "<F1>", dap.continue, { desc = "Debug: Continue" })
      K("n", "<F2>", dap.step_into, { desc = "Debug: Step into" })
      K("n", "<F3>", dap.step_over, { desc = "Debug: Step over" })
      K("n", "<F4>", dap.step_out, { desc = "Debug: Step out" })
      K("n", "<F5>", dap.step_back, { desc = "Debug: Step back" })
      K("n", "<F6>", dap.restart, { desc = "Debug: Restart" })

      vim.fn.sign_define('DapBreakpoint',
        {
          text = 'b',
          texthl = 'DapBreakpointSymbol',
          linehl = 'DapBreakpoint',
          numhl = 'DapBreakpoint'
        })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
