require('telescope').load_extension('frecency')
-- Needs colcon (ROS2)
require('telescope').load_extension('ros')

vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>lua require("telescope").extensions.frecency.frecency()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', { noremap = true, silent = true})
