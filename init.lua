-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  -- VSCode extension
  return
elseif vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "MonaspiceKr Nerd Font:h13"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_scale_factor = 1.0
end
require("config.lazy")
