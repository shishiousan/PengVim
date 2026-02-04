return {
  {
    "folke/which-key.nvim",
    opts_extend = { "spec" },
    opts = {
      ---@type wk.Win
      win = {
        height = { min = 4, max = 25 },
        col = 0.5,
        row = -1,
        border = "double",
        padding = { 0, 1 },
        title = false,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {},
      },
      layout = {
        width = { min = 20 },
        spacing = 1,
        align = "left",
      },
      show_keys = false,
      show_help = false,
      preset = "classic",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "[tab]s" },
          { "<leader>c", group = "[c]ode" },
          { "<leader>C", group = "[C]olorscheme" },
          { "<leader>d", group = "[d]ebug" },
          { "<leader>dp", group = "[p]rofiler" },
          { "<leader>f", group = "[f]ile/[f]ind" },
          { "<leader>g", group = "[g]it" },
          { "<leader>gd", group = "[d]iffview" },
          { "<leader>L", group = "[L]sp" },
          { "<leader>o", group = "[o]verseer" },
          { "<leader>p", group = "[p]enguin" },
          { "<leader>q", group = "[q]uit/session" },
          { "<leader>Q", group = "[Q]uarto" },
          { "<leader>s", group = "[s]earch([s]nacks)" },
          { "<leader>u", group = "[u]i", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfi[x]", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "[b]uffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "[w]indows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        {
          { "<leader>w", group = "[w]indow" },
          { "<leader>wh", "<C-W>h", desc = "Move to left" },
          { "<leader>wj", "<C-W>j", desc = "Move down" },
          { "<leader>wk", "<C-W>k", desc = "Move up" },
          { "<leader>wl", "<C-W>l", desc = "Move to right" },
          { "<leader>z", group = "[z]oom" },
          { "<leader>zi", "<cmd>tab split<CR>", desc = "Zoom in" },
          { "<leader>zo", "<cmd>tab close<CR>", desc = "Zoom out" },
        },
      })
    end,
  },
}
