-- Return a flat list of all plugin specs from separate files
return vim.tbl_flatten({
  
  require("plugins.colors"),
  require("plugins.extras"),
  require("plugins.fzf"),
  require("plugins.lsp_python"),
  require("plugins.lsp_typescript"),
  require("plugins.mason"),
  require("plugins.telescope"),
  require("plugins.todo_comments"), 
  require("plugins.treesitter"),
  require("plugins.ui"),
})
