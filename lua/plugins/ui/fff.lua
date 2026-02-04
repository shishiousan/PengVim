return {
  {
    "dmtrKovalenko/fff.nvim",
    lazy = false, -- keep it false
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      base_path = vim.fn.getcwd(),
      prompt = "🐧 ",
      title = "FFF",
      max_results = 100,
      max_threads = 8,
      lazy_sync = true, -- set to false if you want file indexing to start on open
      layout = {
        height = 0.8,
        width = 0.8,
        prompt_position = "top",
        preview_position = "right",
        preview_size = 0.5,
      },
      preview = {
        enabled = true,
        max_size = 5 * 1024 * 1024, -- 5MB
        chunk_size = 8192,
        binary_file_threshold = 1024,
        imagemagick_info_format_str = "%m: %wx%h, %[colorspace], %q-bit",
        line_numbers = false,
        wrap_lines = false,
        show_file_info = true,
        filetypes = {
          svg = { wrap_lines = true },
          markdown = { wrap_lines = true },
          text = { wrap_lines = true },
        },
      },
      keymaps = {
        close = "<Esc>",
        select = "<CR>",
        select_split = "<C-s>",
        select_vsplit = "<C-v>",
        select_tab = "<C-t>",
        move_up = { "<Up>", "<C-p>" },
        move_down = { "<Down>", "<C-n>" },
        preview_scroll_up = "<C-u>",
        preview_scroll_down = "<C-d>",
        toggle_debug = "<F2>",
      },
      hl = {
        border = "FloatBorder",
        normal = "Normal",
        cursor = "CursorLine",
        matched = "IncSearch",
        title = "Title",
        prompt = "Question",
        active_file = "Visual",
        frecency = "Number",
        debug = "Comment",
      },
      frecency = {
        enabled = true,
        db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
      },
      debug = {
        enabled = false,
        show_scores = false,
      },
      logging = {
        enabled = true,
        log_file = vim.fn.stdpath("log") .. "/fff.log",
        log_level = "info",
      },
    },
    keys = {
      {
        "<leader><leader>",
        function()
          -- require("fff").find_files()
          require("fff").find_in_git_root()
        end,
        desc = "FFFind files",
      },
      {
        "<leader>fo",
        function()
          -- require("fff").scan_files()
          local dir = vim.fn.expand("%:p:h")
          require("fff").find_files_in_dir(dir)
        end,
        desc = "FFFind reveal",
      },
    },
  },
}
