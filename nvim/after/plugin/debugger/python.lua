require("dap-python").setup(vim.fn.getcwd() .. "/.venv/bin/python")

local dap = require('dap')

table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Run program with args',
    program = '${file}',
    justMyCode = true,
    args = function()
      local input = vim.fn.input('Program args: ')
      return vim.split(input, '%s+')
    end,
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Run current script',
  program = '${file}',
  justMyCode = true,
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Run module with args',
  module = function()
    return vim.fn.input('Script entry point (module name): ')
  end,
  args = function()
    local input = vim.fn.input('Program args: ')
    return vim.split(input, '%s+')
  end,
  justMyCode = true,
})

-- FC API configs
table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "Debug fc_api",
  module = "fc_api.cli",
  cwd = "${workspaceFolder}",
  env = {
    PYTHONPATH = "${workspaceFolder}",
    DEBUG_MODE = "True",
    DEVELOPER_MODE = "True",
    BACKEND_WORKERS = "1",
  },
  justMyCode = true,
  subProcess = false,
})

local function celery_attach(name, port)
  table.insert(dap.configurations.python, {
    type = "python",
    request = "attach",
    name = "Attach Celery: " .. name,
    connect = {
      host = "127.0.0.1",
      port = port,
    },
    pathMappings = {
      {
        localRoot = vim.fn.getcwd(),
        remoteRoot = vim.fn.getcwd(),
      },
    },
  })
end

celery_attach("api_core", 5678)
