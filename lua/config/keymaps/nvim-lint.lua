local M = {}

M.create_keymaps = function()
  local lint = require("lint")
  vim.keymap.set("n", "<leader>l", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })
end

return M
