return {
  {
    "subnut/nvim-ghost.nvim",
    cmd = {
      "GhostTextStart",
    },
    config = function()
      vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "nvim_ghost_user_autocommands",
        pattern = { "*projmo*" }, -- 実際のドメインに合わせて変更
        command = "setfiletype markdown",
      })
    end,
  },
}
