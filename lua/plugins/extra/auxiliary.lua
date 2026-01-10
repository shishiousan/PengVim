return {
  { -- Penguins go crazy
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>pp",
        function()
          require("duck").hatch("🐧")
        end,
        desc = "Penguins hatch",
      },
      {
        "<leader>pg",
        function()
          require("duck").cook()
        end,
        desc = "Penguins bye bye",
      },
      {
        "<leader>pB",
        function()
          require("duck").cook_all()
        end,
        desc = "All Penguins bye bye",
      },
    },
  },
  {
    "jackplus-xyz/player-one.nvim",
    enabled = false,
    event = { "VimEnter" },
    ---@type PlayerOne.Config
    opts = {
      is_enabled = true,
      min_interval = 0.05,
      ---Available presets: "chiptune", "crystal", "synth"
      theme = "chiptune",
    },
  },
  {
    "jessekelighine/vindent.vim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.vindent_motion_OO_next = "]="
      vim.g.vindent_motion_OO_prev = "[="
      vim.g.vindent_motion_less_next = "]-"
      vim.g.vindent_motion_less_prev = "[-"
      vim.g.vindent_motion_more_next = "]+"
      vim.g.vindent_motion_more_prev = "[+"
      vim.g.vindent_motion_XX_ss = "[p"
      vim.g.vindent_motion_XX_se = "]p"
      vim.g.vindent_motion_OX_ss = "[P"
      vim.g.vindent_motion_OX_se = "]P"
      vim.g.vindent_object_OO_ii = "iI"
      vim.g.vindent_object_XX_ii = "ii"
      vim.g.vindent_object_XX_ai = "ai"
      vim.g.vindent_object_XX_aI = "aI"
      vim.g.vindent_jumps = 1
      vim.g.vindent_begin = 1
      vim.g.vindent_count = 0
    end,
    keys = {
      {
        "-=",
        function()
          local count = vim.v.count > 0 and vim.v.count or 5
          for _ = 1, count do
            vim.fn.execute("normal ]-")
          end
        end,
        desc = "5 times next lesser indent",
        mode = "n",
      },
      {
        "--=",
        function()
          local count = vim.v.count > 0 and vim.v.count or 5
          for _ = 1, count do
            vim.fn.execute("normal [-")
          end
        end,
        desc = "5 times prev lesser indent",
        mode = "n",
      },
    },
  },
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
  { -- interactive coding with opencode
    "sudo-tee/opencode.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("opencode").setup({})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
      },
      "saghen/blink.cmp",
      "folke/snacks.nvim",
    },
  },
}
