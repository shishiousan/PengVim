if vim.g.vscode then
  -- VSCode extension
  return
elseif vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "MonaspiceKr Nerd Font:h13"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_scale_factor = 1.0
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  -- require("config.basic"),
  -- require("config.autocmds"),
  spec = {
    { import = "config.basic" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
    keymaps = false,
  },
  news = {
    neovim = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  checker = {
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = false, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = true, -- check for pinned packages that can't be updated
  },
})

require("config.keymaps")
require("config.options")
require("config.autocmds")
