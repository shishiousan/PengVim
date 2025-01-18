return {
  {
    "2giosangmitom/nightfall.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "dgox16/oldworld.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "baliestri/aura-theme",
    lazy = true,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "fcancelinha/nordern.nvim",
    lazy = true,
    branch = "master",
    priority = 1000,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
    end,
  },
  {
    "0xstepit/flow.nvim",
    name = "Flow",
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup({
        transparent = true,
        fluo_color = "orange", -- pink, yellow, orange, or green.
        mode = "normal", --  normal, dark, or bright
        aggressive_spell = false,
      })
    end,
  },
  {
    "ray-x/aurora",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_transparent = 1
      vim.g.aurora_bold = 1
    end,
    config = function() end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("moonfly")
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        override_by_filename = {
          ["toml"] = {
            icon = "",
            color = "#6d8086",
            name = "Toml",
          },
        },
      })
    end,
  },
  {
    "ojroques/nvim-bufdel",
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          style = {
            "#00ffff",
            "#c21f30",
          },
          exclude_filetypes = {
            toml = true,
          },
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
          style = "#b30eec",
          use_treesitter = true,
          exclude_filetypes = {
            toml = true,
          },
        },
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },
  {
    "anuvyklack/windows.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup({
        ignore = {
          buftype = { "quickfix", "terminal" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
        },
        animation = {
          enable = false,
        },
      })
    end,
    keys = {
      {
        "<leader>wt",
        "<cmd>WindowsToggleAutowidth<CR>",
        desc = "Toggle Autowidth",
      },
      {
        "<C-w>z",
        "<cmd>WindowsMaximize<CR>",
        desc = "WindowsMaximize",
      },
      {
        "<C-w>=",
        "<cmd>WindowsEqualize<CR>",
        desc = "WindowsEqualize",
      },
      {
        "<C-w>_",
        "<cmd>WindowsMaximizeVertically<CR>",
        desc = "WindowsMaximizeVertically",
      },
      {
        "<C-w>|",
        "<cmd>WindowsMaximizeHorizontally<CR>",
        desc = "WindowsMaximizeHorizontally",
      },
    },
  },
}
