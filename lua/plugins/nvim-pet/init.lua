return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/vendor/pets.nvim",
    name = "pets.nvim",
    lazy = false,
    dependencies = {
      "edluffy/hologram.nvim",
    },
    config = function()
      require("pets").setup({})
    end,
  },
}
