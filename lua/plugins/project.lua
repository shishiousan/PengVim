return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
    config = function(opts)
      require("project_nvim").setup(opts)
    end,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
  },
}
