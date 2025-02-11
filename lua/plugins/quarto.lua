return {
  {
    "jmbuhr/otter.nvim",
    lazy = true,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "folke/which-key.nvim",
    },
    config = function()
      require("quarto").setup({
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime",
          ft_runners = {},
          never_run = { "yaml" },
        },
      })

      -- Quarto featured by vim-slime
      -- reference is quarto_nvim_kickstarter
      local wk = require("which-key")
      vim.g["quarto_is_r_mode"] = nil
      vim.g["reticulate_running"] = false

      local function map(mode, lhs, rhs, opts)
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      local function send_cell()
        if vim.b["quarto_is_r_mode"] == nil then
          vim.fn["slime#send_cell"]()
          vim.cmd("TSTextobjectGotoNextStart @block.outer")
          return
        end
        if vim.b["quarto_is_r_mode"] == true then
          vim.g.slime_python_ipython = 0
          local is_python = require("otter.tools.functions").is_otter_language_context("python")
          if is_python and not vim.b["reticulate_running"] then
            vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
            vim.b["reticulate_running"] = true
          end
          if not is_python and vim.b["reticulate_running"] then
            vim.fn["slime#send"]("exit" .. "\r")
            vim.b["reticulate_running"] = false
          end
          vim.fn["slime#send_cell"]()
        end
        vim.cmd("TSTextobjectGotoNextStart @block.outer")
      end

      local slime_send_region_cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
      slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
      local function send_region()
        -- if filetyps is not quarto, just send_region
        if vim.bo.filetype ~= "quarto" or vim.b["quarto_is_r_mode"] == nil then
          vim.cmd("normal" .. slime_send_region_cmd)
          return
        end
        if vim.b["quarto_is_r_mode"] == true then
          vim.g.slime_python_ipython = 0
          local is_python = require("otter.tools.functions").is_otter_language_context("python")
          if is_python and not vim.b["reticulate_running"] then
            vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
            vim.b["reticulate_running"] = true
          end
          if not is_python and vim.b["reticulate_running"] then
            vim.fn["slime#send"]("exit" .. "\r")
            vim.b["reticulate_running"] = false
          end
          vim.cmd("normal" .. slime_send_region_cmd)
        end
      end

      -- needs kitty (or other terminal) config:
      -- map shift+enter send_text all \x1b[13;2u
      -- map ctrl+enter send_text all \x1b[13;5u
      map({ "n", "i" }, "<c-cr>", send_cell)
      map({ "n", "i" }, "<s-cr>", send_cell)
      map({ "v" }, "<s-cr>", send_region)
      map({ "v" }, "<c-cr>", send_region)

      local is_code_chunk = function()
        local current, _ = require("otter.keeper").get_current_language_context()
        if current then
          return true
        else
          return false
        end
      end

      --- Insert code chunk of given language
      --- Splits current chunk if already within a chunk
      --- @param lang string
      local insert_code_chunk = function(lang)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
        local keys
        if is_code_chunk() then
          keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
        else
          keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
        end
        keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
      end

      local insert_py_chunk = function()
        insert_code_chunk("python")
      end

      local insert_lua_chunk = function()
        insert_code_chunk("lua")
      end

      local insert_julia_chunk = function()
        insert_code_chunk("julia")
      end

      local insert_bash_chunk = function()
        insert_code_chunk("bash")
      end

      local insert_fortran_chunk = function()
        insert_code_chunk("fortran")
      end

      wk.add({
        {
          { "<leader>i", group = "[I]nsert code chunk" },
          { "<leader>ip", insert_py_chunk, desc = "python code chunk" },
          { "<leader>ij", insert_julia_chunk, desc = "julia code chunk" },
          { "<leader>if", insert_fortran_chunk, desc = "fortran code chunk" },
          { "<leader>ib", insert_bash_chunk, desc = "bash code chunk" },
          { "<leader>il", insert_lua_chunk, desc = "lua code chunk" },
          { "<leader>ic", "O# %%<cr>", desc = "Comment code chunk # %%" },
        },
      }, { mode = "n", silent = true })

      wk.add({
        {
          mode = { "i" },
          { "<C-x><C-x>", "<C-x><C-o>", desc = "omnifunc completion" },
          { "<M-i>", insert_py_chunk, desc = "python code chunk" },
          { "<M-j>", insert_julia_chunk, desc = "julia code chunk" },
          { "<M-m>", " |>", desc = "pipe" },
        },
      }, { mode = "i" })

      local function new_terminal(lang)
        vim.cmd("vsplit term://" .. lang)
      end

      local function new_terminal_python()
        new_terminal("python")
      end

      local function new_terminal_ipython()
        new_terminal("ipython --no-confirm-exit")
      end

      local function new_terminal_julia()
        new_terminal("julia")
      end

      local function new_terminal_shell()
        new_terminal("$SHELL")
      end

      -- local function get_otter_symbols_lang()
      --   local otterkeeper = require("otter.keeper")
      --   local main_nr = vim.api.nvim_get_current_buf()
      --   local langs = {}
      --   for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
      --     langs[i] = i .. ": " .. l
      --   end
      --   -- promt to choose one of langs
      --   local i = vim.fn.inputlist(langs)
      --   local lang = otterkeeper.rafts[main_nr].languages[i]
      --   local params = {
      --     textDocument = vim.lsp.util.make_text_document_params(),
      --     otter = {
      --       lang = lang,
      --     },
      --   }
      --   vim.lsp.buf_request(main_nr, ms.textDocument_documentSymbol, params, nil)
      -- end
      -- vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "otter [s]ymbols" })

      wk.add({
        {
          { "<leader><cr>", send_cell, desc = "run code cell" },
          { "<leader>c", group = "[c]ode / [c]ell / [c]hunk" },
          { "<leader>ci", new_terminal_ipython, desc = "new [i]python terminal" },
          { "<leader>cj", new_terminal_julia, desc = "new [j]ulia terminal" },
          { "<leader>cn", new_terminal_shell, desc = "[n]ew terminal with shell" },
          { "<leader>cp", new_terminal_python, desc = "new [p]ython terminal" },
          { "<leader>o", group = "[o]tter & [O]verseer" },
          { "<leader>oa", require("otter").activate, desc = "otter [a]ctivate" },
          { "<leader>od", require("otter").activate, desc = "otter [d]eactivate" },
          { "<leader>Q", group = "[q]uarto" },
          {
            "<leader>QE",
            function()
              require("otter").export(true)
            end,
            desc = "[E]xport with overwrite",
          },
          { "<leader>Qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
          { "<leader>Qe", require("otter").export, desc = "[e]xport" },
          { "<leader>Qh", ":QuartoHelp ", desc = "[h]elp" },
          { "<leader>Qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
          { "<leader>Qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },
          { "<leader>Qr", group = "[r]un" },
          { "<leader>Qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
          { "<leader>Qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
          { "<leader>Qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },
        },
      }, { mode = "n" })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    enabled = false,
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },
  {
    "jpalardy/vim-slime",
    ft = {
      "python",
      "julia",
      "bash",
      "markdown",
      "quarto",
    },
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]])

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print("job_id: " .. job_id)
      end

      local function set_terminal()
        vim.fn.call("slime#config", {})
      end
      vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
      vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    enabled = false,
    event = "BufEnter",
    ft = { "markdown", "quarto", "latex" },
    opts = {
      default = {
        dir_path = "img",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("img-clip").setup(opts)
      vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
    end,
  },
  {
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
    },
  },
}
