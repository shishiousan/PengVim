local g = vim.g
local ft = vim.filetype
local opt = vim.opt

g.autoformat = true
g.markdown_recommended_style = 0

g.currentCSNum = 1
g.CSLists = {
  "nightfly",
  "moonfly",
}
g.CSListsLen = #vim.g.CSLists

ft.add({
  extension = {
    gp = "gnuplot",
    gnuplot = "gnuplot",
    gnu = "gnuplot",
    plt = "gnuplot",
    plot = "gnuplot",
    pal = "gnuplot",
  },
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.cursorcolumn = false
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  vert = "▏",
  horiz = "⎯",
}
opt.foldlevel = 99
-- opt.foldnestmax = 2
-- opt.foldlevelstart = 1
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- opt.foldnestmax = 1
opt.formatexpr = "v:lua.require'conform'.formatexpr()"
-- opt.formatoptions = ""
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.jumpoptions = "view"
opt.laststatus = 0
opt.linebreak = true
opt.list = true
-- opt.listchars:append "space:⋅"
-- opt.listchars:append "eol:↴"
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.report = 50
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 999 -- keep the cursor centered; scrollEOF caps it at half the window
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.showtabline = 0
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = false
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
-- opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
-- laststatus=0 hides the last statusline; the ones between horizontal splits
-- are drawn as a line instead of text
opt.statusline = "%{repeat('─',winwidth('.'))}"
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.wrapscan = false

-- Diagnostics: one place for global settings.
-- vim.diagnostic.goto_next() used to open a float after jumping; keep that for
-- the built-in ]d/[d and the ]e/]w maps (vim.diagnostic.jump() reads this).
vim.diagnostic.config({
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})

vim.api.nvim_create_user_command("PengVimSetCS", function(opts)
  g.currentCSNum = tonumber(opts.fargs[1])
  vim.notify(vim.g.CSLists[g.currentCSNum])
  vim.cmd("colorscheme " .. vim.g.CSLists[g.currentCSNum])
end, {
  nargs = 1,
})

vim.api.nvim_create_user_command("NextColorScheme", function()
  local ind = g.currentCSNum
  if ind == g.CSListsLen then
    ind = 1
  else
    ind = ind + 1
  end
  vim.cmd("PengVimSetCS " .. ind)
end, {})

vim.api.nvim_create_user_command("PrevColorScheme", function()
  local ind = g.currentCSNum
  if ind == 1 then
    ind = g.CSListsLen
  else
    ind = ind - 1
  end
  vim.cmd("PengVimSetCS " .. ind)
end, {})
