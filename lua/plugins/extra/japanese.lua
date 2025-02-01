return {
  { -- for japanese input by skk
    "vim-skk/skkeleton",
    event = "InsertEnter",
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function()
      vim.cmd([[ call skkeleton#config({
        \ 'globalDictionaries': ['~/.skkdict/SKK-JISYO.L'],
        \ 'eggLikeNewline': v:true,
        \ })]])
      vim.cmd([[ call skkeleton#register_kanatable('rom', {
          \   ',': ['，', ''],
          \   '.': ['．', ''],
          \ })]])
      vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-toggle)]], { noremap = false })
    end,
  },
}
