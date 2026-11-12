local function augroup(name)
  return vim.api.nvim_create_augroup("lite_" .. name, { clear = true })
end

-- treesitter highlighting for every filetype that has a parser
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("treesitter"),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(args)
    local mark = vim.fn.line([['"]])
    if mark >= 1 and mark <= vim.fn.line("$") and vim.bo[args.buf].filetype ~= "gitcommit" then
      vim.cmd([[normal! g`"]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "qf", "help", "checkhealth" },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = args.buf })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("vertical_help"),
  pattern = "help",
  command = "wincmd L",
})
