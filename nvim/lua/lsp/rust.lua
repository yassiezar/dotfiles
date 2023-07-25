local base = require('lsp.base')

-- Rust setup
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
      parameter_hints_prefix = "<-",
      other_hints_prefix = "=>",
    },
  },
  server = {
    on_attach = base.on_attach,
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true;
        }
      }
    }
  }
}
require('rust-tools').setup(opts)

