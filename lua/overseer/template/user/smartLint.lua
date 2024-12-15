return {
  name = "smartLint",
  builder = function(params)
    local file = vim.fn.expand("%:p")
    return {
      -- strategy = {
      --   "toggleterm",
      --   use_shell = false,
      --   open_on_start = false,
      --   hidden = true,
      -- },
      cmd = { "smartELint" },
      args = { file },
      name = "smartLint",
      cwd = vim.fn.expand("%:h"), -- "/tmp",
      env = {},
      components = {
        "default",
        { "on_complete_notify", statuses = { "FAILURE", "SUCCESS" }, on_change = true },
        { "on_complete_dispose", statuses = { "SUCCESS", "FAILURE", "CANCELED" }, timeout = 30 },
        { "on_output_quickfix", open = true, set_diagnostics = true },
        { "restart_on_save" },
        { "on_result_diagnostics", virtual_text = true },
        { "on_exit_set_status", success_codes = { 0 } },
        { "on_output_parse", problem_matcher = "$gcc" },
      },
      condition = {
        filetype = { "fortran" },
      },
    }
  end,
  desc = "Linter for easifem",
  params = {},
  priority = 50,
  condition = {
    filetype = { "fortran" },
    callback = function()
      return true
    end,
  },
}
