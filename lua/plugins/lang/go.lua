return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
      },
      extra = {
        goimports = {
          ensure_installed = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
      },
    },
  },
}
