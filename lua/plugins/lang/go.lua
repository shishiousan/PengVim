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
}
