return {
  -- NOTE: I am using Two AI assistants: neocodeium and copilot
  -- neocodeium is used to generate auto-completion
  -- copilot is used to do chatting
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
    -- AI Chat utility
    -- NOTE: codecompanion needs copilot
    -- please execute a command "Copilot auth" to activate it
    "olimorris/codecompanion.nvim",
    -- lazy = false,
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
                default = "gpt-4.1",
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
  {
    -- This is native for copilot
    -- if you prefer you can choose this as AI chat
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    branch = "main",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          ["*"] = false,
        },
      })
    end,
  },
}
