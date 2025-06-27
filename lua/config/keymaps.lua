-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- General Keymaps
vim.keymap.set("n", "<leader>ul", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Relative Line Numbers" })

vim.keymap.set("n", "<leader>bo", function()
  vim.cmd("%bd|e#")
end, { desc = "Delete Other Buffers" })

vim.keymap.set("n", "<leader>bx", function()
  vim.cmd("bufdo bd")
end, { desc = "Delete All Buffers" })

-- Delete buffers to the right of current buffer
vim.keymap.set("n", "<leader>br", function()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local found = false
  for _, buf in ipairs(bufs) do
    if found and buf.bufnr ~= current then
      vim.cmd("bd " .. buf.bufnr)
    end
    if buf.bufnr == current then
      found = true
    end
  end
end, { desc = "Delete Buffers to the Right" })

-- Delete buffers to the left of current buffer
vim.keymap.set("n", "<leader>bl", function()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  for _, buf in ipairs(bufs) do
    if buf.bufnr == current then break end
    vim.cmd("bd " .. buf.bufnr)
  end
end, { desc = "Delete Buffers to the Left" })

-- LazyVim
vim.keymap.del("n", "<leader>gG")


-- Neogit
vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open Neogit" })

-- Package Info
-- Package Info keymaps (only active in JSON files)
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
