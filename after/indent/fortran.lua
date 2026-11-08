-- Use smartindent instead of indent/fortran.vim's indentexpr.
-- (after/indent runs after indent/fortran.vim, so these settings stick.)
vim.opt_local.cindent = false
vim.opt_local.autoindent = false
vim.opt_local.indentexpr = ""
vim.opt_local.smartindent = true
