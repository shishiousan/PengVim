-- TeX / BibTeX buffers (bib.lua sources this file too)

-- <C-s> skips conform for these buffers; use <leader>vf (latexindent) instead
vim.b.autoformat = false
vim.opt_local.conceallevel = 2

-- $VIMTEX_OUTPUT_DIRECTORY, if it is set and exists
local function output_dir()
  local dir = vim.env.VIMTEX_OUTPUT_DIRECTORY
  if dir and vim.fn.isdirectory(dir) == 1 then
    return dir
  end
end

require("which-key").add({
  buffer = 0,
  { "<leader>v", group = "[V]imTex" },
  { "<leader>vb", "<cmd>VimtexCompile<CR>", desc = "Build" },
  { "<leader>vc", "<cmd>VimtexCountWords!<CR>", desc = "Count Words" },
  { "<leader>vd", "<cmd>VimtexClean<CR>", desc = "Delete aux" },
  {
    "<leader>ve",
    function()
      local dir = output_dir()
      if dir then
        vim.cmd("! bibexport -o %:r.bib ./" .. dir .. "/%:r.aux")
      else
        vim.cmd("! bibexport -o %:r.bib %:r.aux")
      end
    end,
    desc = "MAKE bib file",
  },
  {
    "<leader>vf",
    function()
      vim.cmd.write() -- latexindent reads the file on disk, so save first
      if vim.bo.filetype ~= "tex" then
        vim.notify("Only default save was done (no format)", vim.log.levels.WARN, { title = "This is not TeX file" })
        return
      end
      -- -c: where indent.log goes; -o: overwrite without a backup (-w/-ww keep one)
      local dir = output_dir()
      if dir then
        vim.cmd("! latexindent -c " .. dir .. " -s -o % %")
      else
        vim.cmd("! latexindent -s -o % %")
      end
    end,
    desc = "FORMAT SAVE (no backup)",
  },
  { "<leader>vl", "<cmd>VimtexErrors<CR>", desc = "Error Log" },
  { "<leader>vm", "<plug>(vimtex-context-menu)", desc = "Vimtex menu" },
  { "<leader>vr", "<plug>(vimtex-doc-package)", desc = "Read VimTex Doc" },
  { "<leader>vv", "<cmd>VimtexView<CR>", desc = "View PDF" },
  { "<leader>vt", "<cmd>VimtexTocToggle<CR>", desc = "Toggle Table of Contents" },
})
