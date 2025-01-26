return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "folke/neodev.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    cmd = { "LspInfo", "LspInstall", "LspRestart", "LspStart", "LspStop", "LspUninstall" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = false,
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "bashls",
          "cmakelang",
          "dprint",
          "fortls",
          "fprettify",
          "gopls",
          "goimports",
          "julials",
          "jupytext",
          "latexindent",
          "lua_ls",
          "markdownlint-cli2",
          "marksman",
          "mdformat",
          "shfmt",
          "stylua",
          "taplo",
          "texlab",
          "vimls",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("pengvim-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local function vmap(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
          map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
          map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
          map("gh", vim.lsp.buf.signature_help, "[g]o to signature [h]elp")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          vmap("<leader>Lf", vim.lsp.buf.format, "[l]sp [f]ormat")

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

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

      -- local function get_quarto_resource_path()
      --   local function strsplit(s, delimiter)
      --     local result = {}
      --     for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
      --       table.insert(result, match)
      --     end
      --     return result
      --   end
      --
      --   local f = assert(io.popen('quarto --paths', 'r'))
      --   local s = assert(f:read '*a')
      --   f:close()
      --   return strsplit(s, '\n')[2]
      -- end
      --
      -- local lua_library_files = vim.api.nvim_get_runtime_file('', true)
      -- local lua_plugin_paths = {}
      -- local resource_path = get_quarto_resource_path()
      -- if resource_path == nil then
      --   vim.notify_once 'quarto not found, lua library files not loaded'
      -- else
      --   table.insert(lua_library_files, resource_path .. '/lua-types')
      --   table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')
      -- end

      lspconfig.marksman.setup({
        capabilities = capabilities,
        filetypes = { "markdown", "quarto" },
        root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              workspaceEvent = "None",
              disable = {
                "missing-fields",
                "trailing-space",
              },
            },
          },
        },
      })

      lspconfig.fortls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        cmd = {
          "fortls",
          "--lowercase_intrinsics",
          "--source_dirs",
          -- os.getenv("EASIFEM_SOURCE_DIR") .. "/easifem/base/src/**",
          os.getenv("DROPBOX") .. "/easifem/base/src/**",
          os.getenv("DROPBOX") .. "/easifem/classes/src/**",
          os.getenv("DROPBOX") .. "/easifem/elasticity/src/**",
          os.getenv("DROPBOX") .. "/easifem/acoustic/src/**",
          os.getenv("HOME") .. "/.easifem/src/tomlf/src/**",
          "--hover_signature",
          "--hover_language=fortran",
          "--use_signature_help",
        },
      })

      lspconfig.gopls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.julials.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        on_new_config = function(new_config, _)
          local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
          local REVISE_LANGUAGESERVER = false
          if REVISE_LANGUAGESERVER then
            new_config.cmd[5] = (new_config.cmd[5]):gsub(
              "using LanguageServer",
              "using Revise; using LanguageServer; LanguageServer.USE_REVISE[] = true"
            )
          elseif (vim.loop.fs_stat(julia) or {}).type == "file" then
            new_config.cmd[1] = julia
          end
        end,
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("Project.toml")(fname)
            or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
            or vim.fs.dirname(fname)
        end,
        on_attach = function(_, bufnr)
          vim.bo[bufnr].formatexpr = ""
        end,
      })

      lspconfig.texlab.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          inlayHints = {
            labelReferences = false,
            labelDefinitions = false,
          },
        },
      })

      lspconfig.taplo.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "sh", "bash" },
      })

      lspconfig.vimls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })
    end,
  },
}
