return {
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = function()
      require("goto-preview").setup({
        width = 120,
        height = 15,
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
        default_mappings = true,
        references = {
          provider = "snacks",
        },
        post_open_hook = function(buffer, _)
          vim.api.nvim_buf_set_keymap(buffer, "n", "v", "<C-W>L", { noremap = true })
          vim.api.nvim_buf_set_keymap(buffer, "n", "s", "<C-W>J", { noremap = true })
          vim.api.nvim_buf_set_keymap(buffer, "n", "q", ":q<CR>", { noremap = true })
        end,
      })
    end,
  },
}
