local j_tnum = "10"
local j_tnum_int = 10
return {
  ---@diagnostic disable: missing-fields
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          symbol_cache_download = false,
          on_new_config = function(new_config, _)
            local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
            if require("lspconfig").util.path.is_file(julia) then
              new_config.cmd[1] = julia
            end
            -- new_config.cmd_env = vim.tbl_extend("keep", new_config.cmd_env or {}, {
            --   SYMBOL_SERVER = new_config.symbol_server,
            --   SYMBOL_CACHE_DOWNLOAD = (new_config.symbol_cache_download == false) and "0" or "1",
            -- })
          end,
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("Project.toml")(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
          end,
          settings = {
            julials = {
              -- you can write some settings for julials
            },
          },
        },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    -- event =  "VeryLazy",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "ibhagwan/fzf-lua",
      { "echasnovski/mini.indentscope", version = "*" },
    },
    version = "*",
    opts = {
      direction = "horizontal",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      shade_terminals = false,
      open_mapping = [[<c-\>]],
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end,
      },
    },
    keys = {
      {
        "<F5>",
        "<cmd>" .. j_tnum .. "TermExec cmd='julia -q --project' open=0<CR><cmd>" .. j_tnum .. "ToggleTerm<CR><C-w>h",
        mode = { "n" },
        silent = false,
        desc = "Init Julia",
      },
      {
        "<F6>",
        "<cmd>" .. j_tnum .. "TermExec cmd='exit()' open=0<CR><cmd>" .. j_tnum .. "ToggleTerm<CR><C-w>h",
        mode = { "n" },
        silent = false,
        desc = "Exit Julia",
      },
      {
        "<C-A-n>",
        "<esc><cmd>"
          .. 2 * j_tnum
          .. "TermExec cmd='cd %:p:h && julia -q %:t' open=0<CR><cmd>"
          .. 2 * j_tnum
          .. "ToggleTerm<CR><C-w>h",
        silent = false,
        mode = { "n", "i" },
      },
      {
        "<S-CR>",
        function()
          local mini_ind_scope = require("mini.indentscope")
          local ind_scope_top = mini_ind_scope.get_scope().border.top
          if ind_scope_top == 0 then
            require("toggleterm").send_lines_to_terminal("single_line", false, { args = j_tnum_int })
            vim.cmd("silent! /^.\\+")
            vim.cmd("nohlsearch")
          else
            mini_ind_scope.textobject(true)
          end
        end,
        silent = true,
        mode = { "n" },
      },
      {
        "<S-CR>",
        function()
          vim.cmd("normal !")
          local mini_ind_scope = require("mini.indentscope")
          local ind_scope_top = mini_ind_scope.get_scope().border.top
          if ind_scope_top == 0 then
            require("toggleterm").send_lines_to_terminal("single_line", false, { args = j_tnum_int })
            vim.cmd("silent! /^.\\+")
            vim.cmd("nohlsearch")
          else
            mini_ind_scope.textobject(true)
            local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
            vim.api.nvim_feedkeys(keys, "i", true)
          end
        end,
        silent = true,
        mode = { "i" },
      },
      {
        "<S-CR>",
        ":'<,'>ToggleTermSendVisualLines " .. j_tnum .. "<CR>`>:silent! /^.\\+<CR>:nohlsearch<CR>",
        silent = true,
        mode = { "v" },
      },
      -- TODO: add function skip comment line
      -- tips for this are vim.opt.commentstring._value, (it needs string.sub or matching)
      -- vim.fn.getlinen('.'):sub(1,1)
      -- while there is no matcing skip current line
    },
  },
}
