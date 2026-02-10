return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = function ()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end

        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<leader>dc", dap.continue, {})
        vim.keymap.set("n", "<leader>ds", dap.step_over, {})
        vim.keymap.set("n", "<leader>di", dap.step_into, {})
        vim.keymap.set("n", "<leader>do", dap.step_out, {})

        -- Rust debugging configuration with rust-gdb
        dap.adapters.gdb = {
          type = "executable",
          command = "rust-gdb",
          args = { "-i", "dap" }
        }

        dap.configurations.rust = {
          {
            name = "Rust debug",
            type = "gdb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
          },
          {
            name = "Rust attach",
            type = "gdb",
            request = "attach",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            pid = function()
              return vim.fn.input("Process ID: ")
            end,
            cwd = "${workspaceFolder}",
          }
        }

    end
}
