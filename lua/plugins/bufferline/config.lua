return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      mode = "buffers",

      -- Better numbering (clickable + readable)
      numbers = function(opts)
        return string.format("%s·%d", opts.raise(opts.id), opts.ordinal)
      end,

      -- LSP diagnostics integration
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return icon .. count
      end,

      -- UI
      separator_style = "slant",
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,

      -- Smart truncation
      truncate_names = true,
      max_name_length = 25,
      max_prefix_length = 15,

      -- Offsets (important if using neo-tree)
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },

      -- Sorting (very useful in monorepo)
      sort_by = "insert_after_current",

      -- Hover (nice UX)
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },

      -- Diagnostics update in insert mode (optional)
      diagnostics_update_in_insert = false,

      -- Indicator style
      indicator = {
        style = "icon",
        icon = "▎",
      },

      -- Groups
      groups = {
        items = {
          {
            name = "Tests",
            highlight = { underline = true, sp = "blue" },
            priority = 2,
            matcher = function(buf)
              return buf.name:match("_test") or buf.name:match("%.spec")
            end,
          },
          {
            name = "Config",
            highlight = { underline = true, sp = "yellow" },
            priority = 1,
            matcher = function(buf)
              return buf.name:match("config") or buf.name:match("%.json")
            end,
          },
        },
      },
    },
  },
}
