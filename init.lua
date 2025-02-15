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
    { import = "plugins" },
    { import = "plugins.extra.csv" },
    { import = "plugins.extra.japanese" },
    { import = "plugins.extra.markdown" },
    { import = "plugins.extra.typst" },
    { import = "plugins.extra.yazi" },
    { import = "plugins.extra.oil" },
    { import = "plugins.extra.auxiliary" },
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
require("config.redir")

-- custom highlight after loading colorscheme
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#b020ea", bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#b020ea", bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#c6c6c6", bg = "NONE" })

if vim.bo.filetype == "lazy" then
  vim.cmd([[do VimResized]])
end
