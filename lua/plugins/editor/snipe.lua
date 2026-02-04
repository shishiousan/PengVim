return {
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "<leader>fb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        max_height = -1, -- -1 means dynamic height
        position = "center",
        open_win_override = {
          title = "PengVim",
          border = "rounded",
        },

        -- Preselect the currently open buffer
        preselect_current = true,

        text_align = "left",

        buffer_format = {
          "-> ",
          "icon",
          " ",
          "filename",
          " ",
          "directory",
          function(buf)
            if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf.id)) == 1 then
              return " ", "SnipeText"
            end
          end,
        },
      },
      hints = {
        dictionary = "sadflewcmpghio",
      },
      navigate = {
        next_page = "J",
        prev_page = "K",

        under_cursor = "<CR>",

        cancel_snipe = "<ESC>",

        close_buffer = "D",
        open_vsplit = "V",
        open_split = "H",
        change_tag = "R",
      },
      sort = "default",
    },
  },
}
