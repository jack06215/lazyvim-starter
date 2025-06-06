return {
  "yuki-yano/fuzzy-motion.vim",
  cmd = { "FuzzyMotion" },
  keys = {
    { "<CR>", "<CMD>FuzzyMotion<CR>", mode = { "n", "v", "x" } },
  },
  dependencies = {
    "vim-denops/denops.vim",
    "lambdalisue/vim-kensaku",
  },
  init = function()
    vim.g.fuzzy_motion_matchers = { "fzf", "kensaku" }
  end,
}