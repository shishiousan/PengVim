return {
  { -- keep the cursor in the middle
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    config = function()
      require("scrollEOF").setup({
        pattern = "*",
        insert_mode = false,
        floating = false,
        disabled_filetypes = { "snacks_picker_list" }, -- explorer uses scrolloff=0
        disabled_modes = {},
      })
    end,
  },
}
