return {
  {
    "vim-skk/skkeleton",
    event = "InsertEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc.vim",
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
