local wk = require("which-key")

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function delMap(mode, lhs)
  vim.keymap.del(mode, lhs)
end

map("i", "jk", "<esc>")

map("n", "<C-n>", "<cmd>nohlsearch<CR>")

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<leader>*", "*''cgn", { desc = "Replace word under cursor" })

map("n", "<leader>j", "yyp", { desc = "Paste line below" })
map("n", "<leader>k", "yyP", { desc = "Paste line above" })
map("v", "<leader>j", "Yp", { desc = "Paste below" })
map("v", "<leader>k", "YP", { desc = "Paste above" })

map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
map("n", "<leader>qw", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>qo", "<cmd>only<CR>", { desc = "Only" })

-- save file
map({ "n", "i" }, "<C-s>", function()
  if vim.g.autoformat then
    require("conform").format({})
  end
  vim.cmd("silent! w")
end, { desc = "write" })

map("n", "<leader>uf", function()
  if vim.g.autoformat then
    vim.notify("autoformat is disabled")
  else
    vim.notify("autoformat is enabled")
  end
  vim.g.autoformat = not vim.g.autoformat
end, { desc = "Toggle autoformat" })

map("n", "<leader>ww", "<cmd>silent! w<CR>", { desc = "write" })
map("n", "<leader>fa", "<cmd>silent! wa<CR>", { desc = "write all" })
map("n", "<leader>fq", "<cmd>silent! wa<CR><cmd>qa<CR>", { desc = "write all and quit all" })

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle featured by Snacks
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
  :map("<leader>uc")
Snacks.toggle
  .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
  :map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")
map("n", "<leader>ua", function()
  local abool = vim.b.completion
  if abool == nil then
    abool = require("blink.cmp.config").enabled()
  end
  if abool then
    vim.notify("Auto Complete is disabled")
  else
    vim.notify("Auto Complete is enabled")
  end
  vim.b.completion = not abool
end, { desc = "Toggle Auto Complete" })

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = vim.uv.cwd() })
  end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gf", function()
    Snacks.lazygit.log_file()
  end, { desc = "Lazygit Current File History" })
  map("n", "<leader>gl", function()
    Snacks.lazygit.log({ cwd = vim.uv.cwd() })
  end, { desc = "Lazygit Log" })
  map("n", "<leader>gL", function()
    Snacks.lazygit.log()
  end, { desc = "Lazygit Log (cwd)" })
end

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

map("n", "<leader>Cn", ":NextColorScheme<cr>", { desc = "Next Colorscheme" })
map("n", "<leader>Cp", ":PrevColorScheme<cr>", { desc = "Previous Colorscheme" })

map("n", "<leader>rs", function()
  require("persistence").load()
end, { desc = "Restore Session" })


