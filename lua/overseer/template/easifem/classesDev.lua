return {
  name = "classes",
  builder = function(params)
    return {
      cmd = { "easifem" },
      args = { "dev", "classes", "-q" },
      name = "devClasses",
      cwd = vim.fn.expand("%:h"), -- "/tmp",
      env = {},
      components = {
        "default",
        {
          "run_after",
          task_names = {
            {
              cmd = "easifem",
              args = { "install", "classes", "-q", "--no-download" },
              name = "classesInstall",
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
  desc = "[Dev tool for libeasifemClasses] build/install easifem's classes lib in debug mode",
  params = {},
  priority = 50,
  condition = {
    filetype = { "fortran" },
  },
}
