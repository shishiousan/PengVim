local wk = require("which-key")

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function delMap(mode, lhs)
  vim.keymap.del(mode, lhs)
end

map("i", "jk", "<esc>")

map("n", "<C-n>", "<cmd>nohlsearch<CR>")

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<leader>j", "yyp", { desc = "Paste line below" })
map("n", "<leader>k", "yyP", { desc = "Paste line above" })
map("v", "<leader>j", "Yp", { desc = "Paste below" })
map("v", "<leader>k", "YP", { desc = "Paste above" })

map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
map("n", "<leader>qw", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>qo", "<cmd>only<CR>", { desc = "Only" })

-- save file
map({ "n", "i" }, "<C-s>", function()
  if vim.g.autoformat then
    require("conform").format({})
  end
  vim.cmd("silent! w")
end, { desc = "write" })

map("n", "<leader>uf", function()
  if vim.g.autoformat then
    vim.notify("autoformat is disabled")
  else
    vim.notify("autoformat is enabled")
  end
  vim.g.autoformat = not vim.g.autoformat
end, { desc = "Toggle autoformat" })

map("n", "<leader>ww", "<cmd>silent! w<CR>", { desc = "write" })
map("n", "<leader>fa", "<cmd>silent! wa<CR>", { desc = "write all" })
map("n", "<leader>fq", "<cmd>silent! wa<CR><cmd>qa<CR>", { desc = "write all and quit all" })
--
-- map("n", "<leader>rp", "o<esc>v:'<,'>!erun -bs %<CR>")
-- map("n", "<leader>rr", ":!erun -bs %<CR>")
-- map("n", "<leader>rr", function()
--   local text = vim.cmd([[!erun -bs %]])
--   vim.print(text)
-- end)

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle featured by Snacks
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
  :map("<leader>uc")
Snacks.toggle
  .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
  :map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = vim.uv.cwd() })
  end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gf", function()
    Snacks.lazygit.log_file()
  end, { desc = "Lazygit Current File History" })
  map("n", "<leader>gl", function()
    Snacks.lazygit.log({ cwd = vim.uv.cwd() })
  end, { desc = "Lazygit Log" })
  map("n", "<leader>gL", function()
    Snacks.lazygit.log()
  end, { desc = "Lazygit Log (cwd)" })
end

map("n", "<leader>ft", function()
  if vim.g.use_myfmt then
    vim.notify("use_myfmt is disabled")
  else
    vim.notify("use_myfmt is enabled")
  end
  vim.g.use_myfmt = not vim.g.use_myfmt
end, { desc = "Toggle use_myfmt" })

map("n", "<leader>R", function()
  vim.notify("ReadMode Toggled")
  -- vim.o.scrolloff = vim.o.scrolloff == 4 and 999 or 4
  vim.cmd([[windo set scrollbind!]])
end, { desc = "Toggle readermode" })

map("n", "<leader>Cn", function()
  local ind = vim.g.currentCSNum
  if ind == vim.g.CSListsLen then
    ind = 1
  else
    ind = ind + 1
  end
  vim.g.currentCSNum = ind
  SwitchCS(ind)
end, { desc = "Next Colorscheme" })

map("n", "<leader>Cp", function()
  local ind = vim.g.currentCSNum
  if ind == 1 then
    ind = vim.g.CSListsLen
  else
    ind = ind - 1
  end
  vim.g.currentCSNum = ind
  SwitchCS(ind)
end, { desc = "Previous Colorscheme" })

map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bD", function()
  vim.cmd([[%bd|e#|bd#|'"]])
end, { desc = "Delete other buffers" })

map("n", "<leader>rs", function()
  require("persistence").load()
end, { desc = "Restore Session" })

map("n", "<leader>ua", function()
  ToggleAutoComplete()
end, { desc = "Toggle Auto Complete" })

-- Quarto featured by vim-slime
-- reference is quarto_nvim_kickstarter

vim.g["quarto_is_r_mode"] = nil
vim.g["reticulate_running"] = false

local function send_cell()
  if vim.b["quarto_is_r_mode"] == nil then
    vim.fn["slime#send_cell"]()
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.fn["slime#send_cell"]()
  end
end

local slime_send_region_cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
local function send_region()
  -- if filetyps is not quarto, just send_region
  if vim.bo.filetype ~= "quarto" or vim.b["quarto_is_r_mode"] == nil then
    vim.cmd("normal" .. slime_send_region_cmd)
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.cmd("normal" .. slime_send_region_cmd)
  end
end

-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
map({ "n", "i" }, "<c-cr>", send_cell)
map({ "n", "i" }, "<s-cr>", send_cell)
map({ "v" }, "<s-cr>", send_region)
map({ "v" }, "<c-cr>", send_region)

local is_code_chunk = function()
  local current, _ = require("otter.keeper").get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_py_chunk = function()
  insert_code_chunk("python")
end

local insert_lua_chunk = function()
  insert_code_chunk("lua")
end

local insert_julia_chunk = function()
  insert_code_chunk("julia")
end

local insert_bash_chunk = function()
  insert_code_chunk("bash")
end

local insert_fortran_chunk = function()
  insert_code_chunk("fortran")
end

wk.add({
  {
    { "<leader>i", group = "[I]nsert code chunk" },
    { "<leader>ip", insert_py_chunk, desc = "python code chunk" },
    { "<leader>ij", insert_julia_chunk, desc = "julia code chunk" },
    { "<leader>if", insert_fortran_chunk, desc = "fortran code chunk" },
    { "<leader>ib", insert_bash_chunk, desc = "bash code chunk" },
    { "<leader>il", insert_lua_chunk, desc = "lua code chunk" },
    { "<leader>ic", "O# %%<cr>", desc = "Comment code chunk # %%" },
  },
}, { mode = "n", silent = true })

wk.add({
  {
    mode = { "i" },
    { "<C-x><C-x>", "<C-x><C-o>", desc = "omnifunc completion" },
    { "<M-i>", insert_py_chunk, desc = "python code chunk" },
    { "<M-j>", insert_julia_chunk, desc = "julia code chunk" },
    { "<M-m>", " |>", desc = "pipe" },
  },
}, { mode = "i" })

local function new_terminal(lang)
  vim.cmd("vsplit term://" .. lang)
end

local function new_terminal_python()
  new_terminal("python")
end

local function new_terminal_ipython()
  new_terminal("ipython --no-confirm-exit")
end

local function new_terminal_julia()
  new_terminal("julia")
end

local function new_terminal_shell()
  new_terminal("$SHELL")
end

-- local function get_otter_symbols_lang()
--   local otterkeeper = require("otter.keeper")
--   local main_nr = vim.api.nvim_get_current_buf()
--   local langs = {}
--   for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
--     langs[i] = i .. ": " .. l
--   end
--   -- promt to choose one of langs
--   local i = vim.fn.inputlist(langs)
--   local lang = otterkeeper.rafts[main_nr].languages[i]
--   local params = {
--     textDocument = vim.lsp.util.make_text_document_params(),
--     otter = {
--       lang = lang,
--     },
--   }
--   vim.lsp.buf_request(main_nr, ms.textDocument_documentSymbol, params, nil)
-- end
-- vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "otter [s]ymbols" })

wk.add({
  {
    { "<leader><cr>", send_cell, desc = "run code cell" },
    { "<leader>c", group = "[c]ode / [c]ell / [c]hunk" },
    { "<leader>ci", new_terminal_ipython, desc = "new [i]python terminal" },
    { "<leader>cj", new_terminal_julia, desc = "new [j]ulia terminal" },
    { "<leader>cn", new_terminal_shell, desc = "[n]ew terminal with shell" },
    { "<leader>cp", new_terminal_python, desc = "new [p]ython terminal" },
    -- { "<leader>h", group = "[h]elp / [h]ide / debug" },
    -- { "<leader>hc", group = "[c]onceal" },
    -- { "<leader>hch", ":set conceallevel=1<cr>", desc = "[h]ide/conceal" },
    -- { "<leader>hcs", ":set conceallevel=0<cr>", desc = "[s]how/unconceal" },
    -- { "<leader>ht", group = "[t]reesitter" },
    -- { "<leader>htt", vim.treesitter.inspect_tree, desc = "show [t]ree" },
    { "<leader>o", group = "[o]tter & [O]verseer" },
    { "<leader>oa", require("otter").activate, desc = "otter [a]ctivate" },
    { "<leader>od", require("otter").activate, desc = "otter [d]eactivate" },
    { "<leader>Q", group = "[q]uarto" },
    {
      "<leader>QE",
      function()
        require("otter").export(true)
      end,
      desc = "[E]xport with overwrite",
    },
    { "<leader>Qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
    { "<leader>Qe", require("otter").export, desc = "[e]xport" },
    { "<leader>Qh", ":QuartoHelp ", desc = "[h]elp" },
    { "<leader>Qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
    { "<leader>Qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },
    { "<leader>Qr", group = "[r]un" },
    { "<leader>Qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
    { "<leader>Qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
    { "<leader>Qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },
  },
}, { mode = "n" })

-- you are an idiot with a music
local idiot = require("you-are-an-idiot")
vim.api.nvim_create_user_command("ToggleIdiot", function()
  if idiot.is_running() then
    idiot.abort()
  else
    idiot.run()
    vim.cmd([[silent exec "! mpv ~/Music/you.ogg"]])
  end
end, { desc = "Toggles YouAreAnIdiot" })
