if vim.g.vscode then
  return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- options first, so plugins loaded at startup see them
require("config.options")

require("lazy").setup({
  spec = {
    -- lang/*.lua each add parsers to ensure_installed. lazy.nvim only merges lists
    -- for fragments at or after the one declaring opts_extend, so declare it first.
    { "nvim-treesitter/nvim-treesitter", opts_extend = { "ensure_installed" } },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.ui" },
    { import = "plugins.lang" },
    { -- gitignored scratch specs; skip the import on machines that don't have them
      import = "plugins.playground",
      cond = vim.uv.fs_stat(vim.fn.stdpath("config") .. "/lua/plugins/playground") ~= nil,
    },
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
  checker = { enabled = false },
})

-- these use plugins (Snacks, conform, mini.icons, the colorscheme), so load after setup
require("config.customCS")
require("config.keymaps")
require("config.autocmds")
require("config.quickfix")

if vim.bo.filetype == "lazy" then
  vim.cmd([[do VimResized]])
end
