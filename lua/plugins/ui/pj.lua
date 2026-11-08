return {
  {
    "josephschmitt/pj.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "Pj", "PjCd" },
    keys = {
      {
        "<leader>fp",
        function()
          local depth_module = require("pj.depth")
          local config = require("pj.config").options
          local finder = require("pj.finder")

          if not finder.check_binary() then
            if config.behavior.notify_on_error then
              vim.notify("pj binary not found. Please install it first.", vim.log.levels.ERROR)
            end
            return
          end

          local function pj_finder()
            local projects, err = finder.get_projects()
            if err then
              if config.behavior.notify_on_error then
                vim.notify(err, vim.log.levels.ERROR)
              end
              return {}
            end
            return projects or {}
          end

          local function pj_format(item, picker)
            local ret = {}
            local data = item.data

            if data.icon and data.icon ~= "" then
              local hl = data.icon_hl or "SnacksPickerIcon"
              ret[#ret + 1] = { data.icon, hl, virtual = true }
              ret[#ret + 1] = { " ", virtual = true }
            end

            ret[#ret + 1] = { data.name, "SnacksPickerFile" }
            ret[#ret + 1] = { " " }

            ret[#ret + 1] = { data.display_path, "SnacksPickerDir" }

            return ret
          end

          local initial_projects = pj_finder()
          if #initial_projects == 0 then
            vim.notify("No projects found", vim.log.levels.WARN)
            return
          end

          local keymaps = config.keymaps or {}
          local input_keys = {}
          if keymaps.depth_increase then
            input_keys[keymaps.depth_increase] = { "pj_depth_increase", mode = { "i", "n" }, desc = "Increase depth" }
          end
          if keymaps.depth_decrease then
            input_keys[keymaps.depth_decrease] = { "pj_depth_decrease", mode = { "i", "n" }, desc = "Decrease depth" }
          end
          local snacks = require("snacks")

          snacks.picker({
            title = "Get Projects",
            finder = pj_finder,
            format = pj_format,
            actions = {
              pj_depth_increase = function(picker)
                local _, changed = depth_module.increment()
                if changed then
                  picker.title = "Get Projects"
                  picker:update_titles()
                  picker:refresh()
                else
                  vim.notify("Already at maximum depth", vim.log.levels.WARN)
                end
              end,
              pj_depth_decrease = function(picker)
                local _, changed = depth_module.decrement()
                if changed then
                  picker.title = "Get Projects"
                  picker:update_titles()
                  picker:refresh()
                else
                  vim.notify("Already at minimum depth", vim.log.levels.WARN)
                end
              end,
            },
            win = {
              input = {
                keys = input_keys,
              },
            },
            confirm = function(picker, item)
              if not item then
                return
              end

              if config.behavior.close_on_select then
                picker:close()
              end

              -- Handle different open modes based on opts
              -- if opts.split then
              --   vim.cmd("split")
              -- elseif opts.vsplit then
              --   vim.cmd("vsplit")
              -- elseif opts.tab then
              --   vim.cmd("tabnew")
              -- end

              require("fff").find_files_in_dir(item.data.path)
            end,
          })
        end,
        desc = "Find Projects and pick the file",
      },
    },
    opts = {
      pj = {
        cmd = "auto",
        args = {},
        icons = true,
        cache = false,
        auto = {
          prefer_system = true,
        },
      },

      picker = {
        type = "snacks",
      },

      behavior = {
        cd_on_select = true,
        cd_scope = "tab", -- "tab" (tcd) or "global" (cd)
        session_manager = nil, -- nil, "auto-session", or "persistence"
      },

      keymaps = {
        open = "<CR>",
        split = "<C-x>",
        vsplit = "<C-s>",
        tab = "<C-t>",
        depth_increase = "<C-l>",
        depth_decrease = "<C-h>",
      },

      depth = {
        initial = nil, -- nil means 3
        min = 1,
        max = 10,
      },
    },
  },
}
