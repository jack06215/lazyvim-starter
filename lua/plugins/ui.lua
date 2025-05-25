return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Current Directory
      local function current_directory()
        return "📁 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end

      -- Active LSP
      local function active_lsp()
        local buf_ft = vim.bo.filetype
        local clients = vim.lsp.get_active_clients()
        for _, client in ipairs(clients) do
          if client.config and client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
            return "🔧 " .. client.name
          end
        end
        return "🔧 No LSP"
      end

      -- Python venv with Poetry-first and sysname fallbacks
      local function python_venv()
        local cwd    = vim.fn.getcwd()
        local sysname = vim.loop.os_uname().sysname

        -- Try Poetry
        local poetry_env = vim.fn.system("poetry env info -p")
        poetry_env = vim.fn.trim(poetry_env)
        if vim.v.shell_error == 0 and poetry_env ~= "" then
          if sysname == "Windows_NT" then
            return "🐍 " .. vim.fn.fnamemodify(poetry_env, ":t")
          else
            return "🐍 " .. vim.fn.fnamemodify(poetry_env, ":t")
          end
        end

        -- Fallbacks
        if sysname == "Windows_NT" then
          return "🐍 " .. vim.fn.fnamemodify(cwd .. "\\.venv\\Scripts\\python.exe", ":t")
        elseif sysname == "Linux" and vim.fn.has("android") == 1 and vim.fn.executable("termux-setup-storage") == 1 then
          return "🐍 termux-python"
        else
          return "🐍 " .. vim.fn.fnamemodify(cwd .. "/.venv/bin/python", ":t")
        end
      end

      -- Git branch
      local function git_branch()
        local branch = vim.b.gitsigns_head
        return branch and (" " .. branch) or ""
      end

      -- Add them to lualine_x
      vim.list_extend(opts.sections.lualine_x, {
        current_directory,
        active_lsp,
        python_venv,
        git_branch,
      })
    end,
  },
}