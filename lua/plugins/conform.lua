return {
  'stevearc/conform.nvim',
  opts = {
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black", "mypy" },
      },
    })
  },
}
