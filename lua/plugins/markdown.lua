return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          settings = {
            marksman = {},
          },
        },
      },
    },
  },
  {
    "arminveres/md-pdf.nvim",
    branch = "main",
    lazy = true,
    config = function()
      require("md-pdf").setup({
        margins = "2.0cm",
        highlight = "tango",
        toc = false,
      })
    end,
    keys = {
      {
        "<leader>mc",
        function()
          require("md-pdf").convert_md_to_pdf()
        end,
        desc = "Convert to pdf",
      },
    },
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = { "markdown" },
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_theme = "dark"
    end,
  },
  {
    "huantrinh1802/m_taskwarrior_d.nvim",
    version = "*",
    -- ft = { "markdown" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("m_taskwarrior_d").setup()
      -- Optional
      -- vim.api.nvim_set_keymap(
      --   "n",
      --   "<leader>te",
      --   "<cmd>TWEditTask<cr>",
      --   { desc = "TaskWarrior Edit", noremap = true, silent = true }
      -- )
      -- vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>TWView<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>tu", "<cmd>TWUpdateCurrent<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>TWSyncTasks<cr>", { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>TWToggle<cr>", { silent = true })
      -- following autocommand will sync tasks when the file is opened and saved
      -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      --   group = vim.api.nvim_create_augroup("TWTask", { clear = true }),
      --   pattern = "*.md,*.markdown", -- Pattern to match Markdown files
      --   callback = function()
      --     vim.cmd("TWSyncTasks")
      --   end,
      -- })
    end,
    keys = {
      { "<leader>te", "<cmd>TWEditTask<cr>", desc = "TaskWarrior Edit" },
      { "<leader>tv", "<cmd>TWView<cr>", desc = "TaskWarrior View" },
      { "<leader>tu", "<cmd>TWUpdateCurrent<cr>", desc = "TaskWarrior Update" },
      { "<leader>ts", "<cmd>TWSyncTasks<cr>", desc = "TaskWarrior Sync Tasks" },
      { "<leader>tt", "<cmd>TWToggle<cr>", desc = "TaskWarrior Toggle" },
    },
  },
}
