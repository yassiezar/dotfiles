require("nvim_config.set")
require("nvim_config.packer")
require("nvim_config.statusline")
require("nvim_config.telescope")
require("nvim_config.barbar")
require("nvim_config.nvim_tree")

-- Linting autocmd
require("lint").linters_by_ft = {
    python = {"pylint"},
    cpp = {"cppcheck", "clangtidy"}
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

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

vim.api.nvim_set_keymap('n', 'j', 'v:count == 0 ? "gj" : "j"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('n', 'k', 'v:count == 0 ? "gk" : "k"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'zz', ':noh<cr><esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<esc>:m .+1<cr>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<esc>:m .-2<cr>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<cr>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<cr>gv=gv", { noremap = true, silent = true })
