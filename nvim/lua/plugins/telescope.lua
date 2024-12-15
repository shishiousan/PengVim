return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-bibtex.nvim",
    },
    opts = {
      defaults = {
        layout_strategy = "center",
        layout_config = {
          center = {
            anchor = "N",
            height = 0.35,
            width = 0.8,
            prompt_position = "bottom",
            preview_cutoff = 1,
          },
          horizontal = {
            prompt_position = "top",
            preview_cutoff = 1,
          },
        },
      },
      load_extension = { "bibtex" },
      extensions = {
        bibtex = {
          depth = 1,
          custom_formats = {},
          format = "",
          -- global_files = { "~/texmf/bibtex/bib/test.bib" },
          global_files = { "~/texmf/bibtex/bib/Zotero.bib" },
          -- Path to global bibliographies (placed outside of the project)
          search_keys = { "author", "year", "title" },
          -- Define the search keys to use in the picker
          citation_format = "{{author}} ({{year}}), {{title}}.",
          -- Template for the formatted citation
          citation_trim_firstname = true,
          -- Only use initials for the authors first name
          citation_max_auth = 2,
          -- Max number of authors to write in the formatted citation
          -- following authors will be replaced by "et al."
          context = false,
          -- Context awareness disabled by default
          context_fallback = true,
          -- Fallback to global/directory .bib files if context not found
          -- This setting has no effect if context = false
          wrap = false,
          -- Wrapping in the preview window is disabled by default
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("bibtex")
      require("telescope").load_extension("fzf")
    end,
    keys = {
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader><space>", false },
      { "<leader>fb", false },
      { "<leader>,", false },
      { "<leader>/", false },
      { "<leader>:", false },
      { "<leader>fc", false },
      { "<leader>gc", false },
      { "<leader>gs", false },
      { "<leader>sa", false },
      { "<leader>sb", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      -- { "<leader>so ", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>uC", false },
      { "<leader>ss", false },
      { "<leader>sS", false },
    },
  },
}
