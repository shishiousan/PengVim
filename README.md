# PengVim

My neovim setting files (Neovim 0.12+, [lazy.nvim](https://github.com/folke/lazy.nvim)).

## Layout

| Path | What lives there |
|---|---|
| `init.lua` | load order: `config.options` → `lazy.setup()` → keymaps, autocmds, quickfix |
| `lua/config/` | editor options, global keymaps, cross-filetype autocmds, quickfix formatter, colorscheme tweaks |
| `lua/plugins/{editor,coding,ui}/` | one plugin spec per file |
| `lua/plugins/lang/` | one file per language: LSP server (`opts.servers`), formatter tools (`opts.extra`), treesitter parsers (`opts.ensure_installed`) |
| `lua/plugins/lang/lsp.lua` | enables every server collected from `lang/*.lua`; Mason installs only tools missing from `PATH` |
| `lua/plugins/args/` | machine-specific command arguments (fortls, fprettify) |
| `lua/plugins/playground/` | gitignored scratch specs (imported only if present) |
| `after/ftplugin/`, `after/indent/` | buffer-local settings per filetype |
| `lua/overseer/template/` | overseer task templates (auto-discovered) |
| `queries/`, `snippets/` | custom treesitter queries and VS Code-style snippets |
