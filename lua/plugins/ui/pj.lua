return {
  {
    "josephschmitt/pj.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "Pj", "PjCd" },
    keys = {
      { "<leader>fp", "<cmd>Pj<cr>", desc = "Find Projects" },
    },
    opts = {
      pj = {
        cmd = "auto",
        args = {},
        icons = true,
        cache = false,
        auto = {
          prefer_system = true,
        },
      },

      picker = {
        type = "snacks",
      },

      behavior = {
        cd_on_select = true,
        cd_scope = "tab", -- "tab" (tcd) or "global" (cd)
        session_manager = nil, -- nil, "auto-session", or "persistence"
      },

      keymaps = {
        open = "<CR>",
        split = "<C-x>",
        vsplit = "<C-s>",
        tab = "<C-t>",
        depth_increase = "<C-l>",
        depth_decrease = "<C-h>",
      },

      depth = {
        initial = nil, -- nil means 3
        min = 1,
        max = 10,
      },
    },
  },
}
