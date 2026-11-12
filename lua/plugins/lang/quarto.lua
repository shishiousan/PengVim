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

      -- Cell sending (vim-slime) and chunk helpers, adapted from quarto-nvim-kickstarter.
      -- Every map below is buffer-local to quarto/markdown buffers.

      -- The textobjects main branch has no :TSTextobject* commands; use the Lua API.
      local function goto_next_block()
        require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer", "textobjects")
      end

      local function send_cell()
        vim.fn["slime#send_cell"]()
        goto_next_block()
      end

      local slime_send_region_cmd =
        vim.api.nvim_replace_termcodes(":<C-u>call slime#send_op(visualmode(), 1)<CR>", true, false, true)
      local function send_region()
        vim.cmd("normal" .. slime_send_region_cmd)
      end

      --- Insert a code chunk of the given language; splits the current chunk if inside one.
      local function insert_code_chunk(lang)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
        local in_chunk = require("otter.keeper").get_current_language_context() ~= nil
        local keys = in_chunk and ([[o```<cr><cr>```{]] .. lang .. [[}<esc>o]])
          or ([[o```{]] .. lang .. [[}<cr>```<esc>O]])
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
      end
      local function chunk(lang)
        return function()
          insert_code_chunk(lang)
        end
      end

      local function attach(buf)
        -- needs kitty (or other terminal) config:
        -- map shift+enter send_text all \x1b[13;2u
        -- map ctrl+enter send_text all \x1b[13;5u
        for _, lhs in ipairs({ "<c-cr>", "<s-cr>" }) do
          vim.keymap.set({ "n", "i" }, lhs, send_cell, { buffer = buf, desc = "run code cell" })
          vim.keymap.set("v", lhs, send_region, { buffer = buf, desc = "run selection" })
        end

        local otter = require("otter")
        require("which-key").add({
          buffer = buf,
          { "<leader><cr>", send_cell, desc = "run code cell" },
          { "<leader>i", group = "[I]nsert code chunk" },
          { "<leader>ip", chunk("python"), desc = "python code chunk" },
          { "<leader>ij", chunk("julia"), desc = "julia code chunk" },
          { "<leader>if", chunk("fortran"), desc = "fortran code chunk" },
          { "<leader>ib", chunk("bash"), desc = "bash code chunk" },
          { "<leader>il", chunk("lua"), desc = "lua code chunk" },
          { "<leader>ic", "O# %%<cr>", desc = "Comment code chunk # %%" },
          { "<leader>o", group = "[o]tter & [O]verseer" },
          { "<leader>oa", otter.activate, desc = "otter [a]ctivate" },
          { "<leader>od", otter.deactivate, desc = "otter [d]eactivate" },
          { "<leader>Q", group = "[q]uarto" },
          {
            "<leader>QE",
            function()
              otter.export(true)
            end,
            desc = "[E]xport with overwrite",
          },
          { "<leader>Qa", "<cmd>QuartoActivate<cr>", desc = "[a]ctivate" },
          { "<leader>Qe", otter.export, desc = "[e]xport" },
          { "<leader>Qh", ":QuartoHelp ", desc = "[h]elp" },
          { "<leader>Qp", "<cmd>lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
          { "<leader>Qq", "<cmd>lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },
          { "<leader>Qr", group = "[r]un" },
          { "<leader>Qra", "<cmd>QuartoSendAll<cr>", desc = "run [a]ll" },
          { "<leader>Qrb", "<cmd>QuartoSendBelow<cr>", desc = "run [b]elow" },
          { "<leader>Qrr", "<cmd>QuartoSendAbove<cr>", desc = "to cu[r]sor" },
          {
            mode = "i",
            { "<C-x><C-x>", "<C-x><C-o>", desc = "omnifunc completion" },
            { "<M-i>", chunk("python"), desc = "python code chunk" },
            { "<M-j>", chunk("julia"), desc = "julia code chunk" },
            { "<M-m>", " |>", desc = "pipe" },
          },
        })
      end

      local filetypes = { "quarto", "markdown" }
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("PengVim_quarto_maps", { clear = true }),
        pattern = filetypes,
        callback = function(ev)
          attach(ev.buf)
        end,
      })
      -- this plugin is loaded by the FileType event of the first such buffer
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.tbl_contains(filetypes, vim.bo[buf].filetype) then
          attach(buf)
        end
      end
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
    keys = {
      { "<leader>ci", "<cmd>vsplit term://ipython --no-confirm-exit<cr>", desc = "new [i]python terminal" },
      { "<leader>cj", "<cmd>vsplit term://julia<cr>", desc = "new [j]ulia terminal" },
      { "<leader>cn", "<cmd>vsplit term://$SHELL<cr>", desc = "[n]ew terminal with shell" },
      { "<leader>cp", "<cmd>vsplit term://python<cr>", desc = "new [p]ython terminal" },
      {
        "<leader>cm",
        function()
          vim.print("job_id: " .. tostring(vim.b.terminal_job_id))
        end,
        desc = "[m]ark terminal (show job id)",
      },
      {
        "<leader>ct",
        function()
          vim.fn["slime#config"]()
        end,
        desc = "slime [t]arget terminal",
      },
    },
    init = function()
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
}
