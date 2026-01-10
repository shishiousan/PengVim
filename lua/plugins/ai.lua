return {
  -- NOTE: my codecompanion setup needs copilot
  -- please execute a command "Copilot auth" to activate it
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
        },
        nes = {
          enabled = false,
        },
      })
    end,
  },
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup({
        filetypes = {
          snacks_picker_input = false,
        },
      })
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
      vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
      vim.keymap.set("i", "<A-a>", neocodeium.accept_line)
      vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete)
      vim.keymap.set("i", "<A-r>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<A-c>", neocodeium.clear)
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    opts = {
      strategies = {
        chat = {
          keymaps = {
            send = {
              modes = { n = "<C-CR>", i = "<C-CR>" },
            },
            close = {
              modes = { n = "<C-x>", i = "<C-x>" },
            },
          },
          roles = {
            llm = function(adapter)
              return " " .. adapter.formatted_name
            end,
            user = "🐧 Shion",
          },
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4.5",
              },
            },
          })
        end,
      },
      display = {
        chat = {
          auto_scroll = true,
          show_header_separator = true,
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "<C-s>",
            auto_save = false,
            expiration_days = 0,
            picker = "snacks",
            auto_generate_title = true,
            title_generation_opts = {
              adapter = nil,
              model = nil,
            },
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = os.getenv("HOME") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
          },
        },
      },
    },
    keys = {
      {
        "<leader>cc",
        ":CodeCompanionChat Toggle<CR>",
        mode = { "n", "v" },
        silent = true,
      },
    },
  },
}
