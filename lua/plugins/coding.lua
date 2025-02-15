return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = false,
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
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
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
    "rachartier/tiny-inline-diagnostic.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tiny-inline-diagnostic").setup({
        signs = {
          left = "",
          right = "",
          diag = "󰻀",
          arrow = "   ",
          up_arrow = "   ",
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
    keys = {
      {
        "<leader>uh",
        function()
          require("tiny-inline-diagnostic").toggle()
        end,
        desc = "Toggle Inline Diagnostic",
      },
    },
  },
  {
    "chrisbra/NrrwRgn",
    lazy = true,
    keys = {
      {
        "<leader>cr",
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
        ignored_filetypes = {
          "snacks_picker_list",
          "snacks_picker_preview",
          "oil",
        },
      })
    end,
  },
}
