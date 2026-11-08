-- Quickfix / location list formatting ('quickfixtextfunc').
local fn = vim.fn

local config = {
  filename_limit = 35,
  use_icons = true,
  relative_paths = true,
  max_text_length = 100,
}

local whitespace_only = "^%s*$"

-- Symbol per quickfix item type
local error_config = {
  E = { symbol = "󰅚", hl = "DiagnosticError" },
  W = { symbol = "󰀪", hl = "DiagnosticWarn" },
  I = { symbol = "󰋽", hl = "DiagnosticInfo" },
  N = { symbol = "󰋼", hl = "DiagnosticHint" },
  H = { symbol = "󰌶", hl = "DiagnosticHint" },
  [""] = { symbol = "", hl = "" }
}

local function get_file_icon(filename)
  if not config.use_icons or not _G.MiniIcons then
    return ""
  end
  return MiniIcons.get("file", filename) .. " "
end

-- Pad to exactly `limit` display cells, or keep the tail and prefix "…".
-- Uses display width, so non-ASCII paths stay aligned and are never split mid-character.
local function fit(str, limit)
  local width = fn.strdisplaywidth(str)
  if width <= limit then
    return str .. string.rep(" ", limit - width)
  end
  local nchars = fn.strchars(str)
  local start = math.max(nchars - (limit - 1), 0)
  local tail = fn.strcharpart(str, start)
  while fn.strdisplaywidth(tail) > limit - 1 do
    start = start + 1
    tail = fn.strcharpart(str, start)
  end
  return "…" .. tail .. string.rep(" ", limit - 1 - fn.strdisplaywidth(tail))
end

-- ":~:." is relative to the *current* cwd, so paths stay right after :cd.
local function format_filename(filepath, limit)
  return fit(fn.fnamemodify(filepath, config.relative_paths and ":~:." or ":~"), limit)
end

-- Trim and shorten the message text
local function format_text(text)
  if not text then return "" end

  -- Fast whitespace trimming
  local trimmed = text:match("^%s*(.-)%s*$") or text

  -- Fast truncation
  if config.max_text_length and #trimmed > config.max_text_length then
    return trimmed:sub(1, config.max_text_length - 1) .. "…"
  end

  return trimmed
end

function _G.qftf(info)
  local items
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  if not items or #items == 0 then
    return {}
  end

  local ret = {}
  local limit = config.filename_limit
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    if not e then
      break
    end

    local text = e.text or ""
    if e.valid ~= 1 then
      -- non-matching lines (e.g. compiler context): keep them as-is
      if not text:match(whitespace_only) then
        ret[#ret + 1] = text
      end
    elseif not (text:match(whitespace_only) and (not e.bufnr or e.bufnr == 0)) then
      local icon, fname = "", string.rep(" ", limit)
      if e.bufnr and e.bufnr > 0 then
        local bufname = fn.bufname(e.bufnr)
        if bufname == "" then
          fname = fit("[No Name]", limit)
        else
          icon = get_file_icon(bufname)
          fname = format_filename(bufname, limit)
        end
      end

      local lnum = (e.lnum and e.lnum > 0) and (e.lnum > 99999 and "99999+" or tostring(e.lnum)) or "-"
      local col = (e.col and e.col > 0) and (e.col > 999 and "999+" or tostring(e.col)) or "-"
      local symbol = (error_config[e.type] or error_config[""]).symbol
      local qtype = symbol ~= "" and (symbol .. " ") or ""

      ret[#ret + 1] = ("%s %s │ %5s:%-3s │ %s%s"):format(icon, fname, lnum, col, qtype, format_text(text))
    end
  end
  return ret
end

vim.o.quickfixtextfunc = "{info -> v:lua._G.qftf(info)}"

vim.api.nvim_create_user_command("QfToggleIcons", function()
  config.use_icons = not config.use_icons
  print("Quickfix icons " .. (config.use_icons and "enabled" or "disabled"))
  vim.cmd("silent! cclose | copen")
end, { desc = "Toggle quickfix file type icons" })

vim.api.nvim_create_user_command("QfToggleRelative", function()
  config.relative_paths = not config.relative_paths
  print("Quickfix relative paths " .. (config.relative_paths and "enabled" or "disabled"))
  vim.cmd("silent! cclose | copen")
end, { desc = "Toggle quickfix relative paths" })
