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
    },
    opts = function()
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
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
          typst = { "typstyle" },
          fortran = { "fprettify", "myfmt", stop_after_first = true },
          tex = { "latexindent" },
          markdown = { "mdformat" },
          cmake = { "cmake_format" },
        },
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = { options = { ignore_errors = true } },
          fprettify = {
            args = {
              "--case",
              "2",
              "2",
              "2",
              "2",
              "--line-length",
              "78",
              "--indent",
              "2",
              "--strict-indent",
              "--disable-indent-mod",
              "--whitespace",
              "2",
              "--whitespace-comma",
              "--whitespace-assignment",
              "--enable-decl",
              "--whitespace-decl",
              "--whitespace-relational",
              "--whitespace-logical",
              "--whitespace-multdiv",
              "--whitespace-print",
              "--whitespace-intrinsics",
              "--strip-comments",
            },
            condition = function()
              return not vim.g.use_myfmt
            end,
          },
          myfmt = {
            command = "fprettify",
            args = {
              "--line-length",
              "78",
              "--indent",
              "2",
              "--strict-indent",
              "--disable-indent-mod",
              "--whitespace",
              "2",
              "--whitespace-comma",
              "--whitespace-assignment",
              "--enable-decl",
              "--whitespace-decl",
              "--whitespace-relational",
              "--whitespace-logical",
              "--whitespace-multdiv",
              "--whitespace-print",
              "--whitespace-intrinsics",
              "--strip-comments",
            },
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
        },
      }
      return opts
    end,
  },
}
