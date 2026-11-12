-- Language servers: the same set as PengVim minus harper_ls (it starts a
-- grammar checker for every markdown/code buffer). Defaults come from
-- nvim-lspconfig's lsp/*.lua; only overrides are listed here.
-- vim.lsp.enable() just registers FileType autocmds, so nothing starts until
-- a matching file is opened.
local servers = {
  bashls = { filetypes = { "sh", "bash" } },
  fortls = { cmd = require("args.fortran").lsp_cmd }, -- shared with PengVim (lua/args symlink)
  fortitude = {
    cmd = { "fortitude", "server" },
    filetypes = { "fortran" },
    on_attach = function(client) -- hover comes from fortls
      client.server_capabilities.hoverProvider = false
    end,
    init_options = {
      settings = {
        check = { ignore = { "C002", "C003", "MOD021", "S241", "S102" } },
      },
    },
  },
  gopls = {},
  jetls = {
    cmd = { "jetls", "serve" },
    filetypes = { "julia" },
    root_markers = { "Project.toml" },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME }, -- the vim.* API (PengVim uses lazydev for this)
        },
        completion = { callSnippet = "Replace" },
        diagnostics = {
          globals = { "vim" },
          disable = { "missing-fields", "trailing-space" },
        },
      },
    },
  },
  marksman = {
    filetypes = { "markdown", "quarto" },
    root_markers = { ".marksman.toml", "_quarto.yml", ".git" },
  },
  texlab = {
    settings = {
      completion = { matcher = "prefix-ignore-case" },
      inlayHints = { labelReferences = false, labelDefinitions = false },
      texlab = { diagnostics = { ignoredPatterns = { "Unused label" } } },
    },
  },
  tinymist = {},
  tombi = {},
  vimls = {},
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(servers))

-- nvim-lspconfig skips its :Lsp* commands on Nvim 0.12+ (the built-in :lsp
-- replaces them), so define the familiar names as aliases.
local function alias(name, sub, desc)
  vim.api.nvim_create_user_command(name, function(o)
    vim.cmd("lsp " .. sub .. (o.args ~= "" and " " .. o.args or ""))
  end, {
    nargs = "*",
    desc = desc,
    complete = function(arg)
      return vim.fn.getcompletion("lsp " .. sub .. " " .. arg, "cmdline")
    end,
  })
end
alias("LspStart", "enable", "Enable LSP configs (:lsp enable)")
alias("LspStop", "stop", "Stop LSP clients (:lsp stop)")
alias("LspRestart", "restart", "Restart LSP clients (:lsp restart)")
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "LSP status (:checkhealth vim.lsp)" })
vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.tabnew(vim.lsp.log.get_filename())
end, { desc = "Open the LSP log" })
