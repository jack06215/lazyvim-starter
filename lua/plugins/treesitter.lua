return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      -- force git instead of curl
      local install = require("nvim-treesitter.install")
      install.prefer_git = true

      -- ensure a compiler is available
      install.compilers = { "gcc", "clang" }
    end,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "json5",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
      opts.auto_install = true
    end,
  },
}