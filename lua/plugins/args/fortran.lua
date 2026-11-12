local M = {}

-- Fall back to ~/Dropbox so a missing $DROPBOX does not break the whole config.
local dropbox = vim.env.DROPBOX or vim.fn.expand("~/Dropbox")
local home = vim.env.HOME

M.lsp_cmd = {
  "fortls",
  "--nthreads",
  "10",
  "--lowercase_intrinsics",
  "--hover_signature",
  "--hover_language=fortran",
  "--use_signature_help",
  "--disable_diagnostic",
  "--incremental_sync",
  "--recursion_limit",
  "1000",
  "--source_dirs",
  dropbox .. "/easifem/base/src/**",
  dropbox .. "/easifem/classes/src/**",
  dropbox .. "/easifem/oneDimElasticity/src/**",
  dropbox .. "/easifem/oneDimLayeredMedia/src/**",
  dropbox .. "/easifem/oneDimPoroElasticity/src/**",
  dropbox .. "/easifem/sdof/src/**",
  dropbox .. "/easifem/diffusionKernel/src/**",
  dropbox .. "/easifem/elasticityKernel/src/**",
  dropbox .. "/easifem/scalarWave/src/**",
  dropbox .. "/easifem/dispersionAnalysis/src/**",
  home .. "/.easifem/src/tomlf/src/**",
}

M.formatter = {
  "--line-length",
  "78",
  "--indent",
  "2",
  "--strict-indent",
  "--disable-indent-mod",
  "--whitespace",
  "2",
  "--whitespace-comma",
  "--whitespace-assignment",
  "--enable-decl",
  "--whitespace-decl",
  "--whitespace-relational",
  "--whitespace-logical",
  "--whitespace-multdiv",
  "--whitespace-print",
  "--whitespace-intrinsics",
  "--strip-comments",
  "--case",
  "2",
  "2",
  "2",
  "2",
}

return M
