local M = {
  prompt = [[
    Read my instruction and follow it carefully.

    <<INSTRUCTION START>>
    Generate a commit summary using conventional commit format from
    the output of a git diff that starts after the word <<DIFF START>>

    --------

    Only respond with the generated commit text.

    --------

    Example commit message:

    feat: add new feature

    - Add new feature
    - Update documentation
    - Fix bug in existing feature
    ...

    --------

    <<INSTRUCTION END>>

    <<DIFF START>>

  ]],
}

-- Utility function to get the staged git diff
local function get_staged_diff()
  local diff = vim.fn.system("git diff --cached")
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to get git diff", vim.log.levels.ERROR)
    return nil
  end
  return diff
end

-- Utility function to insert output at the cursor position
local function insert_at_cursor(output)
  local win = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(win)
  vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1] - 1, false, output)
  vim.api.nvim_win_set_cursor(win, { cursor[1] + #output, cursor[2] })
end

-- Function to generate commit summary using Ollama
local function generate_with_ollama(prompt, diff)
  -- Prepare input with prompt and diff
  local input_with_diff = prompt .. "\n" .. diff
  local json_payload = vim.json.encode({ model = "qwen2.5-coder:32b", prompt = input_with_diff, stream = false })

  -- Construct and execute command
  local command =
    string.format("curl -s -X POST http://localhost:11434/api/generate -d %s", vim.fn.shellescape(json_payload))
  local output = vim.fn.systemlist(command)

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to generate summary", vim.log.levels.ERROR)
    print(vim.inspect(output))
    return nil
  end

  -- Parse the JSON response
  local response = vim.fn.json_decode(table.concat(output, "\n"))
  if response and response.response then
    return vim.split(response.response, "\n")
  else
    vim.notify("Invalid response format", vim.log.levels.ERROR)
    return nil
  end
end

-- Function to generate commit summary using OpenAI Chat Completions
local function generate_with_openai(diff)
  -- Build the payload as a Lua table
  local payload = {
    model    = "gpt-4o-mini",
    messages = {
      {
        role    = "system",
        content = "You are a conventional commits summarizer. You take in git diff data and only respond with a concise but not lacking distinguishing details commit message and bullet-listed commit body in the format of conventional commits. Do not add any other text or formatting.",
      },
      {
        role    = "user",
        content = M.prompt .. diff,
      },
    },
    max_tokens = 1024,
    stream     = false,
  }

  -- Encode to JSON and write to a temp file
  local tmpfile = os.tmpname()
  local f = io.open(tmpfile, "w")
  if not f then
    vim.notify("Failed to write temp payload file", vim.log.levels.ERROR)
    return nil
  end
  f:write(vim.json.encode(payload))
  f:close()

  -- Send the request
  local cmd = string.format(
    'curl -s -X POST "https://api.openai.com/v1/chat/completions" ' ..
    '-H "Authorization: Bearer %s" ' ..
    '-H "Content-Type: application/json" ' ..
    '-d @%s',
    vim.fn.shellescape(os.getenv("OPENAI_API_KEY") or ""),
    vim.fn.shellescape(tmpfile)
  )
  local output = vim.fn.systemlist(cmd)
  os.remove(tmpfile)

  if vim.v.shell_error ~= 0 then
    vim.notify("OpenAI request failed", vim.log.levels.ERROR)
    print(table.concat(output, "\n"))
    return nil
  end

  -- Parse the response
  local ok, response = pcall(vim.json.decode, table.concat(output, "\n"))
  if not ok or
     not response.choices or
     not response.choices[1].message
  then
    vim.notify("Unexpected OpenAI response format", vim.log.levels.ERROR)
    return nil
  end

  -- Return the generated commit text lines
  local content = response.choices[1].message.content or ""
  return vim.split(content, "\n", { trimempty = true })
end

-- Summarize commit using Ollama
M.summarize_commit_ollama = function()
  local diff = get_staged_diff()
  if not diff then
    return
  end

  local output = generate_with_ollama(M.prompt, diff)
  if output then
    insert_at_cursor(output)
  end
end

-- Summarize commit using OpenAI
M.summarize_commit_openai = function()
  local diff = get_staged_diff()
  if not diff then
    return
  end

  local output = generate_with_openai(M.prompt, diff)
  if output then
    insert_at_cursor(output)
  end
end

return M