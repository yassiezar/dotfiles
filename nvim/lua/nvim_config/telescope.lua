require('telescope').setup {
   extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- Enable fzf fuzzy search sorter
require('telescope').load_extension('fzf')
-- Enable frecency search
require('telescope').load_extension('frecency')

vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>lua require("telescope").extensions.frecency.frecency()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', { noremap = true, silent = true})
