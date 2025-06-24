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
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "json",
        "vim",
        "vimdoc",
      },
      auto_install = false,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["-f"] = "@function.outer",
            ["-c"] = "@conditional.outer",
            ["-a"] = "@class.outer",
            ["-b"] = "@block.outer",
            ["-l"] = "@loop.outer",
            ["]f"] = "@function.outer",
            ["]c"] = "@conditional.outer",
            ["]a"] = "@class.outer",
            ["]b"] = "@block.outer",
            ["]l"] = "@loop.outer",
          },
          goto_next_end = {
            ["--f"] = "@function.outer",
            ["--c"] = "@conditional.outer",
            ["--a"] = "@class.outer",
            ["--b"] = "@block.outer",
            ["--l"] = "@loop.outer",
            ["]F"] = "@function.outer",
            ["]C"] = "@conditional.outer",
            ["]A"] = "@class.outer",
            ["]B"] = "@block.outer",
            ["]L"] = "@loop.outer",
          },
          goto_previous_start = {
            ["_f"] = "@function.outer",
            ["_c"] = "@conditional.outer",
            ["_a"] = "@class.outer",
            ["_b"] = "@block.outer",
            ["_l"] = "@loop.outer",
            ["[f"] = "@function.outer",
            ["[c"] = "@conditional.outer",
            ["[a"] = "@class.outer",
            ["[b"] = "@block.outer",
            ["[l"] = "@loop.outer",
          },
          goto_previous_end = {
            ["__f"] = "@function.outer",
            ["__c"] = "@conditional.outer",
            ["__a"] = "@class.outer",
            ["__b"] = "@block.outer",
            ["__l"] = "@loop.outer",
            ["[F"] = "@function.outer",
            ["[C"] = "@conditional.outer",
            ["[A"] = "@class.outer",
            ["[B"] = "@block.outer",
            ["[L"] = "@loop.outer",
          },
        },
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aa"] = "@class.outer",
            ["ia"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ao"] = "@block.outer",
            ["io"] = "@block.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
