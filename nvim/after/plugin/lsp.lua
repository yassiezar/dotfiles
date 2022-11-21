local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd',  "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", bufopts)
  vim.keymap.set('n', 'vdd',  "<cmd>lua require('telescope.builtin').diagnostics()<cr>", bufopts)
  vim.keymap.set('n', 'vDD',  "<cmd>lua vim.diagnostic.open_float()<cr>", bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', 'vrr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'vrr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", bufopts)
  vim.keymap.set('n', 'vrn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'vca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.texlab.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

require'lspconfig'.clangd.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = {
      "clangd",
      "--clang-tidy",
      "--background-index",
      "--suggest-missing-includes",
      "--completion-style=bundled",
      "--header-insertion=iwyu"
    },
}

require'lspconfig'.pylsp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
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

-- require('lspconfig').pyright.setup{
--   on_attach = on_attach,
--   flags = lsp_flags,
--   capabilities = capabilities
-- }

