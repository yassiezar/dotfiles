-- Buffer navigation
vim.api.nvim_set_keymap('n', '<A-1>', '<cmd>BufferGoto 1<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-2>', '<cmd>BufferGoto 2<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-3>', '<cmd>BufferGoto 3<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-4>', '<cmd>BufferGoto 4<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-5>', '<cmd>BufferGoto 5<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-6>', '<cmd>BufferGoto 6<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-7>', '<cmd>BufferGoto 7<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-8>', '<cmd>BufferGoto 8<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-9>', '<cmd>BufferGoto 8<cr>', { noremap = true, silent = true })

-- Close buffer
vim.api.nvim_set_keymap('n', '<A-c>', '<cmd>BufferClose<cr>', { noremap = true, silent = true })

-- Reorder tabs
vim.api.nvim_set_keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true })
