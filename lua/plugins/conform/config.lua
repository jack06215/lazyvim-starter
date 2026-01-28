return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      jsonnet = { "jsonnetfmt" },
      json = { "jq" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      -- zsh = { "shfmt" },
      bazel = { "buildifier" },
      bzl = { "buildifier" },
    },
    -- tell Conform how to run
    formatters = {
      shfmt = {
        command = "shfmt",
        args = {
          "-ln",
          "bash", -- closest match for zsh
          "-i",
          "2",
          "-ci",
          "-sr",
          "-bn",
        },
        stdin = true,
      },
    },
  },
  keys = require("plugins.conform.keymaps"),
}
