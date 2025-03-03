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
  { -- very chilling colorscheme
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = true,
    priority = 1000,
  },
}
