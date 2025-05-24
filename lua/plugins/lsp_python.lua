return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = (function()
                local cwd = vim.fn.getcwd()
                local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
                return is_windows and (cwd .. "\\.venv\\Scripts\\python.exe")
                                  or (cwd .. "/.venv/bin/python")
              end)(),
            },
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
