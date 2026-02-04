return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          cmd = { "taplo", "lsp", "stdio" },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "toml",
        "yaml",
      },
    },
  },
}
