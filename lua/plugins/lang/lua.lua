return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim", "Snacks" },
                disable = {
                  "missing-fields",
                  "trailing-space",
                },
              },
            },
          },
        },
      },
      extra = {
        stylua = {
          ensure_installed = true,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = { "LazyDev" },
    opts = {},
  },
}
