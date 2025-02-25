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

      lint.linters.gfortran = {
        name = "gfortran",
        cmd = "gfortran",
        args = require("plugins.args.fortran").linter or {},
        ignore_exitcode = true,
        stream = "both",
        parser = require("lint.parser").from_errorformat(
          "%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\\ %m,%Z%tarning:\\ %m,%C%.%#,%-G%.%#",
          {}
        ),
      }
      lint.linters["markdownlint-cli2"] = {
        args = { "--config", os.getenv("HOME") .. "/.markdownlint-cli2.yaml" },
      }
      lint.linters_by_ft = {
        fortran = { "gfortran" },
        markdown = { "markdownlint-cli2" },
        fish = { "fish" },
      }
    end,
  },
}
