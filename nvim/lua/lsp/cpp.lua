local base = require('lsp.base')

-- C++ setup
require'lspconfig'.clangd.setup{
  on_attach = base.on_attach,
  flags = base.flags,
  capabilities = base.capabilities,
  cmd = {
      "clangd",
      "--clang-tidy",
      "--background-index",
      "--suggest-missing-includes",
      "--completion-style=bundled",
      "--header-insertion=iwyu"
    },
}
