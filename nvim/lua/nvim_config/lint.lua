-- Linting autocmd
require("lint").linters_by_ft = {
    python = {"pylint", "codespell"},
    cpp = {"codespell", "cpplint"},
    tex = {"chktex", "codespell"},
    cmake = {"cmakelint"},
    lua = {"luacheck", "codespell"},
    matlab = {"local_mlint", "codespell"},
    json = {"jsonlint", "codespell"},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

