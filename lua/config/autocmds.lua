local function augroup(name)
  return vim.api.nvim_create_augroup("PengVim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "commit"

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "checkhealth" },
  desc = "q to close quickfix and so on",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_autoformat"),
  pattern = { "latex", "bib", "tex" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("expr_folding"),
  pattern = { "fortran", "lua" },
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"
    vim.opt_local.foldnestmax = 1
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("reset_scrolloff"),
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "snacks_picker_list" then
      return
    else
      vim.opt.scrolloff = math.floor(vim.fn.winheight(0) / 2)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("marker_folding"),
  pattern = { "bash" },
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldcolumn = "2"
    vim.opt_local.foldnestmax = 1
    vim.cmd("set foldopen-=block")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_folding"),
  pattern = { "Noice", "dashboard" },
  callback = function()
    vim.opt_local.foldenable = false
    vim.opt_local.foldcolumn = "0"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("vert help"),
  pattern = { "help" },
  callback = function()
    vim.cmd("wincmd L")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("add_cjk_spelling"),
  pattern = { "typst", "markdown", "text" },
  callback = function()
    vim.cmd([[ setlocal spell spelllang+=en_us,cjk ]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("set_formatoptions"),
  pattern = { "quarto", "markdown" },
  callback = function()
    vim.cmd([[setlocal comments=b:*,b:-,b:+,b:1.,nb:>]])
    vim.cmd([[setlocal formatoptions-=c formatoptions+=jr]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("set_indent_opts"),
  pattern = { "fortran" },
  callback = function()
    vim.cmd([[setlocal noci noai]])
    vim.cmd([[setlocal indentexpr=]])
    vim.cmd([[setlocal si]])
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("disable_virtual_text"),
  pattern = { "*" },
  callback = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("hide_decorations"),
  pattern = { "*" },
  callback = function()
    vim.cmd("set laststatus=0")
  end,
})

local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function(_)
    vim.cmd.setlocal("nonumber")
    vim.cmd.setlocal("norelativenumber")
    vim.wo.signcolumn = "no"
    set_terminal_keymaps()
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup("pengvim_mathhovar"),
  pattern = { "*" },
  callback = function()
    local ft = vim.bo.filetype
    if ft == "markdown" or ft == "quarto" then
      require("nabla").popup()
    end
  end,
})
