-- list-aware comments/formatoptions (same as markdown)
vim.opt_local.comments = { "b:*", "b:-", "b:+", "b:1.", "nb:>" }
vim.opt_local.formatoptions:remove("c")
vim.opt_local.formatoptions:append("jr")
