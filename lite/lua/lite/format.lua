-- conform.nvim, set up on the first format call (keeps it out of startup).
-- Formatters are the same as PengVim's lua/plugins/coding/conform.lua.
local M = {}

local function setup()
  if M.ready then
    return
  end
  M.ready = true
  require("conform").setup({
    default_format_opts = {
      timeout_ms = 5000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      toml = { "taplo" },
      typst = { "typstyle" },
      fortran = { "fprettier", "forformat", "fprettify", stop_after_first = true },
      go = { "goimports" },
      tex = { "latexindent" },
      markdown = { "rumdl", "injected" },
      cmake = { "gersemi" },
      json = { "jq", "dprint", stop_after_first = true },
      julia = { lsp_format = "fallback" },
      quarto = { "rumdl", "injected" },
    },
    formatters = {
      injected = {
        options = {
          ignore_errors = false,
          lang_to_ext = {
            bash = "sh",
            julia = "jl",
            latex = "tex",
            markdown = "md",
            python = "py",
            rust = "rs",
            lua = "lua",
          },
        },
      },
      fprettier = {
        stdin = true,
        command = "fprettier",
        args = { "--config", vim.fn.expand("~/.config/fprettier/fprettier.toml") },
      },
      forformat = {
        stdin = true,
        command = "forformat",
        args = { "--config", vim.fn.expand("~/.config/forformat/forformat.toml") },
      },
      fprettify = {
        stdin = true,
        args = require("args.fortran").formatter or {}, -- shared with PengVim via lua/args symlink
      },
      taplo = {
        args = { "format", "--option", "array_auto_collapse=false", "-" },
      },
      typstyle = { command = "typstyle", stdin = true },
      latexindent = { command = "latexindent", stdin = true, args = { "-" } },
      stylua = {
        command = "stylua",
        args = { "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" },
      },
    },
  })
end

---@param opts? conform.FormatOpts
function M.format(opts)
  setup()
  return require("conform").format(opts or {})
end

-- used by 'formatexpr' (gq)
function M.formatexpr()
  setup()
  return require("conform").formatexpr()
end

-- vim.g.autoformat is the global toggle; vim.b.autoformat = false opts a buffer out
function M.enabled(buf)
  buf = buf or 0
  return vim.g.autoformat and vim.b[buf].autoformat ~= false
end

return M
