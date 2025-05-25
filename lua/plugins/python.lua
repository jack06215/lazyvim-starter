-- Tell LazyVim to use plain “pyright” for Python LSP
vim.g.lazyvim_python_lsp = "pyright"

local python_env = require("utils.python_env")

return {
  -- Treesitter: support requirements.txt
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "requirements" })
      end
    end,
  },

  -- Manage & upgrade entries in requirements.txt
  {
    "MeanderingProgrammer/py-requirements.nvim",
    event = { "BufRead requirements.txt" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ppu", function() require("py-requirements").upgrade()     end, desc = "Update Package"      },
      { "<leader>ppi", function() require("py-requirements").show_description() end, desc = "Package Info"        },
      { "<leader>ppa", function() require("py-requirements").upgrade_all() end, desc = "Update All Packages" },
    },
  },

  -- nvim-cmp: add both py-requirements & emoji sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "py-requirements" })
    end,
  },

  -- LSPConfig: configure pyright to use our cached pythonPath
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = python_env.get_path(),
            },
          },
        },
      },
    },
  },

  -- which-key: group all <leader>p… mappings
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>p",  group = " packages/dependencies" },
        { "<leader>pp", group = "python"                  },
      },
    },
  },
}
