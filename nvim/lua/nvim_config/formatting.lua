local formatter = require('formatter')
formatter.setup({
  logging = true,
  filetype = {
    cpp = {
      function()
        return{
          exe = "clang-format",
          args = {"--assume-filename", vim.api.nvim_buf_get_name(0), "--style", "google"},
          stdin = true,
          cwd = vim.fn.expand("%:p:h")
        }
      end
    },
    python = {
      function()
        return{
          exe = "yapf",
          stdin = true,
        }
      end
    },
    rust = {
      function()
        return{
          exe = "rustfmt",
          args = { vim.api.nvim_buf_get_name(0) },
          cwd = vim.fn.expand("%:p:h")
        }
      end
    },
  }
})

vim.api.nvim_set_keymap('n', '<C-i>', "<cmd>FormatWrite<cr>", { noremap = true, silent = true })

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.py"}, command = "FormatWrite" })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.cpp"}, command = "FormatWrite" })
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = {"*.rs"}, command = "lua vim.lsp.buf.format()" })
