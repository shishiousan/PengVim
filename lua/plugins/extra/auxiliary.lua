return {
  { -- Penguins go crazy
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>ph",
        function()
          require("duck").hatch("🐧")
        end,
        desc = "Penguins hatch",
      },
      {
        "<leader>pb",
        function()
          require("duck").cook()
        end,
        desc = "Penguins bye bye",
      },
      {
        "<leader>pa",
        function()
          require("duck").cook_all()
        end,
        desc = "All Penguins bye bye",
      },
    },
  },
  { -- famous net meme
    "GitMarkedDan/you-are-an-idiot.nvim",
    enabled = false,
    lazy = true,
    config = function()
      local opts = {
        window = {
          relative = "editor",
          style = "minimal",
          border = "single",
          width = 17,
          height = 1,
        },
        resize_window_to_fit = true,
        text = "You are an idiot!",
        flash_interval = 0,
        focus_cursor = true,
        is_scratch = true,
        min_velocity = 20,
        max_velocity = 30,
        reproduce_count = 5,
        initial = {
          {
            x = "rand",
            y = "rand",
            moving = true,
          },
        },
        delta_time = 0.05,
      }
      require("you-are-an-idiot").setup(opts)
      vim.api.nvim_create_user_command("ToggleIdiot", function()
        local idiot = require("you-are-an-idiot")
        if idiot.is_running() then
          idiot.abort()
        else
          idiot.run()
          vim.cmd([[silent exec "! mpv ~/Music/you.ogg"]])
        end
      end, { desc = "Toggles YouAreAnIdiot" })
    end,
  },
}
