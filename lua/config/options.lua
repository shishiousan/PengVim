local g = vim.g
local ft = vim.filetype
local opt = vim.opt

g.autoformat = true
g.markdown_recommended_style = 0

g.currentCSNum = 1
g.CSLists = {
  "moonfly",
  "nightfall",
  "flow",
  "zenbones",
}
g.CSListsLen = #vim.g.CSLists

g.nrrw_rgn_vert = 1 -- default is 0
g.nrrw_rgn_wdth = math.floor(vim.fn.winwidth(0) / 2) -- default is 30

g.cmp_enabled = true

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
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
-- opt.formatoptions = ""
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hidden = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.laststatus = 0
opt.linebreak = true
opt.list = true
-- opt.listchars:append "space:⋅"
-- opt.listchars:append "eol:↴"
opt.ls = 2
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.report = 50
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = math.floor(vim.fn.winheight(0) / 2)
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
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
opt.statusline = "%F"
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = vim.g.vscode and 1000 or 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.wrapscan = false

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

vim.api.nvim_create_user_command("CheckScreen", function()
  local width = vim.fn.winwidth(0)
  local height = vim.fn.winheight(0)
  local nrow = vim.api.nvim_eval("&lines")
  local ncol = vim.api.nvim_eval("&columns")

  print("wedth, height, nrow, ncol")
  print(width, height, nrow, ncol)

  local split = not (width == ncol)
  local vsplit = not (height == nrow)

  if split and vsplit then
    print("current buffer is in both horizontal and vertical split")
    return
  elseif split then
    print("current buffer is in horizontal split")
    return
  elseif vsplit then
    print("current buffer is in vertical split")
    return
  end
end, {})

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
