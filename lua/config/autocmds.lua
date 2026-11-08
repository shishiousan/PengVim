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
  group = augroup("treesitter_start"),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "qf", "help", "checkhealth" },
  desc = "q to close quickfix and so on",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
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
  group = augroup("terminal_settings"),
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
