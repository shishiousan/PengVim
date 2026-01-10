return {
  {
    "echasnovski/mini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })
      require("mini.icons").setup()
      -- require("mini.files").setup()
    end,
    keys = {
      {
        "<leader>aB",
        function()
          vim.fn.execute("normal gsaiw}")
        end,
        desc = "Add {} surround word",
      },
      {
        "<leader>ab",
        function()
          vim.fn.execute("normal gsaiw)")
        end,
        desc = "Add () surround word",
      },
      {
        '<leader>a"',
        function()
          vim.fn.execute('normal gsaiw"')
        end,
        desc = 'Add " surround word',
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    config = function()
      require("colorizer").setup({})
    end,
    keys = {
      {
        "<leader>uH",
        "<cmd>ColorizerToggle<CR>",
        desc = "Colorizer Toggle",
      },
    },
  },
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
