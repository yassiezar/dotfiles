local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'rust_analyzer',
  'clangd',
  'pylsp',
  'texlab',
  'lua_ls',
  'matlab_ls',
})

lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' }
      }
    }
  }
})

require('lspconfig').matlab_ls.setup({
  -- cmd = { '/home/jlock/lsp_matlab' },
  settings = {
    matlab = {
      -- installPath = '/local-ssd/jlock/bautosar.latest_pass/matlab'
      installPath = '/home/jlock/MATLAB23b/'
    },
  },
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern(unpack({ 'mw_anchor' }))(fname) or util.find_git_ancestor(fname)
  end,
  single_file_support = true,
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  -- ['<Tab>'] = cmp.mapping(function(fallback)
  --     local col = vim.fn.col('.') - 1
  --     if require'neogen'.jumpable() then
  --       require'neogen'.jump_next()
  --     elseif cmp.visible() then
  --       cmp.select_next_item(cmp_select)
  --     elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
  --       fallback()
  --     else
  --       cmp.complete()
  --     end
  --   end, {'i', 's'}),
  -- ['<S-Tab>'] = cmp.mapping(function(fallback)
  --   if cmp.visible() then
  --     cmp.select_prev_item(cmp_select)
  --   else
  --     fallback()
  --   end
  -- end, {'i', 's'}),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
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

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
