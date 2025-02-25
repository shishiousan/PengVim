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
    ft = { "tex", "bib", "latex" },
    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("pengvim_vimtex_conceal", { clear = true }),
        pattern = { "bib", "tex" },
        callback = function()
          local wk = require("which-key")
          wk.add({
            { "<leader>v", group = "[V]imTex" },
            { "<leader>vb", "<cmd>VimtexCompile<CR>", desc = "Build" },
            { "<leader>vc", "<cmd>VimtexCountWords!<CR>", desc = "Count Words" },
            { "<leader>vd", "<cmd>VimtexClean<CR>", desc = "Delete aux" },
            {
              "<leader>ve",
              function()
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
            { "<leader>vl", "<cmd>VimtexErrors<CR>", desc = "Error Log" },
            { "<leader>vm", "<plug>(vimtex-context-menu)", desc = "Vimtex menu" },
            { "<leader>vr", "<plug>(vimtex-doc-package)", desc = "Read VimTex Doc" },
            { "<leader>vv", "<cmd>VimtexView<CR>", desc = "View PDF" },
            { "<leader>vt", "<cmd>VimtexTocToggle<CR>", desc = "Toggle Table of Contents" },
          })
          vim.wo.conceallevel = 2
        end,
      })
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

      vim.g.vimtex_context_pdf_viewer = "okular"
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_complete_bib = {
        simple = 1,
      }
    end,
  },
}
