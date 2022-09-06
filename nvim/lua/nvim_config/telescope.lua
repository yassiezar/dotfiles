require('telescope').load_extension('frecency')
-- Needs colcon (ROS2)
require('telescope').load_extension('ros')

local Remap = require("nvim_config.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap
local opts = { silent = true }

nnoremap("<leader>fc", "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>", opts)
nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
nnoremap("<leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", opts)
