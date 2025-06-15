return {
  'stevearc/conform.nvim',
  opts = {
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black", "mypy" },
        typescriptreact = { "prettier" },
        typescript = { "prettier" },
      },
    }),
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        -- Wiat for 3 seconds.
        require("conform").format({ bufnr = args.buf, timeout_ms = 5000 })
      end,
    })
  },
}
