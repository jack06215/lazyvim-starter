-- Return a flat list of all plugin specs from separate files
return vim.tbl_flatten({
  
  require("plugins.colors"),
  require("plugins.extras"),
  require("plugins.fzf"),
  require("plugins.lsp"),
  require("plugins.mason"),
  require("plugins.python"),
  require("plugins.telescope"),
  require("plugins.todo_comments"), 
  require("plugins.treesitter"),
  require("plugins.typescript"),
  require("plugins.ui"),
})
