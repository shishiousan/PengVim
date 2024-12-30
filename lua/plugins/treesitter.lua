return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "yaml",
        "toml",
        "julia",
        "fortran",
        "fish",
        "csv",
      },
      indent = {
        enable = true,
        disable = { "julia", "fortran" },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- disable = { "gnuplot" },
      },
    },
  },
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
}
