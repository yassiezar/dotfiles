-- local lsp_base = require('lsp_base')
-- 
-- -- Matlab setup
-- require'lsp_base'.lspconfig.matlabls.setup{
--   on_attach = lsp_base.on_attach,
--   flags = lsp_base.lsp_flags,
--   capabilities = lsp_base.capabilities,
-- }

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