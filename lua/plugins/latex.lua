return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 1000 },
      servers = {
        texlab = {
          settings = {
            texlab = {
              inlayHints = {
                labelReferences = false,
                labelDefinitions = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    -- dependencies = { "Konfekt/FastFold" },
    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
        pattern = { "bib", "tex" },
        callback = function()
          local wk = require("which-key")
          wk.add({
            { "<leader>v", group = "VIMTEX" },
            { "<leader>va", "<cmd>Telescope bibtex<CR>", desc = "Add CITATION (bib)" },
            { "<leader>vb", "<cmd>VimtexCompile<CR>", desc = "BUILD" },
            { "<leader>vc", "<cmd>VimtexCountWords!<CR>", desc = "COUNT" },
            { "<leader>vd", "<cmd>VimtexClean<CR>", desc = "DELETE aux" },
            {
              "<leader>ve",
              function()
                -- check vimtex auxiliary direcotry variable
                local out_dir = os.getenv("VIMTEX_OUTPUT_DIRECTORY")
                if type(out_dir) == "string" then
                  local do_exist, _ = os.rename(out_dir, out_dir)
                  if do_exist == true then
                    vim.cmd("! bibexport -o %:r.bib ./" .. out_dir .. "/%:r.aux")
                    return
                  end
                end
                vim.cmd("! bibexport -o %:r.bib %:r.aux")
              end,
              desc = "MAKE bib file",
            },
            {
              "<leader>vf",
              function()
                vim.cmd("normal! w") -- before format, make sure that the file is latest
                if not vim.bo.filetype == "tex" then
                  vim.notify("Only default save was done (no format)", 3, { title = "This is not TeX file" })
                end
                local out_dir = os.getenv("VIMTEX_OUTPUT_DIRECTORY")
                if type(out_dir) == "string" then
                  local do_exist, _ = os.rename(out_dir, out_dir)
                  if do_exist then
                    -- NOTE: -c option determine the location of indent.log file
                    -- -o specifies the outputfile without backup
                    -- if you want the backup file use -w or -ww option
                    vim.cmd("! latexindent -c " .. out_dir .. " -s -o % %")
                    return
                  end
                end
                vim.cmd("! latexindent -s -o % %")
              end,
              desc = "FORMAT SAVE (no backup)",
            },
            { "<leader>vi", "<cmd>VimtexTocOpen<CR>", desc = "INDEX" },
            { "<leader>vl", "<cmd>VimtexErrors<CR>", desc = "LOG of ERRORS" },
            { "<leader>vm", "<plug>(vimtex-context-menu)", desc = "VIMTEX MENU" },
            { "<leader>vr", "<plug>(vimtex-doc-package)", desc = "READ VIMTEX DOC" },
            { "<leader>vv", "<cmd>VimtexView<CR>", desc = "VIEW" },
          })
          vim.wo.conceallevel = 2
        end,
      })
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode = 0

      vim.g.vimtex_log_ignore = {
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      }

      vim.g.vimtex_context_pdf_viewer = "okular"
      vim.g.vimtex_complete_enabled = 1
      --
      -- Ignore mappings
      -- vim.g["vimtex_mappings_enabled"] = 0
      -- Fold
      -- NOTE: I prefer to vim-tex-fold now
      -- vim.g.vimtex_fold_enabled = 1
      -- vim.g.vimtex_fold_types = {
      --   preamble = { enabled = 1 },
      --   sections = { sections = { "chapter", "section" } },
      --   envs = { whitelist = { "table" } },
      --   comments = { enabled = 1 },
      -- }
      -- Auto format
      -- vim.g.vimtex_format_enabled = 1
      -- Auto Indent
      -- vim.g["vimtex_indent_enabled"] = 0
      -- Syntax highlighting
      -- vim.g.vimtex_syntax_enabled = 1
      -- Error suppression:
      -- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt
      -- vim.g['vimtex_compiler_progname'] = 'nvr'
      -- vim.g['vimtex_complete_close_braces'] = 1
    end,
  },
  {
    "shishiousan/vim-tex-fold",
    lazy = true,
    ft = { "tex", "latex", "bib" },
    init = function()
      -- {{{~}}} is also folded
      vim.g.tex_fold_allow_marker = 1
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     setup = {
  --       grammarly = function(_, opts)
  --         opts.cmd = {
  --           "grammarly-languageserver",
  --           "--stdio",
  --         }
  --         opts.filetypes = { "latex", "tex", "markdown" }
  --         opts.init_options = {
  --           clientId = "client_BaDkMgx4X19X9UxxYRCXZo",
  --         }
  --         opts.single_file_support = true
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "shishiousan/ltex-utils.nvim",
  --   lazy = true,
  --   filetypes = { "tex" },
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "nvim-telescope/telescope.nvim",
  --     --"nvim-telescope/telescope-fzf-native.nvim",-- optional
  --   },
  --   opts = {
  --     dictionary = {
  --       -- Path to the directory where dictionaries are stored
  --       -- Defaults to the Neovim cache directory
  --       path = vim.fn.stdpath("config") .. "/spell/",
  --       ---Returns the dictionary file name for given language `lang`
  --       filename = function(lang)
  --         return "ltex.dictionary." .. lang .. ".txt"
  --       end,
  --       -- use vim internal dictionary to add unkown words
  --       use_vim_dict = false,
  --       -- show/suppress vim command output such as `spellgood` or `mkspell`
  --       vim_cmd_output = false,
  --     },
  --   },
  --   },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     {
  --       "shishiousan/ltex-utils.nvim",
  --     },
  --   },
  --   opts = {
  --     servers = {
  --       ltex = {
  --         filetypes = { "tex" },
  --         on_attach = function(_, bufnr)
  --           vim.notify("ltex starts")
  --           require("ltex-utils").on_attach(bufnr)
  --         end,
  --         settings = {
  --           ltex = {
  --             additionalRules = {
  --               enablePickyRules = true,
  --               motherTongue = "en",
  --               languageModel = "~/ngram",
  --             },
  --             checkFrequency = "save",
  --             disabledRules = {
  --               ["en-US"] = { "PROFANITY", "PASSIVE_VOICE" },
  --               ["en-GB"] = { "PROFANITY", "PASSIVE_VOICE" },
  --             },
  --             -- filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
  --             -- filetypes = { "markdown", "tex", "mdx" },
  --             -- enabled = { "latex", "tex", "bib" },
  --             enabled = { "latex" },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
