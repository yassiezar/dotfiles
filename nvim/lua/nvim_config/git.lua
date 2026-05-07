-- Don't import the neogit package here, its being lazy-loaded
vim.keymap.set(
    "n",
    "<leader>vc",
    "<cmd>Neogit<CR>",
    { desc = "Open Neogit UI" }
)
