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
  {
    "mistricky/codesnap.nvim",
    build = "make",
    config = function()
      require("codesnap").setup({
        mac_window_bar = false,
        title = "PengVim",
        code_font_family = "CaskaydiaCove Nerd Font",
        watermark_font_family = "Pacifico",
        watermark = "PengVim",
        bg_theme = "grape",
        breadcrumbs_separator = "/",
        has_breadcrumbs = true,
        save_path = "/home/shion/Documents",
      })
    end,
  },
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
  -- {
  --   "NStefan002/speedtyper.nvim",
  --   lazy = false,
  --   branch = "main",
  --   opts = {
  --     window = {
  --       height = 5, -- integer >= 5 | float in range (0, 1)
  --       width = 0.55, -- integer | float in range (0, 1)
  --       border = "rounded", -- "none" | "single" | "double" | "rounded" | "shadow" | "solid"
  --       -- lhs used to close game window.
  --       -- can be a string (applies to normal mode),
  --       -- or a table where the key represents the mode and the value is the mapping.
  --       -- e.g. close_with = "q" or close_with = { n = "q", i = "<M-q>" }.
  --       -- mode can be any of "n" | "i" | "x"
  --       -- nil means no map
  --       close_with = nil,
  --     },
  --     language = "en", -- "en" | "sr" currently only only supports English and Serbian
  --     sentence_mode = false, -- if true, whole sentences will be used
  --     custom_text_file = nil, -- provide a path to file that contains your custom text (if this is not nil, language option will be ignored)
  --     randomize = false, -- randomize words from custom_text_file
  --     game_modes = { -- prefered settings for different game modes
  --       -- type until time expires
  --       countdown = {
  --         time = 30,
  --       },
  --       -- type until you complete one page
  --       stopwatch = {
  --         hide_time = true, -- hide time while typing
  --       },
  --       -- NOTE: the window height will become the same as the window width
  --       rain = {
  --         initial_speed = 1.5, -- words fall down by one line every x seconds
  --         throttle = 7, -- increase speed every x seconds (set to -1 for constant speed)
  --         lives = 3,
  --       },
  --     },
  --     -- specify highlight group for each component
  --     highlights = {
  --       untyped_text = "Comment",
  --       typo = "ErrorMsg",
  --       clock = "ErrorMsg",
  --       falling_word_typed = "DiagnosticOk",
  --       falling_word = "Normal",
  --       falling_word_warning1 = "WarningMsg",
  --       falling_word_warning2 = "ErrorMsg",
  --     },
  --     -- this values will be restored to your prefered settings after the game ends
  --     vim_opt = {
  --       -- only applies to insert mode, while playing the game
  --       guicursor = nil, -- "ver25" | "hor20" | "block" | nil means do not change
  --     },
  --   },
  -- },
  {
    "nvzone/typr",
    dependencies = {
      "nvzone/volt",
    },
    lazy = false,
  },
}
