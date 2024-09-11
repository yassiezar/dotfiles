local lsp = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'clangd',
    -- remember to install the MyPy plugin
    'pylsp',
    'texlab',
    'lua_ls',
    'matlab_ls',
  },
  handlers = {
    lsp.default_setup,
    matlab_ls = function()
      require('lspconfig').matlab_ls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          matlab = {
            installPath = '/home/jlock/MATLAB/R2024a',
          },
        },
        root_dir = function(fname)
          local util = require('lspconfig.util')
          return util.root_pattern(unpack({ 'mw_anchor' }))(fname) or util.find_git_ancestor(fname)
        end,
        single_file_support = true,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' }
            }
          }
        }
      })
    end,
    pylsp = function()
      require('lspconfig').pylsp.setup({})
    end
  },
})

lsp.set_sign_icons({
  error = 'E',
  warn = 'W',
  hint = 'H',
  info = 'I'
})

lsp.on_attach(function(client, bufnr)
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
end)

vim.diagnostic.config({
  virtual_text = true
})
