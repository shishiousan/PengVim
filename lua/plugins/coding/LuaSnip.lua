return {
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    event = "InsertEnter",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
          exclude = { "all", "global", "latex", "julia", "fortran" },
        })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = "./snippets",
      })
      require("luasnip").filetype_extend("quarto", { "markdown" })
    end,
  },
}
