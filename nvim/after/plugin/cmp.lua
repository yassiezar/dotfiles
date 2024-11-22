local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local luasnip = require('luasnip')
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item({behavior = 'select'})
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    -- Super shift tab
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      local luasnip = require('luasnip')

      if cmp.visible() then
        cmp.select_prev_item({behavior = 'select'})
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'cody' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'codeium' },
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = require('lspkind').cmp_format({
      fields = {'kind', 'abbr', 'menu'},
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = { Codeium = "", },
      menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        nvim_lua = "[Lua]",
        codeium = "[AI]",
        cody = "[AI]",
      })
    })
  },
  -- flip menu upside down when cursor at bottof screen
  view = {
    entries = {name = 'custom', selection_order = 'near_cursor' }
  },
  experimental = {
    -- Add ghost text
    ghost_text = true,
  }
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'async_path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
