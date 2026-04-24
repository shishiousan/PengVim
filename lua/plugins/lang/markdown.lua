return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
        harper_ls = {},
      },
      extra = {
        ["markdownlint-cli2"] = {
          ensure_installed = true,
        },
        mdformat = {
          ensure_installed = true,
        },
        rumdl = {
          ensure_installed = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "markdown",
        "markdown_inline",
      },
    },
  },
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
