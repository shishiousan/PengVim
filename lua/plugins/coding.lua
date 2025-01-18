return {
  {
    "smoka7/multicursors.nvim",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        "<C-d>",
        "<cmd>MCstart<cr>",
        desc = "Multi cursor starts",
        mode = { "n", "v" },
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "bbjornstad/pretty-fold.nvim",
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
  -- {
  --   "anuvyklack/fold-preview.nvim",
  --   dependencies = "anuvyklack/keymap-amend.nvim",
  --   config = function()
  --     local fp = require("fold-preview")
  --     local map = require("fold-preview").mapping
  --     local keymap = vim.keymap
  --     keymap.amend = require("keymap-amend")
  --
  --     fp.setup({
  --       auto = false,
  --       default_keybindings = true,
  --       border = "single",
  --     })
  --   end,
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          vim.cmd("ccl")
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          vim.cmd("ccl")
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        filter = {
          fzf = {
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
          },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
    },
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
      pattern = "*",
      insert_mode = true,
      floating = false,
      disabled_filetypes = {},
      disabled_modes = {},
    },
    config = function(opts)
      require("scrollEOF").setup(opts)
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup({
        signs = {
          left = "",
          right = "",
          diag = "●",
          arrow = "    ",
          up_arrow = "    ",
          vertical = " │",
          vertical_end = " └",
        },
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        blend = {
          factor = 0.27,
        },
        options = {
          softwrap = 15,
          overflow = {
            mode = "wrap",
          },
          break_line = {
            enabled = false,
            after = 30,
          },
        },
      })
    end,
  },
  {
    "chrisbra/NrrwRgn",
    lazy = true,
    keys = {
      {
        "<leader>nr",
        "<plug>NrrwrgnDo<cr>",
        desc = "NrrwRgn",
        mode = { "n", "v" },
      },
    },
  },
  {
    "tzachar/highlight-undo.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("highlight-undo").setup({
        duration = 300,
        undo = {
          hlgroup = "HighlightUndo",
          mode = "n",
          lhs = "u",
          map = "undo",
          opts = {},
        },
        redo = {
          hlgroup = "HighlightRedo",
          mode = "n",
          lhs = "<C-r>",
          map = "redo",
          opts = {},
        },
        highlight_for_count = true,
      })
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    opts = {
      active = true,
      on_config_done = nil,
      manual_mode = false,
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git" },
      show_hidden = false,
      silent_chdir = true,
      ignore_lsp = {},
    },
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    config = function()
      require("overseer").setup({
        templates = {
          "user.baseDev",
          "user.baseInstall",
          "user.run_script",
          "user.classesDev",
          "user.classesInstall",
          "user.easifemLint",
          -- "user.smartLint",
        },
        component_aliases = {
          default = {
            "on_output_summarize",
            "on_exit_set_status",
            { "on_complete_notify", statuses = { "FAILURE", "SUCCESS" }, on_change = true },
            { "on_complete_dispose", statuses = { "SUCCESS", "FAILURE" } },
            {
              "on_result_diagnostics",
              virtual_text = true,
              remove_on_restart = true,
              signs = true,
              underline = true,
            },
            { "on_result_diagnostics_quickfix", open = false },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>or",
        "<cmd>OverseerRun<CR>",
        mode = { "n" },
        desc = "Overseer Run",
      },
      {
        "<leader>ot",
        "<cmd>OverseerToggle<CR>",
        mode = { "n" },
        desc = "Overseer Toggle",
      },
      {
        "<leader>oi",
        "<cmd>OverseerInfo<CR>",
        mode = { "n" },
        desc = "Overseer Info",
      },
    },
  },
  {
    "jaimecgomezz/here.term",
    keys = {
      {
        "<M-t>",
        function()
          require("here-term").toggle_terminal()
        end,
        mode = { "n", "i", "t" },
        desc = "Toggle Terminal Here",
      },
      {
        "<M-S-t>",
        function()
          require("here-term").kill_terminal()
        end,
        mode = { "n", "i", "t" },
        desc = "Kill Terminal Here",
      },
    },
  },
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true,
    },
    keys = {
      {
        "<leader>tj",
        "<cmd>Treewalker Down<CR>",
        mode = { "n" },
        desc = "TreeWalker Down",
      },
      {
        "<leader>tk",
        "<cmd>Treewalker Up<CR>",
        mode = { "n" },
        desc = "TreeWalker Up",
      },
      {
        "<leader>th",
        "<cmd>Treewalker Left<CR>",
        mode = { "n" },
        desc = "TreeWalker Left",
      },
      {
        "<leader>tl",
        "<cmd>Treewalker Right<CR>",
        mode = { "n" },
        desc = "TreeWalker Right",
      },
    },
  },
  {
    "andymass/vim-matchup",
    enabled = false,
    lazy = false,
    config = function()
      vim.g.matchup_matchparen_offscreen = {
        method = "popup",
      }
    end,
  },
}
