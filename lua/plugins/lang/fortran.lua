return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fortls = {
          cmd = require("plugins.args.fortran").lsp_cmd or {},
        },
      },
      extra = {
        fprettify = {
          ensure_installed = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "fortran",
      },
      indent = {
        disable = { "fortran" },
      },
    },
  },
}
