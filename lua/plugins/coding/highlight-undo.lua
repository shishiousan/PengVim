return {
  {
    "tzachar/highlight-undo.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("highlight-undo").setup({
        duration = 300,
        ignored_filetypes = {
          "snacks_picker_list",
          "snacks_picker_preview",
          "oil",
        },
      })
    end,
  },
}
