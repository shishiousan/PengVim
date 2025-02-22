return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            completion = {
              matcher = "prefix-ignore-case",
            },
            inlayHints = {
              labelReferences = false,
              labelDefinitions = false,
            },
          },
        },
      },
    },
  },
}
