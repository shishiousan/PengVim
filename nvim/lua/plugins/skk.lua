return {
  { "vim-denops/denops.vim" },
  {
    "vim-skk/skkeleton",
    dependencies = { "vim-denops/denops.vim", "Shougo/ddc.vim" },
    config = function()
      vim.cmd([[ call skkeleton#config({
        \ 'globalDictionaries': ['~/.skkdict/SKK-JISYO.L'],
        \ 'eggLikeNewline': v:true,
        \ })]])
      vim.cmd([[ call skkeleton#register_kanatable('rom', {
          \   ',': ['，', ''],
          \   '.': ['．', ''],
          \ })]])
      -- vim.cmd([[ call ddc#custom#patch_global( 'sources', ['skkeleton'])]])
      -- vim.cmd([[ call ddc#custom#patch_global( 'sourceOptions', {
      -- \ '_': {
      -- \ 'matchers': ['matcher_head'],
      -- \ 'sorters': ['sorter_rank'],
      -- \ },
      -- \ 'skkeleton' : {
      -- \ 'mark': 'skkeleton',
      -- \ 'matchers': [],
      -- \ 'sorters': [],
      -- \ 'converters': [],
      -- \ 'isVolatile': v:true,
      -- \ 'minAutoCompleteLength': 1
      -- \ }})]])
      -- vim.cmd([[call ddc#enable()]])
      -- vim.cmd([[ call ddc#custom#patch_global('ui', 'pum')]])
      vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-toggle)]], { noremap = false })
    end,
  },
}
