local base = require('lsp.base')
local util = require('lspconfig.util')

-- Python setup
require'lspconfig'.pylsp.setup {
  on_attach = base.on_attach,
  flags = base.flags,
  capabilities = base.capabilities,
  cmd = { 'pylsp' },
  root_dir = function(fname)
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile'
    }
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
  single_file_support = true,
  settings = {
    pylsp = {
      configurationSources = {"pycodestyle"},
      autopep8 = {
        enabled = false -- use yapf
      },
      yapf = {
        enabled = false,
      },
      pycodestyle = {
        enabled = true,
        indentSize = 4,
        maxLineLength = 80
      },
      flake8 = {
        enabled = false,
        indentSize = 4,
        maxLineLength = 80
      },
      rope = {
        enables = true,
      },
      mccabe = {
        enabled = true,
      },
      pyflakes = {
        enabled = true,
      },
      pylint = {
        enabled = false,
      }
    }
  }
}

