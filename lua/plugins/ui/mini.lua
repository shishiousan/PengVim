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
      MiniIcons.mock_nvim_web_devicons()
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
}
