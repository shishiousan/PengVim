return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = {
      viewoptions = {
        sort = {
          { "type", "asc" },
          { "name", "desc" },
        },
      },
    },
    keys = {
      {
        "<leader>O",
        ":Oil<CR>",
        desc = "Open Oil",
      },
    },
  },
}
