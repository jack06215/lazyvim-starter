# Comment.nvim

Comment.nvim is a powerful plugin designed to enhance commenting workflows in Neovim. With its intuitive features and flexible configuration, it simplifies the process of commenting code in various programming languages. Key highlights include:

- **Context-Aware Commenting**: Leverages `nvim-ts-context-commentstring` to provide precise comment strings for specific file types, such as TypeScript React.
- **Utility Functions**: Offers utility functions to determine and manipulate comments efficiently.
- **Customizable Key Mappings**: Includes basic and extra key mappings for toggling comments, making backups, and more.

This plugin is a must-have for developers looking to streamline their coding experience in Neovim.

## Installation

To use Comment.nvim, install it using your preferred plugin manager. For example, with [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "numToStr/Comment.nvim",
  requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup({
      ignore = "^$", -- Ignore empty lines when commenting.
      mappings = {
        basic = true, -- Enable basic key mappings.
        extra = true, -- Enable extra key mappings.
      },
      pre_hook = function(ctx)
        if vim.bo.filetype == "typescriptreact" then
          local U, location = require("Comment.utils"), nil
          if ctx.ctype == U.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end
          return require("ts_context_commentstring.internal").calculate_commentstring({
            key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline",
            location = location,
          })
        end
        return nil
      end,
    })
  end,
}
```

## Key Mappings

Comment.nvim provides several key mappings to enhance your commenting workflow. Below are the default key mappings:

- **Basic Toggle Comments**:
  - `gcc`: Toggle comment for the current line (normal mode).
  - `gc`: Toggle comment for the selected region (visual mode).

- **Backup and Comment**:
  - `gcb`: Create a backup of the current line and toggle comment (normal mode).

- **Invert Comments**:
  - `gC`: Invert comments using a custom operator function (normal and visual modes).

- **Add Comment to End of Line**:
  - `gcA`: Add a comment at the end of the current line (normal mode).

## Utility Functions

Comment.nvim also includes utility functions for advanced users and developers. These functions allow for custom behaviors and integrations. Below is an example:

- **Determine if a Line is Commented**:

  ```lua
  local utils = require("plugins.comment.utils")

  local line = "-- This is a commented line"
  local commentstring = vim.bo.commentstring

  local is_commented = utils.is_commented_line(line, commentstring)
  print(is_commented)  -- Output: true
  ```

  This utility checks whether a given line is commented based on the provided `commentstring`. It can be useful for creating additional comment-related features or integrating with other plugins.
