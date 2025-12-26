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
      -- pattern explanation:
      -- %A = Start of multi-line message
      -- %C = Continuation line
      -- %Z = End of multi-line message
      -- %-G = Ignore this line completely
      -- %f = Filename
      -- %l = Line number
      -- %c = Column number
      -- %t = Error type (E/W/N)
      -- %m = Error message
      -- %p = Pointer line (shows where error occurs with ^)

      lint.linters.gfortran = {
        cmd = "gfortran",
        -- stdin = true,
        args = require("plugins.args.fortran").linter or {},
        ignore_exitcode = true,
        stream = "both",
        parser = require("lint.parser").from_errorformat(
          "%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\\ %m,%Z%tarning:\\ %m,%Z%tote:\\ %m,%C%.%#,%-G%.%#",
          {}
        ),
      }
      lint.linters["markdownlint-cli2"] = {
        args = { "--config", os.getenv("HOME") .. "/.markdownlint-cli2.yaml" },
      }
      lint.linters_by_ft = {
        fortran = { "gfortran", "fortitude" },
        markdown = { "markdownlint-cli2" },
        fish = { "fish" },
      }
    end,
  },
}
