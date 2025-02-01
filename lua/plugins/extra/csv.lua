return {
  { -- better csv view
    "hat0uma/csvview.nvim",
    ft = "csv",
    config = function()
      require("csvview").setup({
        view = {
          min_column_width = 5,
          spacing = 2,
          display_mode = "border",
        },
      })
    end,
  },
}
