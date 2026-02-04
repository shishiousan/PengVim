return {
  { -- keep the cursor in the middle
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    config = function()
      require("scrollEOF").setup({
        pattern = "*",
        insert_mode = false,
        floating = false,
        disabled_filetypes = {},
        disabled_modes = {},
      })
    end,
  },
}
