return {
  -- Required fields
  name = "baseInstall",
  builder = function(params)
    return {
      cmd = { "easifem" },
      args = { "install", "base", "-q", "--no-download" },
      name = "installBase",
      cwd = vim.fn.expand("%:h"), -- "/tmp",
      env = {},
      components = {
        "default",
        { "on_complete_notify", statuses = { "FAILURE", "SUCCESS" }, on_change = true },
        { "on_complete_dispose", statuses = { "SUCCESS", "FAILURE", "CANCELED" }, timeout = 30 },
        { "on_output_quickfix", open = false, set_diagnostics = true },
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
  desc = "Install easifemBase",
  params = {},
  priority = 50,
  condition = {
    filetype = { "fortran" },
    callback = function(search)
      -- print(vim.inspect(search))
      return true
    end,
  },
}
