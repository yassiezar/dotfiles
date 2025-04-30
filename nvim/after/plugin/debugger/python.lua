require("dap-python").setup("python3")

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
