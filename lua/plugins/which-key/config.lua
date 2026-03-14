return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      -- File search
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files",
      },

      -- Buffer
      { "<leader>b", group = "Buffer" },

      -- Python
      { "<leader>py", group = "Python" },

      -- package.json
      { "<leader>pj", group = "package.json" },

      { "<leader>g", group = "git" },
    },
  },
}
