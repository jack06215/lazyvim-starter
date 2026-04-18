return {
  "folke/noice.nvim",
  cond = function()
    return not vim.g.vscode
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      routes = {
        -- Hide pyright progress spam
        {
          filter = {
            event = "lsp",
            kind = "progress",
            find = "pyright",
          },
          opts = { skip = true },
        },
      },
    })
  end,
}
