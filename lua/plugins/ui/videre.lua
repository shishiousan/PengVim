return {
  "Owen-Dechow/videre.nvim",
  cmd = "Videre",
  dependencies = {
    "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
    "Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
    -- "a-usr/xml2lua.nvim",
  },
  opts = {
    ---@alias LineStyle "sharp"|"rounded"|"bold"|"double"
    ---@alias ColumnAlignment "top"|"center"|"bottom"
    ---@alias RowAlignment "left"|"center"|"right"

    ---@type ColumnAlignment
    column_alignment = "center",

    ---@type RowAlignment
    key_alignment = "right",

    ---@type RowAlignment
    value_alignment = "right",

    ---@type integer
    max_cell_lines = 5,

    ---@type LineStyle
    box_style = "double",

    ---@type LineStyle
    line_style = "double",

    ---@type integer
    editor_window_width = 60,

    keymaps = {
      expand = "E",
      collapse = "E",
      jump_forward = "L",
      jump_back = "H",
      jump_down = "J",
      jump_up = "K",
      set_as_root = "R",
      return_to_parent_table = "H",

      change_key = "C",
      change_value = "V",
      delete_value = "D",
      add_value = "A",
      change_type = "T",
      undo = "u",
      redo = "<C-r>",

      help = "g?",

      close_window = "q",
    },

    ---@type "split"|"floating"
    editor_type = "split",

    floating_editor_style = {
      margin = 2,

      ---@type "rounded"|"double"|"shadow"|"none"
      border = "rounded",

      zindex = 10,
    },

    split_editor_style = {
      ---@type "left"|"right"|"default"
      side = "right",

      fill_percentage = 0.7,
    },

    index_base = 0,
  },
}
