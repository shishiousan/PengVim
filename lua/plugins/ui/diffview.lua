return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = "Diff view close" },
      { "<leader>gdt", "<cmd>DiffviewToggleFiles<CR>", desc = "File panel toggle" },
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diff view open" },
    },
  },
}
