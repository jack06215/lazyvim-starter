local config_path = vim.fn.stdpath("config")

return {
  dir = config_path .. "/lua/utils",
  ft = "gitcommit",
  keys = {
    {
      "<leader>ail",
      function()
        require("utils.summarize_commit").summarize_commit_ollama()
      end,
      ft = "gitcommit",
      desc = "[Ollama] Summarize commit",
    },
    {
      "<leader>aio",
      function()
        require("utils.summarize_commit").summarize_commit_openai()
      end,
      ft = "gitcommit",
      desc = "[OpenAI] Summarize commit",
    },
  },
}