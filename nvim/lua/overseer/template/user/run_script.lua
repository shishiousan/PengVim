-- /home/stevearc/.config/nvim/lua/overseer/template/user/run_script.lua
return {
  name = "runner for linting easifem file",
  builder = function()
    local file = vim.fn.expand("%:p")
    -- local filename = vim.fn.expand("%:t")
    local cmd = { file }
    if vim.bo.filetype == "go" then
      cmd = { "go", "run", file }
    end
    if vim.bo.filetype == "fortran" then
      cmd = { "easifem", "lint", file, "-q" }
    end
    return {
      cmd = cmd,
      components = {
        "default",
        { "on_complete_notify", statuses = { "FAILURE", "SUCCESS" }, on_change = true },
        { "on_complete_dispose", statuses = { "SUCCESS", "FAILURE", "CANCELED" }, timeout = 30 },
        { "on_output_quickfix", open = false, set_diagnostics = true },
        { "restart_on_save" },
        {
          "on_result_diagnostics",
          virtual_text = true,
          remove_on_restart = true,
          signs = true,
          underline = true,
        },
        { "on_exit_set_status", success_codes = { 0 } },
        { "on_output_parse", problem_matcher = "$gcc" },
      },
    }
  end,
  condition = {
    filetype = { "fortran" },
  },
}
