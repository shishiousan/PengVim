return {
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      local lint = require("lint")
      local errorformat =
        "%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\\ %m,,%Z%tarning:\\ %m,%C%.%#,%-G%.%#"
      lint.linters.gfortran = {
        name = "gfortran",
        cmd = "gfortran",
        args = {
          "-c",
          "-fsyntax-only",
          "-cpp",
          -- "-fdiagnostics-plain-output",
          "-Wunused-variable",
          "-Wunused-dummy-argument",
          "-Wall",
          "-I",
          os.getenv("HOME") .. "/.easifem/easifem/lint/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/base/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/classes/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/kernels/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/tomlf/include/toml-f/modules/",
          "-J",
          os.getenv("HOME") .. "/.easifem/lint/include/",
          "-DDEBUG_VER",
        },
        ignore_exitcode = true, -- set this to true if you don't want to show error messages
        stream = "both", -- set this to "stdout" if the output is not an error, for example with luac
        parser = require("lint.parser").from_errorformat(errorformat),
      }
      local mdlint = lint.linters["markdownlint-cli2"]
      mdlint.args = { "--config", os.getenv("HOME") .. "/.markdownlint-cli2.yaml" }
      lint.linters_by_ft = {
        fortran = { "gfortran" },
        markdown = { "markdownlint-cli2" },
        fish = { "fish" },
      }
    end,
  },
}
