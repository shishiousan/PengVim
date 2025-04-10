return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    event = "InsertEnter",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
          exclude = { "all", "global", "latex", "julia", "fortran" },
        })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = "./snippets",
      })
      require("luasnip").filetype_extend("quarto", { "markdown" })
    end,
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "micangl/cmp-vimtex",
      -- "rafamadriz/friendly-snippets",
      -- "jmbuhr/otter.nvim",
    },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            local has_words_before = function()
              unpack = unpack or table.unpack
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0
                and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            if cmp.is_visible() then
              return cmp.select_next()
            elseif cmp.snippet_active() then
              return cmp.snippet_forward()
            elseif has_words_before() then
              return cmp.show()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            elseif cmp.snippet_active() then
              return cmp.snippet_backward()
            end
          end,
          "fallback",
        },
      },
      completion = {
        menu = {
          scrollbar = false,
          border = "rounded",
          auto_show = true,
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind", "source_name", gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = {
            border = "rounded",
            scrollbar = false,
          },
        },
        list = {
          max_items = 100,
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            auto_insert = true,
          },
        },
      },
      signature = {
        window = {
          border = "rounded",
        },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = {
          "snippets",
          "lsp",
          "path",
          "buffer",
          "cmdline",
        },
        per_filetype = {
          fortran = { "snippets", "lsp", "path", "buffer" },
          julia = { "snippets", "lsp", "path", "buffer" },
          tex = { "snippets", "vimtex", "path" },
        },
        providers = {
          lsp = {
            score_offset = 10,
          },
          snippets = {
            score_offset = 15,
            should_show_items = function(ctx)
              -- return ctx.trigger.initial_kind ~= "trigger_character" and not require("blink.cmp").snippet_active()
              return ctx.trigger.initial_kind ~= "trigger_character"
            end,
          },
          cmdline = {
            name = "cmdline",
            module = "blink.compat.source",
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 5,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
