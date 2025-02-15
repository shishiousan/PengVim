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
  {
    "dhruvasagar/vim-table-mode",
    keys = {
      { "<leader>ut", ":TableModeEnable<CR>", desc = "[t]able Mode Enable" },
    },
  },
}
