local base = require('lsp.base')

-- tex setup
require'lspconfig'.texlab.setup{
  on_attach = base.on_attach,
  flags = base.flags,
  capabilities = base.capabilities,
}

