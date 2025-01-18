if vim.g.vscode then
  return
elseif vim.g.neovide then
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
  spec = {
    { import = "config.basic" },
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
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
    concurrency = nil,
    notify = false,
    frequency = 3600,
    check_pinned = true,
  },
})

require("config.keymaps")
require("config.options")
require("config.autocmds")
require("config.redir")

vim.api.nvim_set_hl(0, "VertSplit", { fg = "#b020ea", bg = "NONE" })
