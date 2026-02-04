return {
  { -- for japanese input by skk
    "vim-skk/skkeleton",
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
    end,
    keys = {
      {
        "<C-j>",
        "<Plug>(skkeleton-toggle)",
        desc = "launch skk",
        mode = { "i", "c" },
      },
    },
  },
}
