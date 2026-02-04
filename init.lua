if vim.g.vscode then
  return
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
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.ui" },
    { import = "plugins.lang" },
    -- { import = "plugins.playground" },
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

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.quickfix")
require("config.redir")

if vim.bo.filetype == "lazy" then
  vim.cmd([[do VimResized]])
end

vim.deprecate = function() end
