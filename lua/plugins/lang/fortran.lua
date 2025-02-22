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
}
