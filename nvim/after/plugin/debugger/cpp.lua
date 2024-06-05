local dap = require('dap')

-- Adapter config
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/jlock/.local/share/nvim/mason/bin/OpenDebugAD7'
}

-- C++ config
local project_root = vim.fs.root(0, {'mw_anchor', '.git'})
dap.configurations.cpp = {
    {
        name = "Launch MATLAB",
        type = "cppdbg",
        request = "launch",
        program = function()
           return project_root .. "/matlab/bin/glnxa64/MATLAB"
        end,
        args = {},
        cwd = project_root,
        externalConsole = false,
        MIMode = "gdb",
        miDebuggerPath = "/mathworks/hub/share/sbtools/bin/glnxa64/sbgdb",
        setupCommands = {
            {
                text = "breaksegv",
                description = "Issue breaksegv MathWorks helper",
                ignoreFailures = true
            },
            {
                description = "Enable pretty-printing for gdb",
                text = "-enable-pretty-printing",
                ignoreFailures = true
            },
            {
                description = "Load gdb configuration",
                text = "source ~/.gdbinit",
                ignoreFailures = true
            },
            {
                description = "Add file path directory",
                text = "directory " .. project_root,
                ignoreFailures = true
            },
            {
                description = "Load sbtools source mapping",
                text = "source " .. project_root .. "/.sbtools/sb-debug/source-path.gdbinit",
                ignoreFailures = true
            }
        }
    }
}
