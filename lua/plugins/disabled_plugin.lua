return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").hide()
      vim.cmd([[set laststatus=0]])
      vim.cmd([[hi! link StatusLine Normal]])
      vim.cmd([[hi! link StatusLineNC Normal]])
      vim.cmd([[set statusline=%{repeat('─',winwidth('.'))}]])
    end,
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   optional = true,
  --   opts = {
  --     options = {
  --       -- mode = "tabs",
  --       -- always_show_bufferline = false,
  --       -- custom_filter = function(buf_number, buf_numbers)
  --       -- filter out filetypes you don't want to see
  --       -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
  --       --   return true
  --       -- end
  --       -- return false -- defautly disable bufferline
  --       -- end,
  --       -- indicator = {
  --       --   style = "underline",
  --       -- },
  --       -- separator_style = "slant",
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>bL",
  --       "<cmd>BufferLineCloseLeft<CR>",
  --       mode = { "n" },
  --       silent = false,
  --       desc = "Delete buffers to the left",
  --     },
  --     {
  --       "<leader>bR",
  --       "<cmd>BufferLineCloseRight<CR>",
  --       mode = { "n" },
  --       silent = false,
  --       desc = "Delete buffers to the right",
  --     },
  --     {
  --       "<leader>bp",
  --       "<cmd>BufferLineMovePrev<CR>",
  --       mode = { "n" },
  --       silent = false,
  --       desc = "Move buffer to previous ",
  --     },
  --     {
  --       "<leader>bn",
  --       "<cmd>BufferLineMoveNext<CR>",
  --       mode = { "n" },
  --       silent = false,
  --       desc = "Move buffer to next ",
  --     },
  --     {
  --       "<leader>bP",
  --       "<cmd>BufferLineTogglePin<CR>",
  --       mode = { "n" },
  --       silent = false,
  --       desc = " Toggle Pin for buffer ",
  --     },
  --     {
  --       "<leader>bC",
  --       "<cmd>BufferLineGroupClose ungrouped<CR>",
  --       mode = { "n" },
  --       silent = false,
  --       desc = " Delete all non-pinned buffer ",
  --     },
  --     {
  --       "<leader>bt",
  --       function()
  --         local val = vim.o.showtabline
  --         if val == 0 then
  --           vim.print("Enabling the bufferline")
  --           vim.cmd("set showtabline=2")
  --         else
  --           vim.print("Disabling the bufferline")
  --           vim.cmd("set showtabline=0")
  --         end
  --       end,
  --       mode = { "n" },
  --       desc = " Toggle bufferline",
  --     },
  --   },
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   keys = {
  --     {
  --       "<leader>hs",
  --       function()
  --         local lualine = require("lualine")
  --         local stat = vim.g.statStatusLine
  --         if stat == nil or stat == true then
  --           vim.g.statStatusLine = false
  --           vim.cmd([[set laststatus=0]])
  --           vim.cmd([[hi! link StatusLine Normal]])
  --           vim.cmd([[hi! link StatusLineNC Normal]])
  --           vim.cmd([[set statusline=%{repeat('─',winwidth('.'))}]])
  --         else
  --           vim.g.statStatusLine = true
  --         end
  --         lualine.hide({ unhide = vim.g.statStatusLine })
  --       end,
  --       mode = { "n" },
  --       desc = "toggle status line",
  --     },
  --   },
  -- }
  -- {
  --   "theRealCarneiro/hyprland-vim-syntax",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   ft = "hypr",
  -- },
}
