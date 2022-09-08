require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  },
  view = {
    adaptive_size = true,
    width = 25,
    number = true,
    relativenumber = true,
  },
  actions = {
    open_file = {
        quit_on_open = true,
    },
  },
  filters = {
    custom = { "^.git$" } 
  },
})

vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>NvimTreeFocus<cr>', { noremap = true, silent = true })
