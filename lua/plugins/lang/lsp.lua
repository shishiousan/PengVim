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

      -- Mason package -> executable it provides (when the names differ).
      local extra = {
        cmakelang = { bin = "cmake-format" },
        dprint = {},
        jupytext = {},
        shfmt = {},
      }
      extra = vim.tbl_deep_extend("force", extra, opts.extra or {})

      for name, settings in pairs(opts.servers or {}) do
        servers[name] = vim.tbl_deep_extend("force", servers[name] or {}, settings)
      end

      -- Let Mason install only what is missing from PATH, so it never shadows
      -- tools installed system-wide (Mason prepends its bin dir to PATH).
      local missing = {}
      local function need(pkg, bin)
        if type(bin) == "string" and vim.fn.executable(bin) == 0 then
          missing[#missing + 1] = pkg
        end
      end

      for name, settings in pairs(servers) do
        local install = settings.ensure_installed ~= false
        settings.ensure_installed = nil -- not an LSP field
        if install then
          local cmd = settings.cmd or (vim.lsp.config[name] or {}).cmd
          need(name, type(cmd) == "table" and cmd[1] or nil)
        end
      end
      for pkg, tool in pairs(extra) do
        if tool.ensure_installed ~= false then
          need(pkg, tool.bin or pkg)
        end
      end

      require("mason-tool-installer").setup({ ensure_installed = missing })

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
