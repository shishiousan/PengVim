return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    cmd = { "LspInfo", "LspInstall", "LspRestart", "LspStart", "LspStop", "LspUninstall" },
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mason").setup()

      local servers = {
        vimls = {},
        bashls = {
          filetypes = { "sh", "bash" },
        },
      }

      local ensure_installed_extra = {
        "cmakelang",
        "dprint",
        "jupytext",
        "shfmt",
      }

      if opts.extra ~= nil then
        for name, arg in pairs(opts.extra) do
          if arg.ensure_installed then
            vim.list_extend(ensure_installed_extra, { name })
          end
        end
      end

      if opts.servers ~= nil then
        for name, settings in pairs(opts.servers) do
          servers[name] = vim.tbl_deep_extend("force", servers[name] or {}, settings)
          if settings.ensure_installed == nil or settings.ensure_installed then
            vim.list_extend(ensure_installed_extra, { name })
          end
        end
      end

      require("mason-tool-installer").setup({
        enusre_installed = ensure_installed_extra,
        -- ensure_installed = vim.list_extend(vim.tbl_keys(servers), ensure_installed_extra),
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      for name, settings in pairs(servers) do
        settings.capabilities = require("blink.cmp").get_lsp_capabilities(settings.capabilities)
        settings.flags = vim.tbl_deep_extend("force", {}, lsp_flags, settings.flags or {})
        vim.lsp.config(name, settings)
        vim.lsp.enable(name)
      end
    end,
  },
}
