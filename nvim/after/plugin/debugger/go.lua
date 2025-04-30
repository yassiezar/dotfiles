require("dap-go").setup()

table.insert(require('dap').configurations.go, {
  type = 'go',
  request = 'launch',
  name = 'Launch the current go program',
  program = '${file}',
})
