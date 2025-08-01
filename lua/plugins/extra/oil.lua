return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    opts = {
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      viewoptions = {
        sort = {
          { "type", "asc" },
          { "name", "desc" },
        },
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<BS>"] = { "actions.parent", mode = "n" },
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
