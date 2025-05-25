local M = {
  cached = "",
}

-- runs your Poetry-first + sysname fallback logic
local function detect_venv()
  local cwd    = vim.fn.getcwd()
  local sys    = vim.loop.os_uname().sysname

  -- Poetry
  local p = vim.fn.trim(vim.fn.system("poetry env info -p"))
  if vim.v.shell_error == 0 and p ~= "" then
    return vim.fn.fnamemodify(p, ":t")
  end

  -- Windows
  if sys == "Windows_NT" then
    return vim.fn.fnamemodify(cwd .. "\\.venv\\Scripts\\python.exe", ":t")
  end
  -- Termux
  if sys == "Linux" and vim.fn.has("android") == 1 and vim.fn.executable("termux-setup-storage") == 1 then
    return "termux-python"
  end
  -- default .venv
  return vim.fn.fnamemodify(cwd .. "/.venv/bin/python", ":t")
end

-- update cache
function M.update()
  M.cached = detect_venv()
end

-- auto-refresh cache when it makes sense
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "DirChanged" }, {
  callback = function() M.update() end,
})

-- initial populate
M.update()

return M
