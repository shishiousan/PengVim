return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
      vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
      vim.keymap.set("i", "<A-a>", neocodeium.accept_line)
      vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete)
      vim.keymap.set("i", "<A-r>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<A-c>", neocodeium.clear)
    end,
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   -- branch = "canary",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" },
  --     { "nvim-lua/plenary.nvim" },
  --   },
  --   opts = {
  --     debug = true, -- Enable debugging
  --     window = {
  --       layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
  --       width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
  --       height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
  --       relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
  --       border = "rounded", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
  --       row = nil, -- row position of the window, default is centered
  --       col = nil, -- column position of the window, default is centered
  --       title = "Copilot Chick", -- title of chat window
  --       footer = nil, -- footer of chat window
  --       zindex = 1, -- determines if window is on top or below other floating windows
  --     },
  --   },
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          ["*"] = false, -- disable for all filetype
        },
      })
    end,
  },
  {
    -- "yetone/avante.nvim",
    -- event = "VeryLazy",
    -- lazy = false,
    -- opts = {
    --   provider = "copilot",
    -- },
    -- build = ":AvanteBuild",
    -- dependencies = {
    --   "stevearc/dressing.nvim",
    --   "nvim-lua/plenary.nvim",
    --   "MunifTanjim/nui.nvim",
    --   "nvim-tree/nvim-web-devicons",
    --   "zbirenbaum/copilot.lua",
    --   {
    --     "HakonHarnes/img-clip.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --       default = {
    --         embed_image_as_base64 = false,
    --         prompt_for_file_name = false,
    --         drag_and_drop = {
    --           insert_mode = true,
    --         },
    --         use_absolute_path = true,
    --       },
    --     },
    --   },
    --   {
    --     -- Make sure to setup it properly if you have lazy=true
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     opts = {
    --       file_types = { "markdown", "Avante" },
    --     },
    --     ft = { "markdown", "Avante" },
    --   },
    -- },
  },
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  --   config = function()
  --     vim.keymap.set("i", "<C-CR>", 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       silent = true,
  --       replace_keycodes = false,
  --     })
  --
  --     vim.keymap.set("i", "<C-tab>", 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       silent = true,
  --       replace_keycodes = false,
  --     })
  --
  --     vim.g.copilot_no_tab_map = true
  --
  --     -- TODO: translate this into lua ver
  --     vim.cmd([[
  --     let g:copilot_filetypes = {
  --         \ '*': v:false,
  --         \ 'fortran': v:false,
  --         \ 'julia': v:false,
  --         \ 'lua': v:false,
  --         \ 'go': v:false,
  --         \}
  --     ]])
  --   end,
  --   keys = {
  --     {
  --       "<leader>CC",
  --       function()
  --         local stat = vim.g.copilot_enabled
  --         if stat == nil or stat == 1 then
  --           vim.cmd([[Copilot disable]])
  --           vim.notify("Copilot disabled")
  --         elseif stat == 0 then
  --           vim.cmd([[Copilot enable]])
  --           vim.notify("Copilot enabled")
  --         else
  --           vim.notify("Failed to toggle Copilot", 4)
  --         end
  --       end,
  --       mode = { "n" },
  --       desc = "Toggle copilot",
  --       -- NOTE: this key overwrite default key for codelens
  --     },
  --     {
  --       "<C-S-CR>",
  --       function()
  --         vim.cmd([[Copilot panel]])
  --       end,
  --       mode = { "i" },
  --       desc = "Open copilot panel",
  --     },
  --     {
  --       "<leader>CB",
  --       function()
  --         local lang = vim.bo.filetype
  --         -- local stats = vim.b.copilot_enabled
  --         vim.cmd("let b:copilot_enabled = {'" .. lang .. "': v:true }")
  --         print("Copilot enabled locally for " .. lang)
  --       end,
  --     },
  --   },
  -- },
}
