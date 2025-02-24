return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
      },
      extra = {
        ["markdownlint-cli2"] = {
          ensure_installed = true,
        },
        mdformat = {
          ensure_installed = true,
        },
      },
    },
  },
}
