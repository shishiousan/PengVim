local wk = require("which-key")
-- normal
wk.add({
  {
    -- { "<leader>O", "<cmd>Oil<cr>", desc = "Oil explorer (cwd)" },
    { "<leader>f", group = "+file/find" },
    {
      "<leader>fo",
      "<cmd>Neotree position=float reveal_force_cwd=true dir=%:p:h reveal_file=%:p<CR>",
      desc = "Reveal in the tree",
    },
  },
})

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        event_handlers = {
          {
            event = "neo_tree_popup_input_ready",
            ---@param args { bufnr: integer, winid: integer }
            handler = function(args)
              -- vim.cmd("stopinsert")
              vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
            end,
          },
        },
        -- enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil, -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        -- write the code
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "float", -- "left", "right", "top", "bottom" , "current" and "float"
          width = 65,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false,
              -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            -- ["i"] = "show_file_details", --disabled because some error occourred
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        },
      })
    end,
  },
  -- {
  --   "stevearc/oil.nvim",
  --   lazy = false,
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("oil").setup({
  --       -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  --       -- Set to false if you still want to use netrw.
  --       default_file_explorer = true,
  --       -- Id is automatically added at the beginning, and name at the end
  --       -- See :help oil-columns
  --       columns = {
  --         "icon",
  --         -- "permissions",
  --         -- "size",
  --         -- "mtime",
  --       },
  --       -- Buffer-local options to use for oil buffers
  --       buf_options = {
  --         buflisted = false,
  --         bufhidden = "hide",
  --       },
  --       -- Window-local options to use for oil buffers
  --       win_options = {
  --         wrap = false,
  --         signcolumn = "no",
  --         cursorcolumn = false,
  --         foldcolumn = "0",
  --         spell = false,
  --         list = false,
  --         conceallevel = 3,
  --         concealcursor = "n",
  --       },
  --       -- Restore window options to previous values when leaving an oil buffer
  --       restore_win_options = true,
  --       -- Skip the confirmation popup for simple operations
  --       skip_confirm_for_simple_edits = false,
  --       -- Deleted files will be removed with the trash_command (below).
  --       delete_to_trash = false,
  --       -- Change this to customize the command used when deleting to trash
  --       trash_command = "trash-put",
  --       -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  --       prompt_save_on_select_new_entry = true,
  --       -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  --       -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  --       -- Additionally, if it is a string that matches "actions.<name>",
  --       -- it will use the mapping at require("oil.actions").<name>
  --       -- Set to `false` to remove a keymap
  --       -- See :help oil-actions for a list of all available actions
  --       keymaps = {
  --         ["g?"] = "actions.show_help",
  --         ["<CR>"] = "actions.select",
  --         ["<C-s>"] = "actions.select_vsplit",
  --         ["<C-h>"] = "actions.select_split",
  --         ["<C-t>"] = "actions.select_tab",
  --         ["<C-p>"] = "actions.preview",
  --         ["<C-c>"] = "actions.close",
  --         ["<C-l>"] = "actions.refresh",
  --         ["-"] = "actions.parent",
  --         ["_"] = "actions.open_cwd",
  --         ["`"] = "actions.cd",
  --         ["~"] = "actions.tcd",
  --         ["g."] = "actions.toggle_hidden",
  --       },
  --       -- Set to false to disable all of the above keymaps
  --       use_default_keymaps = true,
  --       view_options = {
  --         -- Show files and directories that start with "."
  --         show_hidden = false,
  --         -- This function defines what is considered a "hidden" file
  --         is_hidden_file = function(name, bufnr)
  --           return vim.startswith(name, ".")
  --         end,
  --         -- This function defines what will never be shown, even when `show_hidden` is set
  --         is_always_hidden = function(name, bufnr)
  --           return false
  --         end,
  --       },
  --       -- Configuration for the floating window in oil.open_float
  --       float = {
  --         -- Padding around the floating window
  --         padding = 2,
  --         max_width = 0,
  --         max_height = 0,
  --         border = "rounded",
  --         win_options = {
  --           winblend = 0,
  --         },
  --         -- This is the config that will be passed to nvim_open_win.
  --         -- Change values here to customize the layout
  --         override = function(conf)
  --           return conf
  --         end,
  --       },
  --       -- Configuration for the actions floating preview window
  --       preview = {
  --         -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
  --         -- min_width and max_width can be a single value or a list of mixed integer/float types.
  --         -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
  --         max_width = 0.9,
  --         -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
  --         min_width = { 40, 0.4 },
  --         -- optionally define an integer/float for the exact width of the preview window
  --         width = nil,
  --         -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
  --         -- min_height and max_height can be a single value or a list of mixed integer/float types.
  --         -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
  --         max_height = 0.9,
  --         -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
  --         min_height = { 5, 0.1 },
  --         -- optionally define an integer/float for the exact height of the preview window
  --         height = nil,
  --         border = "rounded",
  --         win_options = {
  --           winblend = 0,
  --         },
  --       },
  --       -- Configuration for the floating progress window
  --       progress = {
  --         max_width = 0.9,
  --         min_width = { 40, 0.4 },
  --         width = nil,
  --         max_height = { 10, 0.9 },
  --         min_height = { 5, 0.1 },
  --         height = nil,
  --         border = "rounded",
  --         minimized_border = "none",
  --         win_options = {
  --           winblend = 0,
  --         },
  --       },
  --     })
  --   end,
  -- },
}
