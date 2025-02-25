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

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("pengvim-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local function vmap(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gh", vim.lsp.buf.signature_help, "go to signature [h]elp")
          map("<leader>ca", vim.lsp.buf.code_action, "code [a]ction")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          vmap("<leader>Lf", vim.lsp.buf.format, "Lsp [f]ormat")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")

          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("pengvim-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("pengvim-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "pengvim-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

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
        end
      end

      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), ensure_installed_extra),
      })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            server.flags = vim.tbl_deep_extend("force", {}, lsp_flags, server.flags or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
