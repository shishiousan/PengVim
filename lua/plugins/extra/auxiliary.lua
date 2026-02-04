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
