return {
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    event = "BufRead",
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
    "xiyaowong/transparent.nvim",
    lazy = true,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat",
        },
      })
    end,
    keys = {
      {
        "<leader>ut",
        "<cmd>TransparentToggle<CR>",
        desc = "Transparent Toggle",
      },
    },
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false, -- Recommended
    -- ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- {
  --   "mistricky/codesnap.nvim",
  --   build = "make",
  --   config = function()
  --     require("codesnap").setup({
  --       mac_window_bar = false,
  --       title = "PengVim",
  --       code_font_family = "CaskaydiaCove Nerd Font",
  --       watermark_font_family = "Pacifico",
  --       watermark = "PengVim",
  --       bg_theme = "grape",
  --       breadcrumbs_separator = "/",
  --       has_breadcrumbs = true,
  --       save_path = "/home/shion/Documents",
  --     })
  --   end,
  -- },
  {
    "dag/vim-fish",
    filetypes = { "fish" },
  },
  {
    "hat0uma/csvview.nvim",
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
}
