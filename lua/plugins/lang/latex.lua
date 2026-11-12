return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            completion = {
              matcher = "prefix-ignore-case",
            },
            inlayHints = {
              labelReferences = false,
              labelDefinitions = false,
            },
            texlab = {
              diagnostics = {
                ignoredPatterns = { "Unused label" },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bibtex",
        "latex",
      },
      -- highlight = {
      -- NOTE: https://github.com/lervag/vimtex/issues/2512
      -- to enable vimtex syntax highlight
      -- but it is slow sometimes
      -- the above referece maybe useful to solve the problem
      -- disable = { "latex" },
      -- },
    },
  },
  {
    "lervag/vimtex",
    lazy = false, -- vimtex must not be lazy-loaded
    init = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode = 0

      vim.g.vimtex_log_ignore = {
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      }

      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-file-line-error",
          "-interaction=nonstopmode",
          "-synctex=1", -- REMOVE this line to disable synctex
        },
      }

      vim.g.vimtex_context_pdf_viewer = "zathura"
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_complete_bib = {
        simple = 1,
      }
    end,
    -- buffer settings and <leader>v maps: after/ftplugin/tex.lua
  },
}
