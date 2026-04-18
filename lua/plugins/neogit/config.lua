return {
  "NeogitOrg/neogit",
  lazy = false,
  -- cmd = { "Neogit" },
  -- keys = {
  --   {
  --     "<leader>gg",
  --     function() require("neogit").open() end,
  --     desc = "Open Neogit",
  --   },
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
        telescope = true,
      },
      process_spinner = false,
      disable_line_numbers = false,
      disable_relative_line_numbers = false,
      kind = "split", -- avoid floating process window issues
    })
  end,
}
