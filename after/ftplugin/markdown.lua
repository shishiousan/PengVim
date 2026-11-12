-- list-aware comments/formatoptions
vim.opt_local.comments = { "b:*", "b:-", "b:+", "b:1.", "nb:>" }
vim.opt_local.formatoptions:remove("c")
vim.opt_local.formatoptions:append("jr")

vim.opt_local.spell = true
vim.opt_local.spelllang:append({ "en_us", "cjk" })
