vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
  term_colors = true,
  transparent_background = false,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  integrations = {
    telescope = true,
    barbar = true,
    cmp = true,
    nvimtree = true,
    treesitter = true,
  }
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd("Catppuccin " .. (vim.v.option_new == "light" and "latte" or "mocha"))
  end,
})

vim.cmd "colorscheme catppuccin"
