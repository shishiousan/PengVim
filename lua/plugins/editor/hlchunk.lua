return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          style = {
            "#00ffff",
            "#c21f30",
          },
          exclude_filetypes = {
            toml = true,
          },
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
          style = "#b30eec",
          use_treesitter = true,
          exclude_filetypes = {
            toml = true,
          },
        },
      })
    end,
  },
}
