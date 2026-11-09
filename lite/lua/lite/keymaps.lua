-- Core maps, trimmed from PengVim. Built-ins are kept as they are:
-- LSP grn/gra/gri/grt/gO/K, comments gc/gcc, diagnostics ]d/[d, quickfix ]q/[q.
local map = vim.keymap.set
local format = require("lite.format")
local picker = require("lite.plugins").picker

-- editing
map("i", "jk", "<esc>")
map("n", "<C-n>", "<cmd>nohlsearch<CR>")
map({ "n", "i" }, "<C-s>", function()
  if format.enabled() then
    format.format()
  end
  vim.cmd("silent! write")
end, { desc = "Format and write" })
map("n", "<leader>uf", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("autoformat " .. (vim.g.autoformat and "enabled" or "disabled"))
end, { desc = "Toggle autoformat" })
map("n", "<leader>j", "yyp", { desc = "Paste line below" })
map("n", "<leader>k", "yyP", { desc = "Paste line above" })
map("v", "<leader>j", "Yp", { desc = "Paste below" })
map("v", "<leader>k", "YP", { desc = "Paste above" })

-- write / quit
map("n", "<leader>ww", "<cmd>silent! write<CR>", { desc = "Write" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
map("n", "<leader>qw", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>qo", "<cmd>only<CR>", { desc = "Only this window" })

-- windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- diagnostics by severity (]d/[d are built in; the float on jump is set in options.lua)
local function jump(count, severity)
  return function()
    vim.diagnostic.jump({ count = count * vim.v.count1, severity = vim.diagnostic.severity[severity] })
  end
end
map("n", "]e", jump(1, "ERROR"), { desc = "Next Error" })
map("n", "[e", jump(-1, "ERROR"), { desc = "Prev Error" })
map("n", "]w", jump(1, "WARN"), { desc = "Next Warning" })
map("n", "[w", jump(-1, "WARN"), { desc = "Prev Warning" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- picker (mini.pick / mini.extra, set up on first use)
local function pick(fn)
  return function()
    local MiniPick, MiniExtra = picker()
    fn(MiniPick.builtin, MiniExtra.pickers)
  end
end
map("n", "<leader><leader>", pick(function(b) b.files() end), { desc = "Find files" })
map("n", "<leader>sg", pick(function(b) b.grep_live() end), { desc = "Live grep" })
map("n", "<leader>sw", pick(function(b) b.grep({ pattern = vim.fn.expand("<cword>") }) end), { desc = "Grep word" })
map("n", "<leader>,", pick(function(b) b.buffers() end), { desc = "Buffers" })
map("n", "<leader>fr", pick(function(_, x) x.oldfiles() end), { desc = "Recent files" })
map("n", "<leader>sh", pick(function(b) b.help() end), { desc = "Help pages" })
map("n", "<leader>sk", pick(function(_, x) x.keymaps() end), { desc = "Keymaps" })
map("n", "<leader>sd", pick(function(_, x) x.diagnostic() end), { desc = "Diagnostics" })
map("n", "<leader>sR", pick(function(b) b.resume() end), { desc = "Resume picker" })

-- git (mini.diff: ]h [h ]H [H hunks, gh / gH apply / reset)
map("n", "<leader>go", function()
  if _G.MiniDiff then
    MiniDiff.toggle_overlay()
  end
end, { desc = "Toggle diff overlay" })

-- LSP: buffer-local, only where a server attached
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lite_lsp_maps", { clear = true }),
  callback = function(ev)
    local function bmap(lhs, rhs, desc)
      map("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    bmap("gd", vim.lsp.buf.definition, "Goto definition")
    bmap("grr", pick(function(_, x) x.lsp({ scope = "references" }) end), "References")
    bmap("<leader>ss", pick(function(_, x) x.lsp({ scope = "document_symbol" }) end), "LSP symbols")
    bmap("<leader>sS", pick(function(_, x) x.lsp({ scope = "workspace_symbol" }) end), "LSP workspace symbols")
    -- mini.clue needs to re-create its triggers after new buffer-local maps
    if _G.MiniClue then
      MiniClue.ensure_buf_triggers(ev.buf)
    end
  end,
})
