return {
  {
    "sindrets/diffview.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = "Diff view close" },
      { "<leader>gdt", "<cmd>DiffviewToggleFiles<CR>", desc = "File panel toggle" },
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diff view open" },
    },
  },
}
