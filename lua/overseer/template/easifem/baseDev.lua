return {
  name = "base",
  builder = function()
    return {
      cmd = { "easifem" },
      args = { "dev", "base", "-q" },
      name = "baseDev",
      cwd = vim.fn.expand("%:h"), -- "/tmp",
      env = {},
      components = {
        "default",
        {
          "run_after",
          task_names = {
            {
              cmd = "easifem",
              args = { "install", "base", "-q", "--no-download" },
              name = "baseInstall",
            },
          },
          detach = false,
          statuses = { "SUCCESS" },
        },
      },
      condition = {
        filetype = { "fortran" },
      },
    }
  end,
  desc = "[Dev tool for libeasifemBase] build/install easifem's base lib in debug mode",
  params = {},
  priority = 50,
  condition = {
    filetype = { "fortran" },
    callback = function(search)
      return true
    end,
  },
}
