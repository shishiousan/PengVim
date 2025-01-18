vim.g.autoformat = true

local opt = vim.opt

opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  vert = "▏",
}
opt.foldlevel = 99
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.laststatus = 0
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 4
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
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.g.currentCSNum = 1
vim.g.CSLists = {
  "moonfly",
  "nightfall",
  "flow",
  "aurora",
  "cyberdream",
  "zenbones",
  "binary",
}

vim.g.CSListsLen = #vim.g.CSLists
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
-- NOTE: on the default prohibit to go back to top
-- from last line in search.
vim.opt.wrapscan = false
-- vim.opt.foldnestmax = 2
-- vim.opt.foldlevelstart = 1
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- vim.opt.foldnestmax = 1
vim.o.scrolloff = math.floor(vim.fn.winheight(0) / 2)
vim.o.cursorcolumn = false
vim.opt.ls = 2
vim.opt.statusline = "%F"

vim.opt.hidden = true

vim.g.nrrw_rgn_vert = 1 -- default is 0
vim.g.nrrw_rgn_wdth = math.floor(vim.fn.winwidth(0) / 2) -- default is 30
-- vim.diagnostic.config({ virtual_text = false })

vim.g.cmp_enabled = true

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

vim.filetype.add({
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

function SwitchCS(ind)
  vim.notify(vim.g.CSLists[ind])
  vim.cmd("colorscheme " .. vim.g.CSLists[ind])
end

-- currently blink cmp does not allow to toggle autocompletion
function ToggleAutoComplete()
  if vim.g.cmp_enabled then
    require("blink.cmp").setup({ enabled = false })
    vim.notify("AutoComplete is disabled")
    vim.g.cmp_enabled = false
  else
    require("blink.cmp").setup({ enabled = true })
    vim.notify("AutoComplete is enabled")
    vim.g.cmp_enabled = true
  end
end
