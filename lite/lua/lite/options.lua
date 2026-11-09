local opt = vim.opt

vim.g.autoformat = true -- <C-s> formats before saving; toggle with <leader>uf
vim.g.markdown_recommended_style = 0

-- Language servers and formatters come from PengVim's Mason install (lite has no Mason).
local mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin")
if vim.uv.fs_stat(mason_bin) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

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

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
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
  horiz = "⎯",
}
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "" -- show the first line of a fold with its highlighting
opt.formatexpr = "v:lua.require'lite.format'.formatexpr()"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.jumpoptions = "view"
opt.laststatus = 3 -- one global statusline; the 0.12 default shows file, LSP progress, diagnostics
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 999 -- keep the cursor centered
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.winborder = "rounded"
opt.winminwidth = 5
opt.wrap = false
opt.wrapscan = false

vim.diagnostic.config({
  virtual_text = { current_line = true }, -- message for the cursor line only
  severity_sort = true,
  jump = { -- open the float after ]d / ]e / ]w (as in PengVim)
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})
