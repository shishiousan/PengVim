return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
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
          global_files = { "~/texmf/bibtex/bib/Zotero.bib" },
          search_keys = { "author", "year", "title" },
          citation_format = "{{author}} ({{year}}), {{title}}.",
          citation_trim_firstname = true,
          citation_max_auth = 2,
          context = false,
          context_fallback = true,
          wrap = false,
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("bibtex")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("projects")
    end,
  },
}
