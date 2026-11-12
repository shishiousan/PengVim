# PengVim

My Neovim configuration, built around scientific computing and writing:
Fortran (the [EASIFEM](https://github.com/easifem) libraries), Julia, LaTeX,
Typst, Markdown and Quarto.

The repository contains two configs:

| Config | Folder | Plugin manager | For |
|---|---|---|---|
| **PengVim** | repository root | [lazy.nvim](https://github.com/folke/lazy.nvim) | the full setup |
| **PengVim-lite** | [`lite/`](lite/README.md) | Neovim's built-in `vim.pack` | fast startup: 7 plugins, ~11 ms |

Both require **Neovim 0.12 or newer**.

## Install

```sh
git clone https://github.com/shishiousan/PengVim ~/.config/nvim
nvim   # lazy.nvim bootstraps itself and installs every plugin on first start
```

Language servers and formatters are installed by Mason **only if they are not
already on `PATH`**, so system-wide installs always take precedence.

To also use the lite config:

```sh
ln -s ~/.config/nvim/lite ~/.config/pengvim-lite
NVIM_APPNAME=pengvim-lite nvim
```

See [`lite/README.md`](lite/README.md) for what lite includes and how to maintain it.

### External tools

| Tool | Needed for |
|---|---|
| `git`, a C compiler, `tree-sitter` CLI | installing plugins and treesitter parsers |
| `rg`, `fd` | file and text search (Snacks picker) |
| a [Nerd Font](https://www.nerdfonts.com) | icons |
| `lazygit` | `<leader>gg` and the other Lazygit maps (optional) |
| `deno` | skkeleton Japanese input (optional) |
| `fortls`, [`fortitude`](https://fortitude.readthedocs.io) ≥ 0.8 | Fortran LSP and linting. Install fortitude from PyPI (`uv tool install fortitude-lint`); older builds, including the `fortitude` crate on crates.io, have no `server` command, so Fortran diagnostics silently disappear |
| `jetls` | Julia LSP (not a Mason package; install it yourself) |
| a TeX distribution, `latexmk` | vimtex |
| `quarto`, `jupytext` | Quarto / notebooks |

## Language support

| Language | LSP | Formatter | Extras |
|---|---|---|---|
| Fortran | fortls, fortitude | fprettier → forformat → fprettify (first available) | custom treesitter queries, gfortran `errorformat` |
| Julia | jetls | LSP | |
| LaTeX | texlab | latexindent | vimtex |
| Typst | tinymist | typstyle | typst.vim |
| Markdown | marksman, harper_ls | rumdl + injected code blocks | render-markdown, nabla (math), table mode |
| Quarto | marksman, otter (code cells) | rumdl + injected | quarto-nvim, vim-slime, jupytext, img-clip |
| Lua | lua_ls (+ lazydev) | stylua | |
| Go | gopls | goimports | |
| TOML | tombi | taplo | |
| Shell, Vim | bashls, vimls | shfmt | |
| JSON, CMake, Fish | | jq / dprint, gersemi, fish_indent | |
| CSV | | | csvview |

## Using it

`<Space>` is the leader and `\` the local leader. Press `<Space>` and wait to
see every group in which-key.

| Keys | Action |
|---|---|
| `<C-s>` | format (conform) and save; `<leader>uf` toggles format-on-save |
| `<leader><space>`, `<leader>ff`, `<leader>/` | smart find, find files, grep |
| `<leader>,`, `<leader>fr`, `<leader>fp` | buffers, recent files, projects |
| `<leader>e` | file explorer |
| `gd`, `grr`, `gI`, `gy`, `K` | definition, references, implementation, type definition, hover |
| `grn`, `<leader>ca` | rename, code action |
| `]d` / `[d`, `]e` / `[e`, `]w` / `[w` | next/previous diagnostic, error, warning |
| `<leader>cd` | diagnostics of the current line |
| `<leader>xx`, `<leader>xX` | all / buffer diagnostics in Trouble |
| `<leader>gg`, `<leader>gs` | Lazygit, git status |
| `<leader>o…` | overseer tasks (build, run) |
| `<C-j>` | toggle Japanese input (skkeleton) |
| `<leader>Cn` / `<leader>Cp` | cycle colorschemes (nightfly, moonfly) |

In the command line, completion pops up as you type (blink.cmp).

### LSP commands

Neovim 0.12's built-in `:lsp` replaces nvim-lspconfig's commands, so PengVim
defines the familiar names as aliases:

| Command | Does |
|---|---|
| `:LspInfo` | `:checkhealth vim.lsp`: attached servers, their command, root and settings |
| `:LspLog` | open the LSP log (start here when a server does not attach) |
| `:LspRestart`, `:LspStop`, `:LspStart` `[name]` | `:lsp restart`, `:lsp stop`, `:lsp enable` |

## Layout

| Path | What lives there |
|---|---|
| `init.lua` | load order: `config.options` → `lazy.setup()` → keymaps, autocmds, quickfix |
| `lua/config/` | editor options, global keymaps, cross-filetype autocmds, quickfix formatter, colorscheme cycling |
| `lua/plugins/{editor,coding,ui}/` | one plugin spec per file |
| `lua/plugins/lang/` | one file per language: LSP servers (`opts.servers`), formatter tools (`opts.extra`), treesitter parsers (`opts.ensure_installed`) |
| `lua/plugins/lang/lsp.lua` | enables every server collected from `lang/*.lua` with `vim.lsp.config`/`vim.lsp.enable` |
| `lua/plugins/args/` | machine-specific command arguments (fortls source dirs, fprettify) |
| `lua/plugins/playground/` | gitignored scratch specs, imported only if present |
| `after/ftplugin/`, `after/indent/` | buffer-local settings per filetype |
| `lua/overseer/template/` | overseer task templates (auto-discovered) |
| `queries/`, `snippets/` | custom treesitter queries and VS Code-style snippets (shared with lite) |
| `lite/` | PengVim-lite |

### Adding a language

Create `lua/plugins/lang/<language>.lua`. lazy.nvim merges the `opts` of every
file, so a language only declares what it adds:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        my_ls = {}, -- settings passed to vim.lsp.config(); defaults come from nvim-lspconfig
        -- ensure_installed = false  -- for servers Mason cannot install
      },
      extra = {
        my_formatter = { bin = "my-formatter" }, -- Mason package, installed only if `bin` is missing
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "mylang" } },
  },
}
```

Then add the formatter to `formatters_by_ft` in `lua/plugins/coding/conform.lua`.

## Troubleshooting

- **No inline diagnostics:** `:LspInfo` shows whether the server attached, and
  `:LspLog` shows why it did not. For Fortran, check `fortitude --version` (it must be 0.8 or newer).
- **Other problems:** `:checkhealth` lists missing tools and plugin warnings, and `:Lazy` shows plugin load errors.

## License

[Apache 2.0](LICENSE)
