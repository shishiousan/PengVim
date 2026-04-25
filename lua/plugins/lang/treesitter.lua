return {
  { -- incrementally select a part of code with enter
    "sustech-data/wildfire.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    "aaronik/treewalker.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      highlight = false,
      highlight_duration = 250,

      highlight_group = "CursorLine",

      jumplist = true,
    },
    keys = {
      {
        "<leader>tj",
        ":Treewalker Down<CR>",
        desc = "Go to next node",
      },
      {
        "<leader>tk",
        ":Treewalker Up<CR>",
        desc = "Go to previous node",
      },
      {
        "<leader>tl",
        ":Treewalker Right<CR>",
        desc = "Go to further indented node",
      },
      {
        "<leader>th",
        ":Treewalker Left<CR>",
        desc = "Go to ancestor node",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
    opts = {
      ensure_installed = {
        "json",
        "vim",
        "vimdoc",
        "bash",
        "fish",
        "tmux",
        "diff",
        "gitcommit",
        "gitignore",
        "git_config",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)
      require("nvim-treesitter").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    opts = {
      move = {
        set_jumps = true,
      },
      select = {
        lookahead = true,
        selection_modes = {
          -- "v" for charwise "V" for linewise "<c-v>" for blockwise
          ["@function.inner"] = "V",
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
          ["@class.inner"] = "V",
          ["@loop.outer"] = "V",
          ["@loop.inner"] = "V",
          ["@conditional.outer"] = "V",
          ["@conditional.inner"] = "V",
          ["@block.outer"] = "V",
          ["@block.inner"] = "V",
        },
        include_surrounding_whitespace = false,
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter-textobjects")

      TS.setup(opts)

      local function next_start(modes, keys, object)
        vim.keymap.set(modes, keys, function()
          require("nvim-treesitter-textobjects.move").goto_next_start(object, "textobjects")
        end, { desc = object })
      end

      local function next_end(modes, keys, object)
        vim.keymap.set(modes, keys, function()
          require("nvim-treesitter-textobjects.move").goto_next_end(object, "textobjects")
        end, { desc = object })
      end

      local function previous_start(modes, keys, object)
        vim.keymap.set(modes, keys, function()
          require("nvim-treesitter-textobjects.move").goto_previous_start(object, "textobjects")
        end, { desc = object })
      end

      local function previous_end(modes, keys, object)
        vim.keymap.set(modes, keys, function()
          require("nvim-treesitter-textobjects.move").goto_pervious_end(object, "textobjects")
        end, { desc = object })
      end

      local function select(modes, keys, object)
        vim.keymap.set(modes, keys, function()
          require("nvim-treesitter-textobjects.select").select_textobject(object, "textobjects")
        end, { desc = object })
      end

      local modes = { "n", "x", "o" }
      next_start(modes, "-f", "@function.outer")
      next_start(modes, "-c", "@conditional.outer")
      next_start(modes, "-a", "@class.outer")
      next_start(modes, "-b", "@block.outer")
      next_start(modes, "-l", "@loop.outer")
      next_start(modes, "]f", "@function.outer")
      next_start(modes, "]c", "@conditional.outer")
      next_start(modes, "]a", "@class.outer")
      next_start(modes, "]b", "@block.outer")
      next_start(modes, "]l", "@loop.outer")

      next_end(modes, "--f", "@function.outer")
      next_end(modes, "--c", "@conditional.outer")
      next_end(modes, "--a", "@class.outer")
      next_end(modes, "--b", "@block.outer")
      next_end(modes, "--l", "@loop.outer")
      next_end(modes, "]F", "@function.outer")
      next_end(modes, "]C", "@conditional.outer")
      next_end(modes, "]A", "@class.outer")
      next_end(modes, "]B", "@block.outer")
      next_end(modes, "]L", "@loop.outer")

      previous_start(modes, "_f", "@function.outer")
      previous_start(modes, "_c", "@conditional.outer")
      previous_start(modes, "_a", "@class.outer")
      previous_start(modes, "_b", "@block.outer")
      previous_start(modes, "_l", "@loop.outer")
      previous_start(modes, "[f", "@function.outer")
      previous_start(modes, "[c", "@conditional.outer")
      previous_start(modes, "[a", "@class.outer")
      previous_start(modes, "[b", "@block.outer")
      previous_start(modes, "[l", "@loop.outer")

      previous_end(modes, "__f", "@function.outer")
      previous_end(modes, "__c", "@conditional.outer")
      previous_end(modes, "__a", "@class.outer")
      previous_end(modes, "__b", "@block.outer")
      previous_end(modes, "__l", "@loop.outer")
      previous_end(modes, "[F", "@function.outer")
      previous_end(modes, "[C", "@conditional.outer")
      previous_end(modes, "[A", "@class.outer")
      previous_end(modes, "[B", "@block.outer")
      previous_end(modes, "[L", "@loop.outer")

      modes = { "x", "o" }
      select(modes, "af", "@function.outer")
      select(modes, "if", "@function.inner")
      select(modes, "aa", "@class.outer")
      select(modes, "ia", "@class.inner")
      select(modes, "al", "@loop.outer")
      select(modes, "il", "@loop.inner")
      select(modes, "ac", "@conditional.outer")
      select(modes, "ic", "@conditional.inner")
      select(modes, "ao", "@block.outer")
      select(modes, "io", "@block.inner")
    end,
  },
}
