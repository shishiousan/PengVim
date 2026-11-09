-- Plugins via Neovim's built-in vim.pack (lockfile: lite/nvim-pack-lock.json).
-- Inside init.lua, vim.pack.add() only puts plugins on the runtimepath
-- (like :packadd!). The cost is in setup(), so each one is deferred below.
local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("bluz71/vim-nightfly-colors"), name = "nightfly" },
  gh("nvim-mini/mini.nvim"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
  gh("neovim/nvim-lspconfig"), -- server defaults only (lsp/*.lua)
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1") }, -- release tag => prebuilt binary
  gh("stevearc/conform.nvim"), -- set up on first use, see lite/format.lua
}, { confirm = false })

local group = vim.api.nvim_create_augroup("lite_deferred", { clear = true })
local function once(events, fn)
  vim.api.nvim_create_autocmd(events, { group = group, once = true, callback = fn })
end

-- Colorscheme: needed for the first frame --------------------------------------
vim.g.nightflyTransparent = true
vim.cmd.colorscheme("nightfly")

-- Treesitter --------------------------------------------------------------------
-- Same parsers as PengVim, minus tmux (no longer supported by nvim-treesitter main).
-- setup() only records install_dir; install() is a no-op for parsers that are
-- already there, so run it after the UI is up.
local parsers = {
  "bash", "bibtex", "c", "css", "csv", "diff", "fish", "fortran", "git_config",
  "gitcommit", "gitignore", "go", "json", "julia", "latex", "lua", "markdown",
  "markdown_inline", "python", "toml", "typst", "vim", "vimdoc", "yaml",
}
require("nvim-treesitter").setup({})
once("UIEnter", function()
  vim.schedule(function()
    require("nvim-treesitter").install(parsers)
  end)
end)
vim.treesitter.language.register("bibtex", "bib")

-- ftplugin maps clash with the textobject maps below (as in PengVim)
vim.g.no_plugin_maps = true

-- Textobjects and moves: identical keys to PengVim's lua/plugins/lang/treesitter.lua
local function setup_textobjects()
  require("nvim-treesitter-textobjects").setup({
    move = { set_jumps = true },
    select = {
      lookahead = true,
      selection_modes = {
        ["@function.inner"] = "V",
        ["@function.outer"] = "V",
        ["@class.outer"] = "V",
        ["@class.inner"] = "V",
        ["@loop.outer"] = "V",
        ["@loop.inner"] = "V",
        ["@conditional.outer"] = "V",
        ["@conditional.inner"] = "V",
        ["@block.outer"] = "V",
        ["@block.inner"] = "V",
      },
      include_surrounding_whitespace = false,
    },
  })

  local move = function(fn, object)
    return function()
      require("nvim-treesitter-textobjects.move")[fn](object, "textobjects")
    end
  end
  local objects = { f = "function", c = "conditional", a = "class", b = "block", l = "loop" }
  for key, name in pairs(objects) do
    local obj = "@" .. name .. ".outer"
    local nxo = { "n", "x", "o" }
    vim.keymap.set(nxo, "-" .. key, move("goto_next_start", obj), { desc = obj })
    vim.keymap.set(nxo, "--" .. key, move("goto_next_end", obj), { desc = obj })
    vim.keymap.set(nxo, "_" .. key, move("goto_previous_start", obj), { desc = obj })
    vim.keymap.set(nxo, "__" .. key, move("goto_previous_end", obj), { desc = obj })
    vim.keymap.set(nxo, "]" .. key:upper(), move("goto_next_end", obj), { desc = obj })
    vim.keymap.set(nxo, "[" .. key:upper(), move("goto_previous_end", obj), { desc = obj })
    if key ~= "c" then
      vim.keymap.set(nxo, "]" .. key, move("goto_next_start", obj), { desc = obj })
      vim.keymap.set(nxo, "[" .. key, move("goto_previous_start", obj), { desc = obj })
    end
  end
  -- ]c / [c: next/prev conditional, but keep the built-in next/prev change in diff mode
  for key, fn in pairs({ ["]c"] = "goto_next_start", ["[c"] = "goto_previous_start" }) do
    local ts_move = move(fn, "@conditional.outer")
    vim.keymap.set({ "n", "x", "o" }, key, function()
      if vim.wo.diff and vim.fn.mode() == "n" then
        vim.cmd.normal({ vim.v.count1 .. key, bang = true })
      else
        ts_move()
      end
    end, { desc = "@conditional.outer (diff: change)" })
  end

  local select = function(object)
    return function()
      require("nvim-treesitter-textobjects.select").select_textobject(object, "textobjects")
    end
  end
  local selects = { f = "function", a = "class", l = "loop", c = "conditional", o = "block" }
  for key, name in pairs(selects) do
    vim.keymap.set({ "x", "o" }, "a" .. key, select("@" .. name .. ".outer"), { desc = "@" .. name .. ".outer" })
    vim.keymap.set({ "x", "o" }, "i" .. key, select("@" .. name .. ".inner"), { desc = "@" .. name .. ".inner" })
  end
end

-- mini.nvim ----------------------------------------------------------------------
-- Editing helpers and git signs: when the first file is read.
once({ "BufReadPost", "BufNewFile" }, function()
  require("mini.ai").setup({ n_lines = 500 })
  require("mini.surround").setup({
    mappings = { -- same as PengVim
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  })
  require("mini.diff").setup()
  setup_textobjects()
end)

-- Icons and key hints: right after the UI appears.
once("UIEnter", function()
  require("mini.icons").setup()
  local clue = require("mini.clue")
  clue.setup({
    triggers = {
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },
      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
      { mode = "n", keys = "<C-w>" },
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },
      { mode = "i", keys = "<C-x>" },
    },
    clues = {
      { mode = "n", keys = "<Leader>f", desc = "+file" },
      { mode = "n", keys = "<Leader>g", desc = "+git" },
      { mode = "n", keys = "<Leader>q", desc = "+quit" },
      { mode = "n", keys = "<Leader>s", desc = "+search" },
      { mode = "n", keys = "<Leader>u", desc = "+ui" },
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
    window = { delay = 300 },
  })
end)

-- Picker: mini.pick + mini.extra, set up on the first picker key (see keymaps.lua).
local M = {}
function M.picker()
  if not _G.MiniPick then
    if not _G.MiniIcons then
      require("mini.icons").setup()
    end
    require("mini.pick").setup()
    require("mini.extra").setup()
    vim.ui.select = MiniPick.ui_select
  end
  return MiniPick, MiniExtra
end

-- Completion: blink.cmp on first insert/cmdline. Its plugin/ file has already
-- registered completion capabilities for every LSP server at startup.
once({ "InsertEnter", "CmdlineEnter" }, function()
  require("blink.cmp").setup({
    keymap = { -- PengVim's: <CR> accepts, <Tab>/<S-Tab> cycle or jump in snippets
      preset = "enter",
      ["<Tab>"] = {
        function(cmp)
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          local before = col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
          if cmp.is_visible() then
            return cmp.select_next()
          elseif cmp.snippet_active() then
            return cmp.snippet_forward()
          elseif before then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_prev()
          elseif cmp.snippet_active() then
            return cmp.snippet_backward()
          end
        end,
        "fallback",
      },
    },
    completion = {
      menu = {
        scrollbar = false,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind", "source_name", gap = 1 },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 100, window = { scrollbar = false } },
      list = {
        max_items = 100,
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          auto_insert = true,
        },
      },
    },
    appearance = { nerd_font_variant = "mono" },
    -- built-in snippet source reads stdpath("config")/snippets (symlink to PengVim's)
    snippets = { preset = "default" },
    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      providers = {
        lsp = { score_offset = 10 },
        snippets = {
          score_offset = 15,
          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character"
          end,
        },
      },
    },
  })
end)

return M
