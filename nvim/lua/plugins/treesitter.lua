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
      -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
      -- would overwrite `ensure_installed` with the new value.
      -- If you'd rather extend the default config, use the code below instead:
      -- opts = function(_, opts)
      -- add tsx and treesitter
      -- vim.list_extend(opts.ensure_installed, {
      -- "tsx",
      -- "typescript",
      -- })
      -- end,
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
