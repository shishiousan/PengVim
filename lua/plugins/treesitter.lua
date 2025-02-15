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
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "bash",
        "bibtex",
        "c",
        "css",
        "csv",
        "diff",
        "fish",
        "fortran",
        "gitcommit",
        "git_config",
        "gitignore",
        "go",
        "html",
        "json",
        "julia",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "tmux",
        "typst",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = false,
      indent = {
        enable = true,
        disable = { "julia", "fortran" },
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@conditional.outer",
            ["]a"] = "@class.outer",
            ["]b"] = "@block.outer",
            ["]l"] = "@loop.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@conditional.outer",
            ["]A"] = "@class.outer",
            ["]B"] = "@block.outer",
            ["]L"] = "@loop.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@conditional.outer",
            ["[a"] = "@class.outer",
            ["[b"] = "@block.outer",
            ["[l"] = "@loop.outer",
          },
          goto_previous_end = {
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
