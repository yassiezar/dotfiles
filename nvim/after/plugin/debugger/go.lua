require("dap-go").setup()

table.insert(require('dap').configurations.go, {
  type = 'go',
  request = 'launch',
  name = 'My custom launch configuration',
  program = '${file}',
  -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
})
