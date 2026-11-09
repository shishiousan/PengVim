# PengVim-lite

A fast companion config to PengVim: treesitter, LSP, a picker, completion, formatting and git signs, with 7 plugins on Neovim 0.12's built-in `vim.pack`. PengVim remains the full setup (vimtex, Quarto/slime, overseer, claudecode, …).

## Run

```sh
NVIM_APPNAME=pengvim-lite nvim     # fish: nvl
```

`~/.config/pengvim-lite` is a symlink to this folder. Because of `NVIM_APPNAME`, lite has its own plugins (`~/.local/share/pengvim-lite/site/pack/core/opt`), parsers, undo history, shada and cache, separate from PengVim.

## Plugins

| Plugin | Used for | Set up |
|---|---|---|
| vim-nightfly-colors | colorscheme | startup |
| mini.nvim | pick + extra (picker), icons, diff (git signs), clue (key hints), ai, surround | on first file read / UIEnter / first picker key |
| nvim-treesitter (main) | parser install | install runs after UIEnter |
| nvim-treesitter-textobjects (main) | PengVim's `af`/`]f`/`-f` … maps | on first file read |
| nvim-lspconfig | server defaults (`lsp/*.lua`) | — |
| blink.cmp (v1) | completion, PengVim's `snippets/` | on first InsertEnter |
| conform.nvim | `<C-s>` / `gq` formatting | on first format |

Everything else is built in: LSP keys (`grn` `gra` `grr` `gri` `grt` `gO` `K`), commenting (`gc`), `]d`/`[d`, `]q`/`[q`, treesitter highlighting and folding, and the default statusline.

## Shared with PengVim

- `snippets/`, `queries/` and `lua/args/` are symlinks to PengVim's folders.
- Language servers and formatters come from PengVim's Mason directory (`~/.local/share/nvim/mason/bin` is added to `$PATH`); lite has no Mason.

## Maintenance

- **Update plugins:** `:lua vim.pack.update()`, review, then `:write` to apply. Commit `nvim-pack-lock.json`.
- **Add a plugin:** add it to `vim.pack.add()` in `lua/lite/plugins.lua` and restart.
- **Remove a plugin:** delete it from the list, then `:lua vim.pack.del({ "name" })`.
- **Update parsers:** `:TSUpdate`.
