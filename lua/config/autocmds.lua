local function augroup(name)
  return vim.api.nvim_create_augroup("PengVim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "commit"

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  callback = function(ctx)
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "checkhealth" },
  desc = "q to close quickfix and so on",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_autoformat"),
  pattern = { "latex", "bib", "tex" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("reset_scrolloff"),
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "snacks_picker_list" then
      return
    else
      vim.opt.scrolloff = math.floor(vim.fn.winheight(0) / 2)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("vert help"),
  pattern = { "help" },
  callback = function()
    vim.cmd("wincmd L")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("add_cjk_spelling"),
  pattern = { "typst", "markdown", "text" },
  callback = function()
    vim.cmd([[ setlocal spell spelllang+=en_us,cjk ]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("set_formatoptions"),
  pattern = { "quarto", "markdown" },
  callback = function()
    vim.cmd([[setlocal comments=b:*,b:-,b:+,b:1.,nb:>]])
    vim.cmd([[setlocal formatoptions-=c formatoptions+=jr]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("set_indent_opts"),
  pattern = { "fortran" },
  callback = function()
    vim.cmd([[setlocal noci noai]])
    vim.cmd([[setlocal indentexpr=]])
    vim.cmd([[setlocal si]])
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("set_errorformat"),
  pattern = { "fortran" },
  callback = function()
    vim.cmd(
      [[ set efm=%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\ %m,%Z%tarning:\ %m,%Z%tote:\ %m,%C%.%#,%-G%.%# ]]
      -- set errorformat=%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\\ %m,%Z%tarning:\\ %m,%Z%tote:\\ %m,%C%.%#,%-G%.%#
    )
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_fortitude_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "fortitude" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Fortitude",
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("disable_virtual_text"),
  pattern = { "*" },
  callback = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("hide_decorations"),
  pattern = { "*" },
  callback = function()
    vim.cmd("set laststatus=0")
    vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
    vim.api.nvim_set_hl(0, "VertSplit", { fg = "#b020ea", bg = "NONE" })
    -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#b020ea", bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#c6c6c6", bg = "NONE" })
    vim.cmd("hi! link StatusLine Normal")
    vim.cmd("hi! link StatusLineNC VertSplit")
  end,
})

local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function(_)
    vim.cmd.setlocal("nonumber")
    vim.cmd.setlocal("norelativenumber")
    vim.wo.signcolumn = "no"
    set_terminal_keymaps()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("pengvim-lsp-attach"),
  callback = function(event)
    vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "LSP: go to signature [h]elp" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "LSP: code [a]ction" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "LSP: Hover Documentation" })
    vim.keymap.set("v", "<leader>Lf", vim.lsp.buf.format, { buffer = event.buf, desc = "Lsp [f]ormat" })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    assert(client, "LSP client not found")

    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("pengvim-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("pengvim-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "pengvim-lsp-highlight", buffer = event2.buf })
        end,
      })
    end
  end,
})

if vim.env.TMUX then
  local group = vim.api.nvim_create_augroup("tmux_something", { clear = true })
  vim.api.nvim_create_autocmd({ "VimResume", "VimEnter" }, {
    group = group,
    callback = function()
      vim.fn.system({ "tmux", "set", "status", "off" })
    end,
  })
  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    group = group,
    callback = function()
      vim.fn.system({ "tmux", "set", "status", "on" })
    end,
  })
end
