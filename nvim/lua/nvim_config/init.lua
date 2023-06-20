require("nvim_config.set")
require("nvim_config.packer")
require("nvim_config.statusline")
require("nvim_config.telescope")
require("nvim_config.barbar")
require("nvim_config.nvim_tree")
require("nvim_config.cmp")
require("nvim_config.formatting")
require("nvim_config.snippet")
require("nvim_config.lint")

-- Load if on a Mathworks machine
require("nvim_config.mathworks")

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
-- Autocmd to close quickfix upon selecting an item
--local autocmd = vim.api.nvim_create_autocmd
--autocmd({ "BufLeave" }, { pattern = { "*" }, command = "if &buftype == 'quickfix'|q|endif" })
vim.api.nvim_create_autocmd({ "BufLeave"}, { pattern = {"*"}, command = "if &buftype == 'quickfix'|q|endif" })

-- Cursorline setup
require('nvim-cursorline').setup {
  cursorline = {
    enable = false,
  },
  cursorword = {
    enable = true,
    min_length = 1,
    hl = { underline = true },
  }
}

-- disable mouse

local opts = { noremap = true, silent = true}
vim.api.nvim_set_keymap('n', 'j', 'v:count == 0 ? "gj" : "j"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('n', 'k', 'v:count == 0 ? "gk" : "k"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', opts)
vim.api.nvim_set_keymap('n', 'zz', ':noh<cr><esc>', opts)
vim.api.nvim_set_keymap('i', '<A-j>', '<esc>:m .+1<cr>==gi', opts)
vim.api.nvim_set_keymap('i', '<A-k>', '<esc>:m .-2<cr>==gi', opts)
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<cr>gv=gv", opts)
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<cr>gv=gv", opts)
vim.api.nvim_set_keymap('n',  '<leader>doc', '<cmd>lua require("neogen").generate()<cr>', opts)

vim.api.nvim_set_keymap('n', "<leader>y", [["+y]], opts)
vim.api.nvim_set_keymap('v', "<leader>y", [["+y]], opts)
vim.api.nvim_set_keymap('n', "<leader>Y", [["+Y]], opts)
