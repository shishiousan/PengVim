return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {},
      },
      extra = {
        typstyle = {
          ensure_installed = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typst",
      },
    },
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    config = function()
      vim.g.typst_pdf_viewer = "zathura"
    end,
  },
}
