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
  { -- famous net meme
    "GitMarkedDan/you-are-an-idiot.nvim",
    enabled = false,
    lazy = true,
    config = function()
      local opts = {
        window = {
          relative = "editor",
          style = "minimal",
          border = "single",
          width = 17,
          height = 1,
        },
        resize_window_to_fit = true,
        text = "You are an idiot!",
        flash_interval = 0,
        focus_cursor = true,
        is_scratch = true,
        min_velocity = 20,
        max_velocity = 30,
        reproduce_count = 5,
        initial = {
          {
            x = "rand",
            y = "rand",
            moving = true,
          },
        },
        delta_time = 0.05,
      }
      require("you-are-an-idiot").setup(opts)
      vim.api.nvim_create_user_command("ToggleIdiot", function()
        local idiot = require("you-are-an-idiot")
        if idiot.is_running() then
          idiot.abort()
        else
          idiot.run()
          vim.cmd([[silent exec "! mpv ~/Music/you.ogg"]])
        end
      end, { desc = "Toggles YouAreAnIdiot" })
    end,
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
    "johannww/tts.nvim",
    enabled = false,
    cmd = { "TTS" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      voice = "en-GB-SoniaNeural",
      speed = 1.0,
    },
  },
  {
    "glacambre/firenvim",
    lazy = false,
    build = ":call firenvim#install(0)",
  },
  {
    "chrisbra/unicode.vim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tomiis4/BufferTabs.nvim",
    enabled = false,
    -- lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("buffertabs").setup({
        ---@type 'none'|'single'|'double'|'rounded'|'solid'|'shadow'|table
        border = "single",
        padding = 1,
        icons = true,
        modified = " ",
        hl_group = "Keyword",
        hl_group_inactive = "Comment",
        show_all = false,
        show_single_buffer = true,
        display = "column",
        horizontal = "right",
        vertical = "top",
        timeout = 0,
        show_id = true,
        max_buffers = 0,
        surround_active_buffer = 0,
      })
    end,
    keys = {
      {
        "<leader>ub",
        "<cmd>BufferTabsToggle<cr>",
        desc = "Toggle [b]ufferTabs",
      },
    },
  },
}
