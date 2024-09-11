-- Linting
local pattern = "L (%d+) %(C (%d+)[-]?([%d]*)%): (.-): (.-): (.*)"
local groups = { "lnum", "col", "end_col", "code", "severity", "message" }
local severities = {
  ML2 = vim.diagnostic.severity.ERROR,
  ML3 = vim.diagnostic.severity.ERROR,
  ML4 = vim.diagnostic.severity.ERROR,
  ML1 = vim.diagnostic.severity.WARN,
  ML0 = vim.diagnostic.severity.INFO,
  ML5 = vim.diagnostic.severity.HINT,
}

require('lint').linters.local_mlint = {
  cmd = "/mathworks/devel/jobarchive/Bmain/latest_pass/matlab/bin/glnxa64/mlint",
  stdin = false,
  stream = "both",
  args = { "-cyc", "-id", "-severity" },
  ignore_exitcode = true,
  parser = require("lint.parser").from_pattern(pattern, groups, severities, { ["source"] = "local_mlint" }),
}

