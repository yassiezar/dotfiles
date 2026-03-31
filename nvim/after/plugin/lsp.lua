local lsp = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'clangd',
    'texlab',
    'lua_ls',
    'gopls',
    'ruff',
    'pyright',
  },
  handlers = {
    lsp.default_setup,
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
    pyright = function()
      require('lspconfig').pyright.setup({
        settings = {
          pyright = {
            -- Disable Pyright's import organizer in favor of Ruff
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Set this to 'strict' if you want heavy type checking
              typeCheckingMode = 'basic',
            }
          }
        }
      })
    end,
    ruff = function()
      require('lspconfig').ruff.setup({
        -- Disable Ruff's hover provider so it doesn't conflict with Pyright
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
        end
      })
    end,
    clangd = function()
      require('lspconfig').clangd.setup({
        cmd = {
          "clangd",
          "--clang-tidy",
          "--background-index",
          "--suggest-missing-includes",
          "--completion-style=bundled",
          "--header-insertion=iwyu",
          "--fallback-style=llvm",
          "--function-arg-placeholders"
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
    end,
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
