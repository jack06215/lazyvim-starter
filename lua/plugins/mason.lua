return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
    config = function(_, opts)
      local mason = require("mason")
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Apply ensure_installed from opts
      local registry = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed or {}) do
        local ok, pkg = pcall(registry.get_package, tool)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
}
