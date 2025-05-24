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

      -- Python venv
      local function python_venv()
        local venv = os.getenv("VIRTUAL_ENV")
          or os.getenv("CONDA_DEFAULT_ENV")
          or (function()
            local cwd = vim.fn.getcwd()
            if vim.fn.isdirectory(cwd .. "/.venv") == 1 then
              return ".venv"
            end
          end)()
        return venv and ("🐍 " .. vim.fn.fnamemodify(venv, ":t")) or ""
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
