-- Highlight tweaks for nightfly. :colorscheme clears highlights, so re-apply
-- them on every ColorScheme event (e.g. after :NextColorScheme) instead of once.
local bermuda = "#6e8da6"

local function apply()
  vim.api.nvim_set_hl(0, "@namespace", { link = "NightflyWhite" })
  vim.api.nvim_set_hl(0, "@keyword.operator", { link = "NightflyWaterMelon" })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = bermuda })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("PengVim_custom_colorscheme", { clear = true }),
  pattern = "nightfly",
  callback = apply,
})

if vim.g.colors_name == "nightfly" then
  apply()
end
