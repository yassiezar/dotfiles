-- Linting autocmd
require("lint").linters_by_ft = {
    python = {"pylint", "codespell"},
    cpp = {"codespell", "cpplint"},
    tex = {"chktex", "codespell"},
    cmake = {"cmakelint"},
    lua = {"luacheck", "codespell"},
    matlab = {"local_mlint", "codespell"},
    json = {"jsonlint", "codespell"},
    bash = {"shellcheck", "codespell"},
    sh = {"shellcheck", "codespell"},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Set pylint to work in virtualenv
require('lint').linters.pylint.cmd = 'python'
require('lint').linters.pylint.args = {'-m', 'pylint', '-f', 'json', '--max-line-length', '88'} --black default
