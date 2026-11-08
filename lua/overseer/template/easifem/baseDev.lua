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
    }
  end,
  desc = "[Dev tool for libeasifemBase] build/install easifem's base lib in debug mode",
  params = {},
  condition = {
    filetype = { "fortran" },
  },
}
