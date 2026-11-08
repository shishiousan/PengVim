local function augroup(name)
  return vim.api.nvim_create_augroup("PengVim_" .. name, { clear = true })
end

-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = augroup("youareanidiot"),
--   callback = function()
--     require("you-are-an-idiot").run()
--   end,
-- })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(args)
    local mark = vim.fn.line([['"]])
    local valid_line = mark >= 1 and mark <= vim.fn.line("$")
    local not_commit = vim.bo[args.buf].filetype ~= "gitcommit"

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  callback = function(ctx)
    pcall(vim.treesitter.start)
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
  pattern = { "bib", "tex" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("explorer_scrolloff"),
  pattern = { "snacks_picker_list" },
  desc = "No centered scrolling in the explorer list",
  callback = function()
    vim.opt_local.scrolloff = 0
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

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("set_errorformat"),
  pattern = { "fortran" },
  callback = function()
    vim.cmd(
      [[ setlocal efm=%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\ %m,%Z%tarning:\ %m,%Z%tote:\ %m,%C%.%#,%-G%.%# ]]
      -- set errorformat=%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\\ %m,%Z%tarning:\\ %m,%Z%tote:\\ %m,%C%.%#,%-G%.%#
    )
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_fortitude_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "fortitude" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Fortitude",
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

-- Window decorations: laststatus=0 and a line-drawing statusline are set in
-- options.lua; the highlights are re-applied whenever the colorscheme changes.
-- (WinSeparator links to VertSplit by default, so VertSplit colors both.)
local function set_decoration_highlights()
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#b020ea", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#c6c6c6", bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { link = "VertSplit" })
end
set_decoration_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("decoration_highlights"),
  callback = set_decoration_highlights,
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("pengvim-lsp-attach"),
  callback = function(event)
    vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "LSP: go to signature [h]elp" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "LSP: code [a]ction" })
    vim.keymap.set("v", "<leader>Lf", vim.lsp.buf.format, { buffer = event.buf, desc = "Lsp [f]ormat" })
    -- reference highlighting is done by vim-illuminate (coding/vim-illuminate.lua)
  end,
})

if vim.env.TMUX then
  local group = vim.api.nvim_create_augroup("tmux_something", { clear = true })
  vim.api.nvim_create_autocmd({ "VimResume", "VimEnter" }, {
    group = group,
    callback = function()
      vim.fn.system({ "tmux", "set", "status", "off" })
    end,
  })
  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    group = group,
    callback = function()
      vim.fn.system({ "tmux", "set", "status", "on" })
    end,
  })
end
