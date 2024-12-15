local wk = require("which-key")

wk.add({
  {
    { "<leader>w", group = "window" },
    { "<leader>wh", "<C-W>h", desc = "Move to left" },
    { "<leader>wj", "<C-W>j", desc = "Move down" },
    { "<leader>wk", "<C-W>k", desc = "Move up" },
    { "<leader>wl", "<C-W>l", desc = "Move to right" },
    { "<leader>z", group = "Zoom" },
    { "<leader>zi", "<cmd>tab split<CR>", desc = "Zoom in" },
    { "<leader>zo", "<cmd>tab close<CR>", desc = "Zoom out" },
  },
})

return {
  "folke/which-key.nvim",
  opts = {
    ---@type wk.Win
    win = {
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      row = -1,
      border = "double",
      padding = { 0, 1 }, -- extra window padding [top/bottom, right/left]
      title = false,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      width = { min = 20 }, -- min and max width of the columns
      spacing = 1, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    show_keys = false,
    show_help = false,
  },
}
