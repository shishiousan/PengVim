return {
  {
    "subnut/nvim-ghost.nvim",
    cmd = {
      "GhostTextStart",
    },
    init = function()
      -- :GhostTextStart (and :GhostTextStop) only exist when autostart is off;
      -- with autostart on, the command this spec lazy-loads on is never defined.
      vim.g.nvim_ghost_autostart = 0
    end,
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
