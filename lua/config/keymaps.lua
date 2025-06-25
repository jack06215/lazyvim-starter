-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- General Keymaps
vim.keymap.set("n", "<leader>ul", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle Relative Line Numbers" })

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
