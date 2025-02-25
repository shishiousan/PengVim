return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "tmux",
      },
    },
  },
  {
    "jaimecgomezz/here.term",
    keys = {
      {
        "<M-t>",
        function()
          require("here-term").toggle_terminal()
        end,
        mode = { "n", "i", "t" },
        desc = "Toggle Terminal Here",
      },
      {
        "<M-S-t>",
        function()
          require("here-term").kill_terminal()
        end,
        mode = { "n", "i", "t" },
        desc = "Kill Terminal Here",
      },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      nvim_tmux_nav.setup({
        disable_when_zoomed = true,
      })
    end,
    keys = {
      {
        "<C-h>",
        "<cmd>NvimTmuxNavigateLeft<cr>",
        desc = "Got to the left pane",
      },
      {
        "<C-j>",
        "<cmd>NvimTmuxNavigateDown<cr>",
        desc = "Got to the down pane",
      },
      {
        "<C-k>",
        "<cmd>NvimTmuxNavigateUp<cr>",
        desc = "Got to the up pane",
      },
      {
        "<C-l>",
        "<cmd>NvimTmuxNavigateRight<cr>",
        desc = "Got to the right pane",
      },
    },
  },
}
