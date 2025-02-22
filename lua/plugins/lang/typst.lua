return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {},
      },
      extra = {
        typstfmt = {
          ensure_installed = true,
        },
      },
    },
  },
}
