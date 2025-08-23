local M = {}

M.create_keymaps = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
      local pkg = require("package-info")
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = true }

      map("n", "<leader>ns", pkg.show, vim.tbl_extend("force", opts, { desc = "Show package versions" }))
      map("n", "<leader>nc", pkg.hide, vim.tbl_extend("force", opts, { desc = "Clear package versions" }))
      map("n", "<leader>nu", pkg.update, vim.tbl_extend("force", opts, { desc = "Update dependency" }))
      map("n", "<leader>nd", pkg.delete, vim.tbl_extend("force", opts, { desc = "Delete dependency" }))
      map("n", "<leader>ni", pkg.install, vim.tbl_extend("force", opts, { desc = "Install dependency" }))
      map("n", "<leader>np", pkg.change_version, vim.tbl_extend("force", opts, { desc = "Change dependency version" }))
    end,
  })
end

return M
