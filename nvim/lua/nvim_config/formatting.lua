local formatter = require('formatter')
local utils = require('formatter.util')

formatter.setup({
  logging = true,
  filetype = {
    cpp = {
      function()
        return{
          exe = "clang-format",
          -- args = {"--assume-filename", vim.api.nvim_buf_get_name(0), "--style", "google"},
          stdin = true,
          cwd = vim.fn.expand("%:p:h")
        }
      end
    },
    python = {
      function()
        local util = require "formatter.util"
        return{
          exe = "ruff",
          args = {
            "format",
            "--quiet",
            "--stdin-filename", util.escape_path(util.get_current_buffer_file_name()),
            "-"
          },
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
    json = {
      function()
        return {
          exe = "jq",
          args = { "--indent 4 ." },
          stdin = true,
        }
      end
    },
    go = {
      function()
        return {
          exe = "gofmt",
          args = { },
          stdin = true,
        }
      end
    },
    typescript = {
      function()
        return{
          exe = "tsfmt",
          args = {'-r'},
          stdin = false,
        }
      end
    },
    yaml = {
      function()
        return {
          exe = "yamlfmt",
          args = { "-in" },
          stdin = true,
        }
      end,
    },
    html = {
      function()
        return {
          exe = "pnpm prettier",
          args = { "--stdin-filepath", utils.get_current_buffer_file_name()},
          stdin = true,
        }
      end
    }
  }
})

vim.api.nvim_set_keymap('n', '<C-i>', "<cmd>Format<cr>", { noremap = true, silent = true })

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.py"}, command = "FormatWriteLock" })
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.go"}, command = "FormatWriteLock" })
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.cpp"}, command = "FormatWriteLock" })
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.html"}, command = "FormatWriteLock" })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.yaml", "*.yml"}, command = "FormatWriteLock" })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = {"*.json"}, command = "FormatWriteLock" })
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = {"*.rs"}, command = "lua vim.lsp.buf.format()" })
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = {"*.ts", "*.tsx"}, command = "lua vim.lsp.buf.format()" })
