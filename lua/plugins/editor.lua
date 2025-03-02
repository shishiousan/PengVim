return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          style = {
            "#00ffff",
            "#c21f30",
          },
          exclude_filetypes = {
            toml = true,
          },
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
          style = "#b30eec",
          use_treesitter = true,
          exclude_filetypes = {
            toml = true,
          },
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = {
        enabled = true,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            -- kind = "lua_error",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },
  { -- cool window motion
    "anuvyklack/windows.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "anuvyklack/middleclass",
      -- "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup({
        ignore = {
          buftype = { "quickfix", "terminal" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
        },
        animation = {
          -- NOTE: uncomment animation.nvim to enable
          enable = false,
        },
        autowidth = {
          enable = false,
        },
      })
    end,
    keys = {
      {
        "<leader>wt",
        "<cmd>WindowsToggleAutowidth<CR>",
        desc = "Toggle Autowidth",
      },
      {
        "<C-w>z",
        "<cmd>WindowsMaximize<CR>",
        desc = "WindowsMaximize",
      },
      {
        "<C-w>=",
        "<cmd>WindowsEqualize<CR>",
        desc = "WindowsEqualize",
      },
      {
        "<C-w>_",
        "<cmd>WindowsMaximizeVertically<CR>",
        desc = "WindowsMaximizeVertically",
      },
      {
        "<C-w>|",
        "<cmd>WindowsMaximizeHorizontally<CR>",
        desc = "WindowsMaximizeHorizontally",
      },
    },
  },
  {
    "bbjornstad/pretty-fold.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("pretty-fold").setup({
        sections = {
          left = {
            "content",
          },
          right = {
            " ",
            "number_of_folded_lines",
            ": ",
            "percentage",
            " ",
            function(config)
              return config.fill_char:rep(3)
            end,
          },
        },
        fill_char = "•",
        remove_fold_markers = true,
        keep_indentation = true,
        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = "spaces",
        comment_signs = {},
        add_close_pattern = true, -- true, 'last_line' or false
        matchup_patterns = {
          { "{", "}" },
          { "%(", ")" },
          { "%[", "]" },
        },
        ft_ignore = { "neorg", "TelescopeResults", "ToggleTerm", "Noice", "sagaoutline", "dashboard" },
      })
      require("pretty-fold").ft_setup("lua", {
        matchup_patterns = {
          { "^%s*if", "end" },
          { "^%s*for", "end" },
          { "function%s*%(", "end" },
          { "{", "}" },
          { "%(", ")" },
          { "%[", "]" },
        },
      })
    end,
  },
  { -- keep the cursor in the middle
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    config = function()
      require("scrollEOF").setup({
        pattern = "*",
        insert_mode = true,
        floating = false,
        disabled_filetypes = {},
        disabled_modes = {},
      })
    end,
  },
}
