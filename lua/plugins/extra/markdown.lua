return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    ft = { "markdown", "quarto" },
    keys = {
      { "<leader>ur", ":RenderMarkdown toggle<CR>", desc = "[r]ender Markdown" },
    },
    opts = {},
  },
  { -- preview equations in markdown or tex
    "jbyuki/nabla.nvim",
    keys = {
      {
        "<leader>m",
        function()
          require("nabla").popup()
        end,
        desc = "[m]ath preview",
      },
    },
  },
  {
    "dhruvasagar/vim-table-mode",
    keys = {
      { "<leader>ut", ":TableModeEnable<CR>", desc = "[t]able Mode Enable" },
    },
  },
}
