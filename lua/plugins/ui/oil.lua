return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
      "echasnovski/mini.nvim", -- provides mini.icons
    },
    opts = {
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      view_options = {
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
