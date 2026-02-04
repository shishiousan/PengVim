return {
  {
    "olimorris/codecompanion.nvim",
    -- NOTE: my codecompanion setup needs copilot
    -- please execute a command "Copilot auth" to activate it
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
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
