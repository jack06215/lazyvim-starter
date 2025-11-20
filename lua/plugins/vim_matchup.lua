return {
  "andymass/vim-matchup",
  event = "BufReadPost",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  init = function()
    vim.g.matchup_surround_enabled = 1
    vim.g.matchup_delim_noskips = 1
    vim.g.matchup_matchparen_enabled = 1
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_timeout = 300
    vim.g.matchup_matchparen_insert_timeout = 60
  end,

  opts = {
    -- Treesitter 経由の設定は opts で書く（Lazy の正しい流儀）
    matchup = {
      enable = true,
      disable_virtual_text = false,
      include_match_words = true,
    },
  },
}
