local dap=require('dap')
local dapui=require('dapui')
local telescope=require('telescope')

-- UI Config
vim.fn.sign_define(
    "DapBreakpoint",
    { text = "●", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
)
vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "◆", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = "▶", texthl = "", linehl = "debugPC", numhl = "debugPC" }
)

dap.defaults.fallback.force_external_terminal = true
dapui.setup({
    layouts = {
        {
            elements = {
                "watches",
                { id = "scopes", size = 0.5 },
                { id = "repl", size = 0.15 },
            },
            size = 79,
            position = "left",
        },
        {
            elements = {
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
})

-- Load Telescope plugin
telescope.load_extension('dap')

-- Debugging keybinds
local opts = { noremap = true, silent = true}
local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nnoremap = bind("n")

nnoremap("<F6>", function()
    dap.run_to_cursor()
  end,
  opts
)
nnoremap("<F5>", function()
    dap.continue()
    dapui.open()
  end,
  opts
)
nnoremap("<C-F5>", function()
    dap.terminate()
    dapui.close()
    dap.repl.close()
  end,
  opts
)
nnoremap("<F9>", function()
    dap.toggle_breakpoint()
  end,
  opts
)
nnoremap("<F10>", function()
    dap.step_over()
  end,
  opts
)
nnoremap("<F11>", function()
    dap.step_into()
  end,
  opts
)
nnoremap("<F12>", function()
    dap.step_out()
  end,
  opts
)
nnoremap("<leader>dc", function()
    telescope.extensions.dap.commands({})
  end,
  opts
)
