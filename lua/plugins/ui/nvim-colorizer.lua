return {
  {
    "catgoose/nvim-colorizer.lua",
    lazy = true,
    config = function()
      -- no auto-attach (the fork defaults to every filetype); <leader>uH toggles per buffer
      require("colorizer").setup({ filetypes = {} })
    end,
    keys = {
      {
        "<leader>uH",
        "<cmd>ColorizerToggle<CR>",
        desc = "Colorizer Toggle",
      },
    },
  },
}
