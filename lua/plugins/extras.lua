return {}
return {
  { -- for japanese input by skk
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
  { -- better csv view
    "hat0uma/csvview.nvim",
    ft = "csv",
    config = function()
      require("csvview").setup({
        view = {
          min_column_width = 5,
          spacing = 2,
          display_mode = "border",
        },
      })
    end,
  },
  { -- Penguins go crazy
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>ph",
        function()
          require("duck").hatch("🐧")
        end,
        desc = "Penguins hatch",
      },
      {
        "<leader>pb",
        function()
          require("duck").cook()
        end,
        desc = "Penguins bye bye",
      },
      {
        "<leader>pa",
        function()
          require("duck").cook_all()
        end,
        desc = "All Penguins bye bye",
      },
    },
  },
}
