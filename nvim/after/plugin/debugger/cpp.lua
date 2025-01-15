local dap = require('dap')

-- Adapter config
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/jaycee/.local/share/nvim/mason/bin/OpenDebugAD7'
}

-- C++ config
local project_root = vim.fs.root(0, {'.git'})
dap.configurations.cpp = {
    {
    }
}
