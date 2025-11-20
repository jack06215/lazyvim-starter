return {

  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          keys = {
            {
              "<leader>co",
              "<cmd>TSToolsOrganizeImports<CR>",
              desc = "Organize Imports",
              has = "workspace.executeCommand",
            },
            { "<leader>cR", "<cmd>TSToolsRenameFile<CR>", desc = "Rename File", has = "workspace.executeCommand" },
          },
        },
      },
    },
  },

  -- Optionally import LazyVim TS settings
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
