require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  },
  view = {
    adaptive_size = true,
    width = 25,
    number = true,
    relativenumber = true
  }
})

local Remap = require("nvim_config.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap
local opts = { silent = true }

nnoremap("<leader>tt", "<cmd>NvimTreeToggle<cr>", opts)
nnoremap("<leader>tf", "<cmd>NvimTreeFocus<cr>", opts)
