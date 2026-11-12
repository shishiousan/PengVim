-- PengVim-lite: a fast companion to PengVim.
-- Runs with NVIM_APPNAME=pengvim-lite (fish: `nvl`), so it has its own
-- plugins, lockfile, data and cache. See lite/README.md.
vim.loader.enable() -- byte-compile and cache Lua modules

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lite.options")
require("lite.plugins") -- vim.pack.add + deferred plugin setup
require("lite.lsp")
require("lite.keymaps")
require("lite.autocmds")
