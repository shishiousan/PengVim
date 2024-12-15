return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
    config = function()
      vim.g.typst_pdf_viewer = "zathura"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        typst_lsp = function()
          require("lspconfig").typst_lsp.setup({
            settings = {
              exportPdf = "onType",
            },
          })
        end,
      },
    },
  },
}
