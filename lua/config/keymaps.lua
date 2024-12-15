-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- exit by jj
map("i", "jk", "<esc>")
-- map("i", "jj", "<esc>")

-- remove hilight
map("n", "<C-n>", "<cmd>nohlsearch<CR>")

-- yank and paste
--normal
map("n", "<leader>j", "yyp", { desc = "Paste line below" })
map("n", "<leader>k", "yyP", { desc = "Paste line above" })
--visual
map("v", "<leader>j", "Yp", { desc = "Paste below" })
map("v", "<leader>k", "YP", { desc = "Paste above" })

-- alternative for zoom out and in
map("n", "<leader>zi", "<cmd>tab split<CR>", { desc = "Zoom in" })
map("n", "<leader>zo", "<cmd>tab close<CR>", { desc = "Zoom out" })

-- quit
map("n", "<leader>qw", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>qo", "<cmd>only<CR>", { desc = "Only" })

-- floating terminal
-- local lazyterm = function()
--   Snacks.terminal(nil, { cwd = LazyVim.root() })
-- end
-- map("n", "<leader>tT", lazyterm, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-/>", function()
--   local ft = vim.bo.filetype
--   if ft == "lazyterm" then
--     vim.cmd("close")
--   else
--     local cwd = vim.fn.expand("%:p:h")
--     Snacks.terminal(nil, { cwd = cwd, border = "rounded" })
--   end
-- end, { desc = "Terminal (parent directory)" })
--
-- map("n", "<c-_>", function()
--   local ft = vim.bo.filetype
--   if ft == "lazyterm" then
--     vim.cmd("close")
--   else
--     local cwd = vim.fn.expand("%:p:h")
--     Snacks.terminal(nil, { cwd = cwd, border = "rounded" })
--   end
-- end, { desc = "Terminal (parent directory)" })

vim.keymap.del("n", "<c-_>")
vim.keymap.del("n", "<c-/>")
-- vim.keymap.del("n", "<leader>tT")

-- save file
-- map("n", "<leader>fs", "<cmd>silent! w<CR>", { desc = "write" })
map("n", "<leader>ww", "<cmd>silent! w<CR>", { desc = "write" })
map("n", "<leader>fa", "<cmd>silent! wa<CR>", { desc = "write all" })
map("n", "<leader>fq", "<cmd>silent! wa<CR><cmd>qa<CR>", { desc = "write all and quit all" })

map("n", "<leader>rp", "o<esc>v:'<,'>!erun -bs %<CR>")
-- map("n", "<leader>rr", ":!erun -bs %<CR>")
map("n", "<leader>rr", function()
  local text = vim.cmd([[!erun -bs %]])
  vim.print(text)
end)
--
vim.keymap.del("n", "<leader>ft")
map("n", "<leader>ft", function()
  if vim.g.use_myfmt then
    vim.notify("use_myfmt is disabled")
  else
    vim.notify("use_myfmt is enabled")
  end
  vim.g.use_myfmt = not vim.g.use_myfmt
end, { desc = "Toggle use_myfmt" })

map("n", "<leader>R", function()
  vim.notify("ReadMode Toggled")
  -- vim.o.scrolloff = vim.o.scrolloff == 4 and 999 or 4
  vim.cmd([[windo set scrollbind!]])
end, { desc = "Toggle readermode" })

map("n", "<leader>cn", function()
  local ind = vim.g.currentCSNum
  if ind == vim.g.CSListsLen then
    ind = 1
  else
    ind = ind + 1
  end
  vim.g.currentCSNum = ind
  SwitchCS(ind)
end, { desc = "Next Colorscheme" })

map("n", "<leader>cp", function()
  local ind = vim.g.currentCSNum
  if ind == 1 then
    ind = vim.g.CSListsLen
  else
    ind = ind - 1
  end
  vim.g.currentCSNum = ind
  SwitchCS(ind)
end, { desc = "Previous Colorscheme" })

map("n", "<leader>bD", function()
  vim.cmd([[%bd|e#|bd#|'"]])
end, { desc = "Delete other buffers" })

map("n", "<leader>rs", function()
  require("persistence").load()
end, { desc = "Restore Session" })

map("n", "<leader>ua", function()
  ToggleAutoComplete()
end, { desc = "Toggle Auto Complete" })
