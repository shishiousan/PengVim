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
