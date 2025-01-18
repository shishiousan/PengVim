return {
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("moonfly")
    end,
  },
  {
    "2giosangmitom/nightfall.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "0xstepit/flow.nvim",
    name = "Flow",
    lazy = true,
    priority = 1000,
    config = function()
      require("flow").setup({
        theme = {
          style = "dark",
          contrast = "default", -- or "high"
          transparent = true,
        },
        colors = {
          mode = "default",
          fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
          custom = {
            saturation = "", -- 0 and 100
            light = "", -- 0 and 100
          },
        },
        ui = {
          borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
          aggressive_spell = false,
        },
      })
    end,
  },
  {
    "ray-x/aurora",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_transparent = 1
      vim.g.aurora_bold = 1
    end,
    config = function() end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
    end,
  },
  { -- very chilling colorscheme
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = true,
    priority = 1000,
  },
  { -- extremely minimal colorscheme
    "jackplus-xyz/binary.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      {
        style = "dark", -- Theme style: "system" | "light" | "dark"
        use_default_reversed_group = true,
      },
    },
  },
}
