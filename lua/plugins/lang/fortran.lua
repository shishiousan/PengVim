return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fortls = {
          cmd = require("plugins.args.fortran").lsp_cmd or {},
        },
        fortitude = {
          ensure_installed = false,
          cmd = { "fortitude", "server" },
          filetypes = { "fortran" },
          -- hover comes from fortls; fortitude's would duplicate it
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = {
              check = {
                ignore = { "C002", "C003", "MOD021", "S241", "S102" },
              },
            },
          },
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
    },
  },
}
