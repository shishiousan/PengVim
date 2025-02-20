return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
      {
        "<leader>cf",
        function()
          require("conform").format({})
        end,
        mode = { "n", "v" },
        desc = "Format Current buffer",
      },
    },
    opts = function()
      local opts = {
        default_format_opts = {
          timeout_ms = 5000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          toml = { "taplo" },
          typst = { "typstyle", "typstfmt", stop_after_first = true },
          fortran = { "fprettify", "myfmt", stop_after_first = true },
          go = { "goimports" },
          tex = { "latexindent" },
          markdown = { "dprint", "markdownlint-cli2", "injected" },
          cmake = { "cmake_format" },
          json = { "jq", "dprint", stop_after_first = true },
          julia = { lsp_format = "fallback" },
          quarto = { "markdownlint-cli2", "injected" },
        },
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = {
            options = {
              ignore_errors = false,
              lang_to_ext = {
                bash = "sh",
                julia = "jl",
                latex = "tex",
                markdown = "md",
                python = "py",
                rust = "rs",
                lua = "lua",
              },
              lang_to_formatters = {},
            },
          },
          fprettify = {
            args = require("plugins.args.fortran").formatter or {},
          },
          myfmt = {
            command = "fprettify",
            args = require("plugins.args.fortran").formatter_sub or {},
            condition = function()
              return vim.g.use_myfmt
            end,
          },
          taplo = {
            args = {
              "format",
              "--option",
              "array_auto_collapse=false",
              "-",
            },
          },
          typstyle = {
            command = "typstyle",
            stdin = true,
            -- args = { "--column", "50" },
          },
          latexindent = {
            command = "latexindent",
            stdin = true,
            args = { "-" },
          },
          mdformat = {
            command = "mdformat",
            args = { "-" },
          },
          cmake_format = {
            command = "cmake-format",
            args = { "-" },
          },
          stylua = {
            command = "stylua",
            args = { "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" },
          },
        },
      }
      return opts
    end,
  },
}
