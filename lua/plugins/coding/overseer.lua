return {
  {
    "stevearc/overseer.nvim",
    lazy = true,
    config = function()
      require("overseer").setup({
        templates = { "easifem" },
        component_aliases = {
          default = {
            "on_output_summarize",
            "on_exit_set_status",
            { "on_complete_notify", statuses = { "FAILURE", "SUCCESS" }, on_change = true },
            { "on_complete_dispose", statuses = { "SUCCESS", "FAILURE" } },
            {
              "on_result_diagnostics",
              virtual_text = true,
              remove_on_restart = true,
              signs = true,
              underline = true,
            },
            { "on_result_diagnostics_quickfix", open = false },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>or",
        "<cmd>OverseerRun<CR>",
        mode = { "n" },
        desc = "Overseer [r]un",
      },
      {
        "<leader>ot",
        "<cmd>OverseerToggle<CR>",
        mode = { "n" },
        desc = "Overseer [t]oggle",
      },
      {
        "<leader>oi",
        "<cmd>OverseerInfo<CR>",
        mode = { "n" },
        desc = "Overseer [i]nfo",
      },
    },
  },
}
