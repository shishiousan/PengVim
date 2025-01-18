return {
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[
                                                          ⠀⠀⠀⠀⠀⠀⣀⡤⠴⠒⠒⠒⠶⢤⣄⡀⠀⠀⠀⠀⠀⠀           
██████╗ ███████╗███╗   ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢦⡀⠀⠀⠀⠀           
██╔══██╗██╔════╝████╗  ██║██╔════╝ ██║   ██║██║████╗ ████║⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀< Hello World
██████╔╝█████╗  ██╔██╗ ██║██║  ███╗██║   ██║██║██╔████╔██║⠀⠀⢸⠁⠀⠀⣠⠖⠛⠛⠲⢤⠀⠀⠀⣰⠚⠛⢷⠀⠀⠀           
██╔═══╝ ██╔══╝  ██║╚██╗██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║⠀⠀⣿⠀⠀⣸⠃⠀⠀⢀⣀⠈⢧⣠⣤⣯⢠⣤⠘⣆⠀⠀           
██║     ███████╗██║ ╚████║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║⠀⠀⣿⠀⠀⡇⠀⠀⠀⠻⠟⠠⣏⣀⣀⣨⡇⠉⢀⣿⠀⠀           
╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝⠀⢀⡟⠀⠀⠹⡄⠀⠀⠀⠀⠀⠉⠑⠚⠉⠀⣠⡞⢿⠀⠀           
                                                          ⢀⡼⠁⠀⠀⠀⠙⠳⢤⡄⠀⠀⠀⠀⠀⠀⠀⠁⠙⢦⠳⣄           
    ]],
          keys = {
            {
              action = ":FzfLua files",
              desc = " Find File",
              icon = " ",
              key = "f",
            },
            {
              action = ":ene | startinsert",
              desc = " New File",
              icon = " ",
              key = "n",
            },
            {
              action = ":FzfLua oldfiles",
              desc = " Recent Files",
              icon = " ",
              key = "r",
            },
            {
              action = ":FzfLua live_grep",
              desc = " Find Text",
              icon = " ",
              key = "g",
            },
            {
              action = ':lua require("persistence").load()',
              desc = " Restore Session",
              icon = " ",
              key = "s",
            },
            {
              action = ":Lazy",
              desc = " Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = ":qa",
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
        },
      },
      statuscolumn = {
        enabled = false,
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "folke/which-key.nvim",
    opts_extend = { "spec" },
    opts = {
      ---@type wk.Win
      win = {
        height = { min = 4, max = 25 },
        col = 0.5,
        row = -1,
        border = "double",
        padding = { 0, 1 },
        title = false,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {},
      },
      layout = {
        width = { min = 20 },
        spacing = 1,
        align = "left",
      },
      show_keys = false,
      show_help = false,
      preset = "classic",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gd", group = "diffview" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        {
          { "<leader>w", group = "window" },
          { "<leader>wh", "<C-W>h", desc = "Move to left" },
          { "<leader>wj", "<C-W>j", desc = "Move down" },
          { "<leader>wk", "<C-W>k", desc = "Move up" },
          { "<leader>wl", "<C-W>l", desc = "Move to right" },
          { "<leader>z", group = "Zoom" },
          { "<leader>zi", "<cmd>tab split<CR>", desc = "Zoom in" },
          { "<leader>zo", "<cmd>tab close<CR>", desc = "Zoom out" },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
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
        automatic_installation = true,
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "shfmt",
          "cmakelang",
          "julials",
          "fortls",
          "jupytext",
          "mdformat",
          "marksman",
          "taplo",
          "lua_ls",
          "texlab",
          "bashls",
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

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
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
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = false,
    },
  },
  {
    "echasnovski/mini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })
      require("mini.icons").setup()
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "vimdoc",
        "yaml",
        "toml",
        "julia",
        "fortran",
        "fish",
        "csv",
        "diff",
      },
      auto_install = true,
      indent = {
        enable = true,
        disable = { "julia", "fortran" },
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]b"] = "@block.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
            ["]B"] = "@block.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[b"] = "@block.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
            ["[B"] = "@block.outer",
          },
        },
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.outer",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ao"] = "@block.outer",
            ["io"] = "@block.inner",
            -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "sustech-data/wildfire.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    "mfussenegger/nvim-lint",
    ft = { "fortran" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        fish = { "fish" },
      },
      ---@type table<string,table>
      linters = {},
    },
    config = function(_, opts)
      local M = {}

      local lint = require("lint")
      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        names = vim.list_extend({}, names)

        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            vim.notify("Linter is not found")
          end
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
}
