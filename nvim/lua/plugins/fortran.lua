---@diagnostic disable: missing-fields
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        fortls = function(_, opts)
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.cmd = {
            "fortls",
            "--lowercase_intrinsics",
            "--source_dirs",
            -- os.getenv("EASIFEM_SOURCE_DIR") .. "/easifem/base/src/**",
            os.getenv("DROPBOX") .. "/easifem/base/src/**",
            os.getenv("DROPBOX") .. "/easifem/classes/src/**",
            os.getenv("DROPBOX") .. "/easifem/elasticity/src/**",
            os.getenv("DROPBOX") .. "/easifem/acoustic/src/**",
            os.getenv("HOME") .. "/.easifem/src/tomlf/src/**",
            "--hover_signature",
            "--hover_language=fortran",
            "--use_signature_help",
            -- "--debug_log",
          }
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      vim.notify("Loading fortran linting", 3, { title = "LazyVim" })
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
          -- os.getenv("HOME") .. "/.easifem/install/arpack/include/arpack/",
          os.getenv("HOME") .. "/.easifem/install/base/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/classes/include/",
          -- os.getenv("HOME") .. "/.easifem/install/fftw/include/",
          -- os.getenv("HOME") .. "/.easifem/install/gmsh/include/",
          -- os.getenv("HOME") .. "/.easifem/install/lapack95/include/",
          -- os.getenv("HOME") .. "/.easifem/install/lis/include/",
          -- os.getenv("HOME") .. "/.easifem/install/sparsekit/include/",
          -- os.getenv("HOME") .. "/.easifem/install/superlu/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/kernels/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/tomlf/include/toml-f/modules/",
          "-J",
          os.getenv("HOME") .. "/.easifem/lint/include/",
          "-DDEBUG_VER",
        }, -- args to pass to the linter
        ignore_exitcode = true, -- set this to true if you don't want to show error messages
        stream = "both", -- set this to "stdout" if the output is not an error, for example with luac
        parser = require("lint.parser").from_errorformat(errorformat),
      }
      lint.linters_by_ft = { fortran = { "gfortran" } }
    end,
  },
}
