return {
  {
    "ibhagwan/fzf-lua",
    enabled = false,
    event = "VimEnter",
    dependencies = {
      "junegunn/fzf",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("fzf-lua").setup({
        fzf_colors = false,
        winopts = {
          preview = {
            hidden = "hidden",
          },
        },
        keymap = {
          builtin = {
            true,
            ["<esc>"] = "hide",
          },
        },
      })

      -- integrate fzf-lua with projects
      -- from https://github.com/ahmedkhalf/project.nvim/issues/99
      vim.keymap.set("n", "<leader>fp", function()
        local contents = require("project_nvim").get_recent_projects()
        local reverse = {}
        for i = #contents, 1, -1 do
          reverse[#reverse + 1] = contents[i]
        end
        local fzf = require("fzf-lua")
        fzf.fzf_exec(reverse, {
          actions = {
            ["default"] = function(e)
              -- vim.cmd.cd(e[1])
              fzf.files({ cwd = e[1] })
            end,
            ["ctrl-d"] = function(x)
              local choice = vim.fn.confirm("Delete '" .. #x .. "' projects? ", "&Yes\n&No", 2)
              if choice == 1 then
                local history = require("project_nvim.utils.history")
                for _, v in ipairs(x) do
                  history.delete_project(v)
                end
              end
            end,
          },
          prompt = "Projects> ",
          winopts = {
            height = 0.33,
            width = 0.66,
          },
        })
      end, { silent = true, desc = "Switch project" })
    end,
    keys = {
      {
        "<leader>F",
        "<cmd>FzfLua builtin<CR>",
        mode = { "n" },
        silent = true,
        desc = "fzf-lua builtin",
      },
      {
        "<leader>fF",
        "<cmd>FzfLua files<CR>",
        mode = { "n" },
        silent = true,
        desc = "Files (Root)",
      },
      {
        "<leader><leader>",
        "<cmd>FzfLua files<CR>",
        mode = { "n" },
        silent = true,
        desc = "Files (Root)",
      },
      {
        "<leader>ff",
        "<cmd>FzfLua files cwd=%:h:p<CR>",
        mode = { "n" },
        silent = true,
        desc = "Files (cwd)",
      },
      {
        "<leader>fg",
        "<cmd>FzfLua git_files<CR>",
        mode = { "n" },
        silent = true,
        desc = "Git Files (cwd)",
      },
      {
        "<leader>fr",
        "<cmd>FzfLua oldfiles<CR>",
        mode = { "n" },
        silent = true,
        desc = "Recent files",
      },
      {
        "<leader>fR",
        "<cmd>FzfLua oldfiles cwd=%:h:p<CR>",
        mode = { "n" },
        silent = true,
        desc = "Recent files (cwd)",
      },
      {
        "<leader>fb",
        "<cmd>FzfLua buffers <CR>",
        mode = { "n" },
        silent = true,
        desc = "Buffers",
      },
      {
        "<leader>,",
        "<cmd>FzfLua buffers <CR>",
        mode = { "n" },
        silent = true,
        desc = "Switch Buffers",
      },
      {
        "<leader>/",
        "<cmd>FzfLua live_grep_glob <CR>",
        mode = { "n" },
        silent = true,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>:",
        "<cmd>FzfLua command_history <CR>",
        mode = { "n" },
        silent = true,
        desc = "Command History",
      },
      -- {
      --   "<leader>fc",
      --   "<cmd>FzfLua dap_configurations <CR>",
      --   mode = { "n" },
      --   silent = true,
      --   desc = "dap configurations",
      -- },
      {
        "<leader>gc",
        "<cmd>FzfLua git_commits <CR>",
        mode = { "n" },
        silent = true,
        desc = "Git Commits",
      },
      {
        "<leader>gs",
        "<cmd>FzfLua git_status <CR>",
        mode = { "n" },
        silent = true,
        desc = "Git Status",
      },
      {
        "<leader>sa",
        "<cmd>FzfLua autocmds <CR>",
        mode = { "n" },
        silent = true,
        desc = "Autocommands",
      },
      {
        "<leader>sb",
        "<cmd>FzfLua grep_curbuf <CR>",
        mode = { "n" },
        silent = true,
        desc = "Grep Current Buffer",
      },
      {
        "<leader>sc",
        "<cmd>FzfLua command_history <CR>",
        mode = { "n" },
        silent = true,
        desc = "Command History",
      },
      {
        "<leader>sC",
        "<cmd>FzfLua commands <CR>",
        mode = { "n" },
        silent = true,
        desc = "Commands",
      },
      {
        "<leader>sd",
        "<cmd>FzfLua diagnostics_document <CR>",
        mode = { "n" },
        silent = true,
        desc = "Diagnostics Document",
      },
      {
        "<leader>sD",
        "<cmd>FzfLua diagnostics_workspace <CR>",
        mode = { "n" },
        silent = true,
        desc = "Diagnostics Workspace",
      },
      {
        "<leader>sg",
        "<cmd>FzfLua grep_project multiline=2<CR>",
        mode = { "n" },
        silent = true,
        desc = "Grep Project",
      },
      {
        "<leader>sG",
        "<cmd>FzfLua grep_curbuf multiline=2<CR>",
        mode = { "n" },
        silent = true,
        desc = "Grep Current Buffer",
      },
      {
        "<leader>sh",
        "<cmd>FzfLua helptags <CR>",
        mode = { "n" },
        silent = true,
        desc = "Helptags",
      },
      {
        "<leader>sH",
        "<cmd>FzfLua highlights <CR>",
        mode = { "n" },
        silent = true,
        desc = "Highlights",
      },
      {
        "<leader>sj",
        "<cmd>FzfLua jumps <CR>",
        mode = { "n" },
        silent = true,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        "<cmd>FzfLua keymaps <CR>",
        mode = { "n" },
        silent = true,
        desc = "Keymaps",
      },
      {
        "<leader>sl",
        "<cmd>FzfLua loclist <CR>",
        mode = { "n" },
        silent = true,
        desc = "Loclist",
      },
      {
        "<leader>sM",
        "<cmd>FzfLua manpages <CR>",
        mode = { "n" },
        silent = true,
        desc = "Manpages",
      },
      {
        "<leader>sm",
        "<cmd>FzfLua marks <CR>",
        mode = { "n" },
        silent = true,
        desc = "Marks",
      },
      -- {
      --   "<leader>so",
      --   "<cmd>FzfLua options <CR>",
      --   mode = { "n" },
      --   silent = true,
      --   desc = "Options",
      -- },
      {
        "<leader>sR",
        "<cmd>FzfLua resume <CR>",
        mode = { "n" },
        silent = true,
        desc = "Resume",
      },
      {
        "<leader>sq",
        "<cmd>FzfLua quickfix <CR>",
        mode = { "n" },
        silent = true,
        desc = "Quickfix",
      },
      {
        "<leader>sw",
        "<cmd>FzfLua grep_cword multiline=2<CR>",
        mode = { "n" },
        silent = true,
        desc = "Grep Current Word (project)",
      },
      {
        "<leader>sW",
        "<cmd>FzfLua grep_cWORD multiline=2<CR>",
        mode = { "n" },
        silent = true,
        desc = "Grep Current Word (cwd)",
      },
      {
        "<leader>uC",
        "<cmd>FzfLua colorschemes <cr>",
        mode = { "n" },
        silent = true,
        desc = "Colorschemes",
      },
      {
        "<leader>ss",
        "<cmd>FzfLua lsp_document_symbols multiline=2<cr>",
        mode = { "n" },
        silent = true,
        desc = "LSP Document Symbols",
      },
      {
        "<leader>sS",
        "<cmd>FzfLua lsp_workspace_symbols <cr>",
        mode = { "n" },
        silent = true,
        desc = "LSP Workspace Symbols",
      },
    },
  },
}
