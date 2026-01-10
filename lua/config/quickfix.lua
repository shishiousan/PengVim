local fn = vim.fn

-- Optimized configuration with performance focus
local config = {
  filename_limit = 35,
  use_icons = true,
  relative_paths = true,
  max_text_length = 100,
  show_severity_colors = true,
}

-- Pre-compiled patterns for better performance
local patterns = {
  home_dir = "^" .. vim.env.HOME:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"),
  whitespace_only = "^%s*$",
}

-- File extension to icon mapping (optimized lookup)
local file_icons = {
  lua = "󰢱", js = "󰌞", ts = "󰛦", jsx = "󰌞", tsx = "󰛦",
  py = "󰌠", go = "󰟓", rs = "󱘗", c = "󰙱", cpp = "󰙲", cc = "󰙲",
  java = "󰬷", html = "󰌝", css = "󰌜", json = "󰘦", xml = "󰗀",
  md = "󰍔", txt = "󰈙", yml = "󰈙", yaml = "󰈙", toml = "󰈙",
  sh = "󱆃", bash = "󱆃", zsh = "󱆃", fish = "󱆃",
  f = "󱈚", f90 = "󱈚", f95 = "󱈚", f03 = "󱈚", f08 = "󱈚", -- Fortran
  default = "󰈙"
}

-- Error type configuration with performance-focused lookup
local error_config = {
  E = { symbol = "󰅚", hl = "DiagnosticError" },
  W = { symbol = "󰀪", hl = "DiagnosticWarn" },
  I = { symbol = "󰋽", hl = "DiagnosticInfo" },
  N = { symbol = "󰋼", hl = "DiagnosticHint" },
  H = { symbol = "󰌶", hl = "DiagnosticHint" },
  [""] = { symbol = "", hl = "" }
}

-- Cache for frequently accessed data
local cache = {
  cwd = nil,
  cwd_len = 0,
  home_replacement = nil,
}

-- Initialize cache
local function init_cache()
  if not cache.cwd then
    cache.cwd = vim.fn.getcwd()
    cache.cwd_len = #cache.cwd
    cache.home_replacement = cache.cwd:gsub(patterns.home_dir, "~")
  end
end

-- Fast file icon lookup
local function get_file_icon(filename)
  if not config.use_icons then return "" end
  
  local ext = filename:match("%.([^%.]+)$")
  if not ext then return file_icons.default end
  
  local icon = file_icons[ext:lower()]
  return icon and (icon .. " ") or (file_icons.default .. " ")
end

-- Optimized path formatting
local function format_filename(filepath, limit)
  if not filepath or filepath == "" then 
    return string.rep(" ", limit)
  end
  
  init_cache()
  
  -- Fast home directory replacement
  local fname = filepath:gsub(patterns.home_dir, "~")
  
  -- Fast relative path conversion
  if config.relative_paths and fname:sub(1, cache.cwd_len) == cache.cwd then
    local relative = fname:sub(cache.cwd_len + 2)
    if relative ~= "" then fname = relative end
  end
  
  -- Fast display width calculation and truncation
  local display_width = #fname -- Simplified for performance - assumes single-byte chars
  
  if display_width <= limit then
    return fname .. string.rep(" ", limit - display_width)
  else
    -- Fast truncation with ellipsis
    local truncate_len = limit - 1
    return "…" .. fname:sub(-truncate_len)
  end
end

-- Optimized text formatting
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

-- Main formatting function - optimized for speed
function _G.qftf(info)
  local items
  
  -- Fast item retrieval
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  
  if not items or #items == 0 then return {} end
  
  local ret = {}
  local limit = config.filename_limit
  
  -- Pre-calculate format string to avoid repeated string operations
  local validFmt = "%s%s %s │ %5s:%-3s │ %s%s"
  
  -- Process only the requested range for better performance
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    if not e then break end
    
    -- Fast validity and content check
    if e.valid ~= 1 then
      local text = e.text
      if text and not text:match(patterns.whitespace_only) then
        ret[#ret + 1] = text
      end
      goto continue
    end
    
    -- Fast empty entry detection
    local text = e.text or ""
    if text:match(patterns.whitespace_only) and (not e.bufnr or e.bufnr == 0) then
      goto continue
    end
    
    -- Efficient filename processing
    local fname = ""
    local icon = ""
    
    if e.bufnr and e.bufnr > 0 then
      local bufname = fn.bufname(e.bufnr)
      if bufname == "" then
        fname = "[No Name]"
      else
        icon = get_file_icon(bufname)
        fname = format_filename(bufname, limit)
      end
    else
      fname = string.rep(" ", limit)
    end
    
    -- Fast number formatting
    local lnum = (e.lnum and e.lnum > 0) and (e.lnum > 99999 and "99999+" or tostring(e.lnum)) or "-"
    local col = (e.col and e.col > 0) and (e.col > 999 and "999+" or tostring(e.col)) or "-"
    
    -- Fast error type lookup
    local error_info = error_config[e.type] or error_config[""]
    local qtype = error_info.symbol ~= "" and (error_info.symbol .. " ") or ""
    
    -- Fast text formatting
    local formatted_text = format_text(text)
    
    -- Single format operation
    ret[#ret + 1] = validFmt:format("", icon, fname, lnum, col, qtype, formatted_text)
    
    ::continue::
  end
  
  return ret
end

-- Set the quickfix text function
vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

-- Optimized toggle commands
vim.api.nvim_create_user_command("QfToggleIcons", function()
  config.use_icons = not config.use_icons
  print("Quickfix icons " .. (config.use_icons and "enabled" or "disabled"))
  vim.cmd("silent! cclose | copen")
end, { desc = "Toggle quickfix file type icons" })

vim.api.nvim_create_user_command("QfToggleRelative", function()
  config.relative_paths = not config.relative_paths
  cache.cwd = nil -- Reset cache
  print("Quickfix relative paths " .. (config.relative_paths and "enabled" or "disabled"))
  vim.cmd("silent! cclose | copen")
end, { desc = "Toggle quickfix relative paths" })

-- Performance monitoring command (optional)
vim.api.nvim_create_user_command("QfProfile", function()
  local start_time = vim.loop.hrtime()
  local items = vim.fn.getqflist()
  local info = { start_idx = 1, end_idx = #items, quickfix = 1, id = 0 }
  local result = _G.qftf(info)
  local end_time = vim.loop.hrtime()
  local elapsed_ms = (end_time - start_time) / 1000000
  print(string.format("Formatted %d items in %.2f ms", #result, elapsed_ms))
end, { desc = "Profile quickfix formatting performance" })
