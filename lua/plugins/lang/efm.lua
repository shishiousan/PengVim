return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        efm = {
          init_options = { documentFormatting = false },
          settings = {
            rootMarkers = { ".git/" },
            languages = {},
          },
        },
      },
    },
  },
}
