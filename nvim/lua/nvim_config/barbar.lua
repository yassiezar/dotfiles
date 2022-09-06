local Remap = require("nvim_config.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap
local opts = { silent = true }

nnoremap("<leader>1", "<cmd>BufferGoto 1<cr>", opts)
nnoremap("<leader>2", "<cmd>BufferGoto 2<cr>", opts)
nnoremap("<leader>3", "<cmd>BufferGoto 3<cr>", opts)
nnoremap("<leader>4", "<cmd>BufferGoto 4<cr>", opts)
nnoremap("<leader>5", "<cmd>BufferGoto 5<cr>", opts)
nnoremap("<leader>6", "<cmd>BufferGoto 6<cr>", opts)

nnoremap("<leader>c", "<cmd>BufferClose<cr>", opts)
nnoremap("<leader>C", "<cmd>BufferCloseAllButPinned<cr>", opts)
