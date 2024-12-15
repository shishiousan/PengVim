return {
  -- Required fields
  name = "classesDev",
  builder = function(params)
    return {
      cmd = { "easifem" },
      -- args = { "dev", "classes", "-q", "--env", "dev" },
      args = { "dev", "classes", "-q" },
      name = "devClasses",
      cwd = vim.fn.expand("%:h"), -- "/tmp",
      env = {},
      components = {
        "default",
        { "on_complete_notify", statuses = { "FAILURE" }, on_change = true },
        { "on_complete_dispose", statuses = { "SUCCESS", "FAILURE", "CANCELED" }, timeout = 30 },
        { "on_output_quickfix", open = false, set_diagnostics = true },
        { "on_result_diagnostics", virtual_text = true },
        { "on_exit_set_status", success_codes = { 0 } },
        { "on_output_parse", problem_matcher = "$gcc" },
      },
      condition = {
        filetype = { "fortran" },
      },
    }
  end,
  desc = "Development of easifemClasses, it only prints error messages",
  params = {},
  priority = 50,
  condition = {
    filetype = { "fortran" },
  },
}
