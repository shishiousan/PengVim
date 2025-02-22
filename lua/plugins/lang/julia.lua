return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          on_new_config = function(new_config, _)
            local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
            local REVISE_LANGUAGESERVER = false
            if REVISE_LANGUAGESERVER then
              new_config.cmd[5] = (new_config.cmd[5]):gsub(
                "using LanguageServer",
                "using Revise; using LanguageServer; LanguageServer.USE_REVISE[] = true"
              )
            elseif (vim.loop.fs_stat(julia) or {}).type == "file" then
              new_config.cmd[1] = julia
            end
          end,
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("Project.toml")(fname)
              or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
              or vim.fs.dirname(fname)
          end,
          on_attach = function(_, bufnr)
            vim.bo[bufnr].formatexpr = ""
          end,
        },
      },
    },
  },
}
