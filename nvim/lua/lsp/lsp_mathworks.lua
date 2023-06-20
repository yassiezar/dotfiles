local base = require('lsp.base')
local util = require('lspconfig.util')

local root_files = { 'mw_anchor' }
-- Matlab setup
require'lspconfig'.matlab_ls.setup {
  cmd = { '/home/jlock/lsp_matlab' },
  on_attach = base.on_attach,
  flags = base.lsp_flags,
  capabilities = base.capabilities,
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
  single_file_support = true,
}

-- local lspconfig = require'lspconfig'
-- lspconfig.mw_ccls.setup {
--   init_options = {
--     compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   }
-- }
