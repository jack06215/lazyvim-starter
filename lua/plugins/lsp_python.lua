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
                local sysname = vim.loop.os_uname().sysname

                -- Try Poetry
                local poetry_env = vim.fn.system('poetry env info -p')
                poetry_env = vim.fn.trim(poetry_env)
                if vim.v.shell_error == 0 and poetry_env ~= "" then
                  if sysname == "Windows_NT" then
                    return poetry_env .. "\\Scripts\\python.exe"
                  else
                    return poetry_env .. "/bin/python"
                  end
                end

                -- Fallbacks
                if sysname == "Windows_NT" then
                  return cwd .. "\\.venv\\Scripts\\python.exe"
                -- Termux on Android
                elseif sysname == "Linux" and vim.fn.has("android") == 1 and vim.fn.executable("termux-setup-storage") == 1 then
                  return "/data/data/com.termux/files/usr/bin/python"
                else
                  return cwd .. "/.venv/bin/python"
                end
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
