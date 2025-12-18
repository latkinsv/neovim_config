
return {
    {
        "mfussenegger/nvim-dap",
         dependencies = {
            'rcarriga/nvim-dap-ui', -- Optional, for a better UI
            'theHamsta/nvim-dap-virtual-text', -- Optional, for virtual text
         },
        lazy = true,
        config = function()
            local dap = require("dap")
            dap.set_log_level("DEBUG")

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<F6>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F8>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint,
                { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dt", dap.terminate,
                { desc = "Debug: Terminate session" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Conditional Breakpoint" })
            vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
              require('dap.ui.widgets').hover()
            end, { desc = "Debug: View the value for the expression under the cursor" })

            ------------------ Python -------------------
            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                  ---@diagnostic disable-next-line: undefined-field
                  local port = (config.connect or config).port
                  ---@diagnostic disable-next-line: undefined-field
                  local host = (config.connect or config).host or '127.0.0.1'
                  cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                      source_filetype = 'python',
                    },
                  })
                else
                  cb({
                    type = 'executable',
                    command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                      source_filetype = 'python',
                    },
                  })
                end
              end

           dap.configurations.python = {
             {
               -- The first three options are required by nvim-dap
               type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
               request = 'launch';
               name = "Launch file";

               -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

               program = "${file}"; -- This configuration will launch the current file if used.
               pythonPath = function()
                 -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                 -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                 -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                 local cwd = vim.fn.getcwd()
                 if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                   return cwd .. '/venv/bin/python'
                 elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                   return cwd .. '/.venv/bin/python'
                 else
                   return '/usr/bin/python'
                 end
               end;
             },
           }

            ------------------ C \ C++ \ Rust -------------------
            dap.adapters.gdb = {
              type = "executable",
              command = "gdb",
              args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }

            dap.configurations.c = {
              {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                args = {}, -- provide arguments if needed
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
                console = "internalConsole",
              },
              {
                name = "Select and attach to process",
                type = "gdb",
                request = "attach",
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                pid = function()
                  local name = vim.fn.input('Executable name (filter): ')
                  return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = '${workspaceFolder}'
              },
              {
                name = 'Attach to gdbserver :1234',
                type = 'gdb',
                request = 'attach',
                target = 'localhost:1234',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}'
              }
            }

            dap.configurations.cpp = dap.configurations.c
            dap.configurations.rust = dap.configurations.c

        end -- end of config
    },

    { -- DAP UI configuration
        "rcarriga/nvim-dap-ui",
        lazy = false,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },

        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            local layouts = {
              { elements = {
                    { id = "scopes", size = 0.25 },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks", size = 0.25 },
                    { id = "watches", size = 0.25 }
                },
                position = "left",
                size = 40
              },
              { elements = {
                    { id = "repl", size = 0.5 },
                    { id = "console", size = 0.5 }
                },
                position = "bottom",
                size = 10
              }
            }

            dapui.setup({
                layouts = layouts,
                enter = true,
            })

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
            dap.listeners.after.event_output.dapui_config = function(_, body)
                if body.category == "console" then
                    dapui.eval(body.output) -- Sends stdout/stderr to Console
                end
            end
        end,
    },
}
