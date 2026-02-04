return {
  {
    "b0o/incline.nvim",
    event = { "VeryLazy" },
    keys = {
      {
        "<leader>uN",
        function()
          require("incline").toggle()
        end,
        desc = "Incline Toggle",
      },
    },
    opts = {
      highlight = {
        groups = {},
      },
      window = {
        options = {
          winblend = 0,
        },
        placement = {
          horizontal = "right",
          vertical = "bottom",
        },
        margin = { horizontal = 0, vertical = 1 },
        padding = 2,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        -- this devicons method is mocked by mini.icons
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"

        local function get_git_diff()
          local icons = { removed = " ", changed = " ", added = " " }
          icons["changed"] = icons.modified
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
            end
          end
          if #labels > 0 then
            table.insert(labels, { " | " })
          end
          return labels
        end
        local function get_diagnostic_label()
          local icons = { error = " ", warn = " ", info = " ", hint = " " }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { " | " })
          end
          return label
        end

        local line = vim.api.nvim_win_get_cursor(props.win)[1]
        local total_lines = vim.api.nvim_buf_line_count(props.buf)
        local col = vim.api.nvim_win_get_cursor(props.win)[2] + 1

        local percentage = math.floor((line / total_lines) * 100)

        local buffer = {
          { get_diagnostic_label() },
          { get_git_diff() },
          { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
          { filename .. " ", gui = modified },
          { " | " .. line .. ":" .. col },
          { string.format(" | %d%%", percentage), group = "LinePercent" }, -- Add this line
        }
        return buffer
      end,
    },
  },
}
