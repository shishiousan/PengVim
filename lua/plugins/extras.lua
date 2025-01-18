return {
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
  {
    "dag/vim-fish",
    ft = { "fish" },
  },
  {
    "hat0uma/csvview.nvim",
    ft = "csv",
    config = function()
      require("csvview").setup({
        view = {
          --- @type integer
          min_column_width = 5,

          --- @type integer
          spacing = 2,

          ---@type "highlight" | "border"
          display_mode = "border",
        },
      })
    end,
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
    config = function()
      vim.g.typst_pdf_viewer = "zathura"
    end,
  },
  {
    "GitMarkedDan/you-are-an-idiot.nvim",
    lazy = false,
    config = function()
      local opts = {
        window = {
          relative = "editor",
          style = "minimal",
          border = "single",
          width = 17,
          height = 1,
        },
        resize_window_to_fit = true,
        text = "You are an idiot!",
        flash_interval = 0,
        focus_cursor = true,
        is_scratch = true,
        min_velocity = 20,
        max_velocity = 30,
        reproduce_count = 5,
        initial = {
          {
            x = "rand",
            y = "rand",
            moving = true,
          },
        },
        delta_time = 0.05,
      }
      require("you-are-an-idiot").setup(opts)
    end,
  },
  {
    -- Penguins go crazy
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>ph",
        function()
          require("duck").hatch("🐧")
        end,
        desc = "Penguins hatch",
      },
      {
        "<leader>pb",
        function()
          require("duck").cook()
        end,
        desc = "Penguins bye bye",
      },
      {
        "<leader>pa",
        function()
          require("duck").cook_all()
        end,
        desc = "All Penguins bye bye",
      },
    },
  },
}
