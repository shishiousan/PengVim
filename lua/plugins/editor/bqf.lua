return {
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
      })
    end,
  },
}
