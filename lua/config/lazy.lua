local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.ui.alpha" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.tex" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.lsp.none-ls" },
    { import = "lazyvim.plugins.extras.util.project" },
    -- { import = "lazyvim.plugins.extras.lang.cmake" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
    keymaps = false,
  },
  news = {
    lazyvim = false,
    neovim = false,
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  -- NOTE: Check update for packages regularly
  -- checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = false, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = true, -- check for pinned packages that can't be updated
  },
})

-- NOTE: These highlight related config should be declared after loading of colorscheme
--
-- to make comment non italic
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#565f89", bg = "NONE", italic = false })
-- vim.api.nvim_set_hl(0, "VertSplit", { fg = "#82e2ff", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "IncSearch", { bg = "#82e2ff", fg = "#000000" })
-- vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#61ffca", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffca85", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "DiffChange", { fg = "#82e2ff", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#ff6767", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "@attribute", { link = "Attribute" })
-- vim.api.nvim_set_hl(0, "Delimiter", { link = "Special" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "FloatBorder" })
-- vim.api.nvim_set_hl(0, "MiniFilesBorder", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "TelescopeNormal" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "FloatBorder" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "TelescopeNormal" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "TelescopeNormal" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "Special" })
-- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "Special" })
-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "Special" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { link = "Special" })
-- vim.api.nvim_set_hl(0, "@property.fortran", { link = "Property" })
-- vim.api.nvim_set_hl(0, "@keyword.operator.fortran", { link = "Property" })
-- vim.api.nvim_set_hl(0, "@variable.lua", { link = "Attribute" })
-- vim.api.nvim_set_hl(0, "Visual", { fg = "#ffffff", bg = "#505050" })
-- vim.api.nvim_set_hl(0, "Conceal", { fg = "#505050", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "MatchParen", { fg = "#ffffff", bg = "#a277ff" })

-- vim.api.nvim_set_hl(0, "tomlComment", { link = "Comment" })
-- vim.api.nvim_set_hl(0, "tomlTodo", { link = "Todo" })
-- vim.api.nvim_set_hl(0, "tomlBoolean", { link = "Boolean" })
-- vim.api.nvim_set_hl(0, "tomlNumber", { link = "Number" })
-- vim.api.nvim_set_hl(0, "tomlString", { link = "String" })
-- vim.api.nvim_set_hl(0, "tomlKey", { link = "Identifier" })
-- vim.api.nvim_set_hl(0, "tomlTable", { link = "Title" })
-- vim.api.nvim_set_hl(0, "tomlDate", { link = "Constant" })
-- vim.api.nvim_set_hl(0, "tomlTableArray", { link = "Title" })
-- vim.api.nvim_set_hl(0, "tomlFloat", { link = "Float" })
-- vim.api.nvim_set_hl(0, "tomlInteger", { link = "Number" })
-- vim.api.nvim_set_hl(0, "tomlKeySq", { link = "Identifier" })
-- vim.api.nvim_set_hl(0, "tomlKeyDq", { link = "Identifier" })
-- vim.api.nvim_set_hl(0, "tomlDotInKey", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "tomlLineEscape", { link = "SpecialChar" })
-- vim.api.nvim_set_hl(0, "tomlEscape", { link = "SpecialChar" })

-- vim.cmd([[highlight DiffAdd gui=reverse guifg=#61ffca ]])

-- vim.opt.termguicolors = true
-- vim.opt.winblend = 0
-- vim.opt.pumblend = 0
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#C678DD gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#56B6C2 gui=nocombine]])

-- vim.cmd([[highlight MiniIndentscopeSymbol guifg=#c308ff gui=nocombine]])
-- vim.cmd([[highlight Headline1 guibg=#1e2718]])
-- vim.cmd([[highlight Headline2 guibg=#21262d]])
-- vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
-- vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])

-- vim.cmd([[let g:fzf_colors =
-- \ { 'fg':         ['fg', 'Normal'],
--   \ 'bg':         ['bg', 'Normal'],
--   \ 'preview-bg': ['bg', 'NormalFloat'],
--   \ 'hl':         ['fg', 'Comment'],
--   \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
--   \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
--   \ 'hl+':        ['fg', 'Statement'],
--   \ 'info':       ['fg', 'PreProc'],
--   \ 'border':     ['fg', 'Ignore'],
--   \ 'prompt':     ['fg', 'Conditional'],
--   \ 'pointer':    ['fg', 'Exception'],
--   \ 'marker':     ['fg', 'Keyword'],
--   \ 'spinner':    ['fg', 'Label'],
--   \ 'header':     ['fg', 'Comment'] }]])
